import 'package:dte_app/content/content_model.dart';
import 'package:dte_app/content/content_provider.dart';
import 'package:dte_app/my_app.dart';
import 'package:dte_app/route/independent_routes.dart';
import 'package:dte_app/route/route_model.dart';
import 'package:dte_app/route/route_provider.dart';
import 'package:dte_app/screens/error_app.dart';
import 'package:dte_app/screens/loading_app.dart';
import 'package:dte_app/templates/template_model.dart';
import 'package:dte_app/templates/template_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const LoadingApp());

  try {
    // Инициализируем провайдеры
    final routeProvider = RouteProvider();
    final contentProvider = ContentProvider();
    final templateProvider = TemplateProvider();

    // Загружаем данные
    List<RouteModel> routes = await RouteProvider.fetchRoutData('uk');
    Map<String, ContentModel> content = await ContentProvider.fetchContentData('uk');
    Map<String, List<TemplateModel>> templates = await TemplateProvider.fetchTemplateData();

    // Устанавливаем данные в провайдеры
    contentProvider.setContent(content);
    templateProvider.setTemplates(templates);
    routeProvider.setRoutes(routes);
    routeProvider.addIndependentRoutes(independentRoutes); // Добавляем независимые роуты

    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => routeProvider),
        ChangeNotifierProvider(create: (_) => contentProvider),
        ChangeNotifierProvider(create: (_) => templateProvider),
      ],
      child: MyApp(routes: routes), // Передаем routes в MyApp
    ));
  } catch (error) {
    runApp(ErrorApp(errorMessage: 'Ошибка загрузки данных. Пожалуйста, попробуйте снова.'));
  }
}





