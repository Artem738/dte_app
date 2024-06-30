import 'package:dte_app/route/route_model.dart';
import 'package:dte_app/route/route_provider.dart';
import 'package:dte_app/screens/dynamic_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:convert';
import 'env_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<RouteModel> routes = await RouteProvider.fetchData();
  runApp(MyApp(routes: routes));
}



class MyApp extends StatelessWidget {
  final List<RouteModel> routes;

  MyApp({required this.routes});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RouteProvider()..setRoutes(routes),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: EnvConfig.showDebugUpRightBanner,
        title: 'Dynamic Routes App',
        initialRoute: '/',
        onGenerateRoute: (settings) {
          return RouteProvider().generateRoute(settings, routes);
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (context) => UnknownPage());
        },
      ),
    );
  }


}

class UnknownPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Unknown Page')),
      body: Center(child: Text('404 - Page Not Found')),
    );
  }
}
