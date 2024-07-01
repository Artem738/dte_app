import 'dart:convert';

import 'package:dte_app/env_config.dart';
import 'package:dte_app/screens/dynamic_page.dart';
import 'package:flutter/material.dart';
import 'route_model.dart';
import 'package:http/http.dart' as http;

class RouteProvider with ChangeNotifier {
  List<RouteModel> _routes = [];

  List<RouteModel> get routes => _routes;


  static Future<List<RouteModel>>  fetchRoutData() async {
    String url = '${EnvConfig.mainApiUrl}api/menu/en';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => RouteModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  void setRoutes(List<RouteModel> routes) {
    _routes = routes;
    notifyListeners();
  }

  Route<dynamic>? generateRoute(RouteSettings settings, List<RouteModel> routes) {
    for (var route in routes) {
      if (settings.name == route.path) {
        if (route.builder != null) {
          return MaterialPageRoute(
            builder: (context) => route.builder!(context, settings),
          );
        } else {
          return MaterialPageRoute(
            builder: (context) => DynamicPage(routeModel: route),
          );
        }
      }
      if (route.subRoutes != null) {
        for (var subRoute in route.subRoutes!) {
          if (settings.name == '${route.path}/${subRoute.path}') {
            if (subRoute.builder != null) {
              return MaterialPageRoute(
                builder: (context) => subRoute.builder!(context, settings),
              );
            } else {
              return MaterialPageRoute(
                builder: (context) => DynamicPage(routeModel: subRoute),
              );
            }
          }
        }
      }
    }
    return null;
  }




  List<Map<String, dynamic>> getMenuItems() {
    return _routes.map((route) {
      return {
        'path': route.path,
        'pageType': route.pageType,
        'pageName': route.pageName,
        'pagePathName': route.pagePathName,
        'subRoutes': route.subRoutes?.map((subRoute) {
          return {
            'path': '${route.path}/${subRoute.path}',
            'pageType': route.pageType,
            'pagePathName': route.pagePathName,
            'pageName': subRoute.pageName,
          };
        }).toList()
      };
    }).toList();
  }

  void addIndependentRoutes(List<Map<String, dynamic>> independentRoutes) {
    final newRoutes = independentRoutes.map((routeData) {
      return RouteModel(
        path: routeData['path'],
        pageName: routeData['pageName'],
        pageType: routeData['pageType'], // можно задать значение по умолчанию или взять из данных
        pagePathName: routeData['pagePathName'],
        builder: routeData['builder'],
      );
    }).toList();

    _routes.addAll(newRoutes);
    notifyListeners();
  }

}
