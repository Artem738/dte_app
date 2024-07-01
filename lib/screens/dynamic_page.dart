import 'package:dte_app/content/content_provider.dart';
import 'package:dte_app/route/route_model.dart';
import 'package:dte_app/screens/draver_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DynamicPage extends StatelessWidget {
  final RouteModel routeModel;

  DynamicPage({required this.routeModel});

  @override
  Widget build(BuildContext context) {
    final contentProvider = context.read<ContentProvider>();
    final contentModel = contentProvider.content[routeModel.pagePathName];

    // Убедимся, что contentModel не null, и назначим его содержимое переменной content
    final content = contentModel?.content['content'] ?? {};

    // Отладочный вывод
    //print('Content Model for ${routeModel.pagePathName}: ${content.toString()}');

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
              Text('This is the "${routeModel.pageName}" page'),
              Text('Path: "${routeModel.path}"'),
              Text('Page Path Name: "${routeModel.pagePathName}"'),
              Text('Page Type: "${routeModel.pageType}"'),
              ...content.entries.map((entry) => Text('${entry.key}: ${entry.value}')).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
