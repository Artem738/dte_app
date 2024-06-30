import 'package:flutter/material.dart';
import 'route_model.dart';

class RouteProvider with ChangeNotifier {
  List<RouteModel> _routes = [];

  List<RouteModel> get routes => _routes;

  void setRoutes(List<RouteModel> routes) {
    _routes = routes;
    notifyListeners();
  }

  List<Map<String, dynamic>> getMenuItems() {
    return _routes.map((route) {
      return {
        'path': route.path,
        'pageName': route.pageName,
        'subRoutes': route.subRoutes?.map((subRoute) {
          return {
            'path': '${route.path}/${subRoute.path}',
            'pageName': subRoute.pageName,
          };
        }).toList()
      };
    }).toList();
  }
}
