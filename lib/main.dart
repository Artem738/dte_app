import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dte_app/app_state_manager.dart';
import 'package:dte_app/my_app.dart';
import 'package:dte_app/providers/menu_provider.dart';
import 'package:dte_app/providers/route_provider.dart';



void main() {
  // Устанавливаем debugShowCheckedModeBanner в false до запуска приложения
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(AppStateManager(
    child: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RouteProvider()),
        ChangeNotifierProvider(
          create: (context) => MenuProvider(context.read<RouteProvider>()),
        ),
      ],
      child: const MyApp(),
    ),
  ));
}


