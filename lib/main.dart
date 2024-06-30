import 'package:dte_app/my_app.dart';
import 'package:dte_app/route/route_model.dart';
import 'package:dte_app/route/route_provider.dart';
import 'package:dte_app/screens/error_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    List<RouteModel> routes = await RouteProvider.fetchRoutData();

    final routeProvider = RouteProvider();
    routeProvider.setRoutes(routes);

    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => routeProvider),
      ],
      child: MyApp(routes: routes), // Передаем routes в MyApp
    ));
  } catch (error) {
    runApp(ErrorApp(errorMessage: 'Ошибка загрузки данных. Пожалуйста, попробуйте снова.'));
  }
}

