import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dte_app/env_config.dart';
import 'package:dte_app/providers/menu_provider.dart';
import 'package:dte_app/providers/route_provider.dart';
import 'package:dte_app/routes/app_routes.dart';
import 'package:dte_app/routes/independent_routes.dart';
import 'package:dte_app/screens/tech_screens/error_screen.dart';
import 'package:dte_app/screens/tech_screens/loading_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const bool showDebugBanner = EnvConfig.showDebugUpRightBanner;

  @override
  void initState() {
    super.initState();
    initializeIndependentRoutes(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<MenuProvider>().fetchMenu(),
      builder: (context, snapshot) {
        final errorMessage = context.read<MenuProvider>().errorMessage;

        if (snapshot.connectionState != ConnectionState.done) {
          return const MaterialApp(
            debugShowCheckedModeBanner: showDebugBanner,
            home: LoadingScreen(),
          );
        }

        if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: showDebugBanner,
            home: ErrorScreen(errorMessage: snapshot.error.toString()),
          );
        }

        if (errorMessage != null) {
          return MaterialApp(
            debugShowCheckedModeBanner: showDebugBanner,
            home: ErrorScreen(errorMessage: errorMessage),
          );
        }

        return MaterialApp.router(
          debugShowCheckedModeBanner: showDebugBanner,
          routerConfig: AppRoutes.createRouter(context.read<RouteProvider>()),
        );
      },
    );
  }
}
