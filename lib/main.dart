import 'package:dte_app/content/content_model.dart';
import 'package:dte_app/content/content_provider.dart';
import 'package:dte_app/env_config.dart';
import 'package:dte_app/my_app.dart';
import 'package:dte_app/route/route_model.dart';
import 'package:dte_app/route/route_provider.dart';
import 'package:dte_app/screens/error_app.dart';
import 'package:dte_app/screens/loading_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const LoadingApp());

  try {
    final routeProvider = RouteProvider();
    final contentProvider = ContentProvider();
    List<RouteModel> routes = await RouteProvider.fetchRoutData();
    Map<String, ContentModel> content = await ContentProvider.fetchContentData('ru');

    contentProvider.setContent(content); // Устанавливаем контент в провайдер

    // Отладочный вывод
    print(contentProvider.content.toString());

    routeProvider.setRoutes(routes);
    routeProvider.addIndependentRoutes([
      {
        'path': '/settings',
        'pageName': 'Settings',
        'pagePathName': 'settings',
        'pageType': 'page',
        'builder': (context, state) => SettingsScreen(),
      },
      {
        'path': '/profile',
        'pageName': 'Profile',
        'pagePathName': 'profile',
        'pageType': 'page',
        'builder': (context, state) => ProfileScreen(),
      },
    ]);

    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => routeProvider),
        ChangeNotifierProvider(create: (_) => contentProvider),
      ],
      child: MyApp(routes: routes), // Передаем routes в MyApp
    ));
  } catch (error) {
    runApp(ErrorApp(errorMessage: 'Ошибка загрузки данных. Пожалуйста, попробуйте снова.'));
  }
}



class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Center(
        child: Column(
          children: [
            Text('This is the Settings Screen'),
            ElevatedButton(
              child: Text("Restart App"),
              onPressed: () {
                // Перезапуск приложения
                main();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(child: Text('This is the Profile Screen')),
    );
  }
}
