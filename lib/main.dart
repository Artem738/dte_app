import 'package:dte_app/route/route_model.dart';
import 'package:dte_app/route/route_provider.dart';
import 'package:dte_app/screens/dynamic_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'env_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<RouteModel> routes = await fetchData();
  runApp(MyApp(routes: routes));
}

Future<List<RouteModel>> fetchData() async {
  String url = '${EnvConfig.mainApiUrl}api/menu/ru';
  final response = await http.get(Uri.parse(url));
  print(response.body);

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => RouteModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load data');
  }
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
          return _generateRoute(settings, routes);
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (context) => UnknownPage());
        },
      ),
    );
  }

  Route<dynamic>? _generateRoute(RouteSettings settings, List<RouteModel> routes) {
    for (var route in routes) {
      if (settings.name == route.path) {
        return MaterialPageRoute(
          builder: (context) => DynamicPage(routeModel: route),
        );
      }
      if (route.subRoutes != null) {
        for (var subRoute in route.subRoutes!) {
          if (settings.name == '${route.path}/${subRoute.path}') {
            return MaterialPageRoute(
              builder: (context) => DynamicPage(routeModel: subRoute),
            );
          }
        }
      }
    }
    return null;
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
