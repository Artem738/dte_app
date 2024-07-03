import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'template_model.dart';
import 'package:dte_app/env_config.dart';

class TemplateProvider with ChangeNotifier {
  Map<String, List<TemplateModel>> _templates = {};

  Map<String, List<TemplateModel>> get templates => _templates;

  static Future<Map<String, List<TemplateModel>>> fetchTemplateData() async {
    String url = '${EnvConfig.mainApiUrl}api/all/templates';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data.map((pageName, value) {
        List<dynamic> templatesList = value['template'];
        List<TemplateModel> templates = templatesList.map((template) {
          String componentName = template[0];
          Map<String, dynamic> componentData = template[1];
          return TemplateModel.fromJson(componentName, componentData);
        }).toList();
        return MapEntry(pageName, templates);
      });
    } else {
      throw Exception('Failed to load template data');
    }
  }

  void setTemplates(Map<String, List<TemplateModel>> templates) {
    _templates = templates;
    notifyListeners();
  }

  void addTemplate(String pageName, TemplateModel template) {
    if (_templates.containsKey(pageName)) {
      _templates[pageName]!.add(template);
    } else {
      _templates[pageName] = [template];
    }
    notifyListeners();
  }
}
