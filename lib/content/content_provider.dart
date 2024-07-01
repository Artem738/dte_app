import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'content_model.dart';
import 'package:dte_app/env_config.dart';

class ContentProvider with ChangeNotifier {
  Map<String, ContentModel> _content = {};

  Map<String, ContentModel> get content => _content;

  static Future<Map<String, ContentModel>> fetchContentData(String lang) async {
    String url = '${EnvConfig.mainApiUrl}api/full-content/$lang';
    final response = await http.get(Uri.parse(url));
   // print(response.body);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data.map((key, value) => MapEntry(
        key,
        ContentModel.fromJson(key, value),
      ));
    } else {
      throw Exception('Failed to load content data');
    }
  }

  void setContent(Map<String, ContentModel> content) {
    _content = content;
    notifyListeners();
  }

  void addContent(Map<String, dynamic> newContent, String pagePathName) {
    _content[pagePathName] = ContentModel.fromJson(pagePathName, newContent);
    notifyListeners();
  }
}
