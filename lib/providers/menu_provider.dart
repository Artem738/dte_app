import 'package:flutter/foundation.dart';
import 'package:dte_app/env_config.dart';
import 'package:dte_app/http/api_request.dart';
import 'package:dte_app/providers/route_provider.dart';
import 'dart:convert';

class MenuProvider with ChangeNotifier {
  static const String mainApiUrl = EnvConfig.mainApiUrl;

  final RouteProvider routeProvider;

  MenuProvider(this.routeProvider);

  Map<String, dynamic> _content = {};

  Map<String, dynamic> get content => _content;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<void> fetchMenu() async {
    const url = '${mainApiUrl}api/menu/ru';
    final response = await makeApiRequest(url);

    if (response.success) {
      try {
        List<dynamic> jsonData = json.decode(response.data);
        bool isError = false;

        List<dynamic> updatedContentData = jsonData.map((item) {
          final subRoutes = item['subRoutes'] != null
              ? List<dynamic>.from(item['subRoutes'].map((subItem) {
            return {
              'path': subItem['path'] ?? (isError = true),
              'pageName': subItem['pageName'] ?? (isError = true),
              'pageType': subItem['pageType'] ?? (isError = true),
              'pagePathName': subItem['pagePathName'] ?? (isError = true),
            };
          }))
              : [];

          return {
            'path': item['path'] ?? (isError = true),
            'pageName': item['pageName'] ?? (isError = true),
            'pageType': item['pageType'] ?? (isError = true),
            'pagePathName': item['pagePathName'] ?? (isError = true),
            'subRoutes': subRoutes,
          };
        }).toList();

        if (isError) {
          throw Exception('Data is corrupted');
        }

        routeProvider.updateContentData(updatedContentData);
        _errorMessage = null;
      } catch (e) {
        _errorMessage = 'Failed to parse data: ${e.toString()}';
      }
    } else {
      _errorMessage = response.errorMessage ?? 'Unknown error';
    }
    notifyListeners();
  }

  Future<void> fetchContent(String pageName, String routeAdr, String pageType, String pagePathName) async {
    final url = '${mainApiUrl}api/content/$pageType/$pagePathName';
    final response = await makeApiRequest(url);
    if (response.success) {
      try {
        _content = json.decode(response.data);
        _errorMessage = null;
        notifyListeners();
      } catch (e) {
        _errorMessage = 'Failed to parse content: ${e.toString()}';
        notifyListeners();
      }
    } else {
      _errorMessage = response.errorMessage ?? 'Unknown error';
      notifyListeners();
    }
  }
}
