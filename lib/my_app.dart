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

class NewPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Page 1')),
      body: Center(child: Text('This is New Page 1')),
    );
  }
}

class NewPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Page 2')),
      body: Center(child: Text('This is New Page 2')),
    );
  }
}
