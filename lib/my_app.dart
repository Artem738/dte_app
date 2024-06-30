import 'package:dte_app/env_config.dart';
import 'package:dte_app/route/route_model.dart';
import 'package:dte_app/route/route_provider.dart';
import 'package:dte_app/screens/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  final List<RouteModel> routes;

  MyApp({required this.routes});

  @override
  Widget build(BuildContext context) {
    return Consumer<RouteProvider>(
      builder: (context, routeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: EnvConfig.showDebugUpRightBanner,
          title: 'Dynamic Routes App',
          initialRoute: '/',
          onGenerateRoute: (settings) {
            // Используем существующий routeProvider и передаем маршруты
            return routeProvider.generateRoute(settings, routes);
          },
          onUnknownRoute: (settings) {
            return MaterialPageRoute(builder: (context) => ErrorScreen(message: 'Страница не найдена', onRetry: () {}));
          },
        );
      },
    );
  }
}
