import 'package:dte_app/content/content_provider.dart';
import 'package:dte_app/route/route_model.dart';
import 'package:dte_app/screens/draver_menu.dart';
import 'package:dte_app/templates/template_model.dart';
import 'package:dte_app/templates/template_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DynamicPage extends StatelessWidget {
  final RouteModel routeModel;

  DynamicPage({required this.routeModel});

  @override
  Widget build(BuildContext context) {
    final contentProvider = context.read<ContentProvider>();
    final templateProvider = context.read<TemplateProvider>();

    final contentModel = contentProvider.content[routeModel.pagePathName];
    final content = contentModel?.content['content'] ?? {};

    final List<TemplateModel>? templates = templateProvider.templates[routeModel.pagePathName];

    return Scaffold(
      appBar: AppBar(
        title: Text(routeModel.pageName),
      ),
      drawer: DrawerMenu(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text('This is the "${routeModel.pageName}" page'),
              // Text('Path: "${routeModel.path}"'),
              // Text('Page Path Name: "${routeModel.pagePathName}"'),
              // Text('Page Type: "${routeModel.pageType}"'),
              //...content.entries.map((entry) => Text('${entry.key}: ${entry.value}')).toList(),
              ...?templates?.map((template) {
                return Column(
                  children: [
                    Text('Component Name: ${template.componentName}'),
                    Text('Component Data: ${template.componentData.toString()}'),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
