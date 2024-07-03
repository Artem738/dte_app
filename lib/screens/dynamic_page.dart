import 'package:dte_app/templates/template_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dte_app/content/content_provider.dart';
import 'package:dte_app/route/route_model.dart';
import 'package:dte_app/screens/draver_menu.dart';
import 'package:dte_app/templates/template_provider.dart';
import 'widget_factory.dart';

class DynamicPage extends StatelessWidget {
  final RouteModel routeModel;

  DynamicPage({required this.routeModel});

  @override
  Widget build(BuildContext context) {
    final contentProvider = context.read<ContentProvider>();
    final templateProvider = context.read<TemplateProvider>();

    final content = contentProvider.content[routeModel.pagePathName]?.content['content'] ?? {};
    final List<TemplateModel>? templates = templateProvider.templates[routeModel.pagePathName];

    return Scaffold(
      appBar: AppBar(
        leading: (routeModel.pageType == "page")
            ? IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        )
            : null,
        title: Text(routeModel.pageName),
      ),
      endDrawer: DrawerMenu(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: templates?.map((template) {
                return createWidget(template.componentName, template.componentData, content) ?? SizedBox.shrink();
              }).toList() ?? [],
            ),
          ),
        ),
      ),
    );
  }
}
