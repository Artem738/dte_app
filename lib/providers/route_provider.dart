import 'package:flutter/foundation.dart';

class RouteProvider with ChangeNotifier {
  List<dynamic> _menuData = [];
  final List<Map<String, dynamic>> _independentRoutes = [];

  List<dynamic> get menuData => _menuData;

  List<Map<String, dynamic>> get independentRoutes => _independentRoutes;

  void updateContentData(List<dynamic> newContentData) {
    _menuData = newContentData;
    notifyListeners();
  }

  void addIndependentRoute(Map<String, dynamic> route) {
    _independentRoutes.add(route);
    notifyListeners();
  }

  List<Map<String, dynamic>> getMenuItems() {
    List<Map<String, dynamic>> menuItems = [
      ..._menuData.map((route) => {
            "path": route["path"],
            "pageName": route["pageName"],
            "pageType": route["pageType"],
            "pagePathName": route["pagePathName"],
            "subRoutes": route["subRoutes"] ?? [],
          }),
      ..._independentRoutes.map((route) => {
            "path": route["path"],
            "pageName": route["pageName"],
            "pageType": route["pageType"],
            "pagePathName": route["pagePathName"],
            "subRoutes": [],
          }),
    ];
    return menuItems;
  }
}
