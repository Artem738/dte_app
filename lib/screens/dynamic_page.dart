import 'package:dte_app/route/route_model.dart';
import 'package:dte_app/screens/draver_menu.dart';
import 'package:flutter/material.dart';


class DynamicPage extends StatelessWidget {
  final RouteModel routeModel;

  DynamicPage({required this.routeModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(routeModel.pageName),
      ),
      drawer: DrawerMenu(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is the "${routeModel.pageName}" page'),
            Text('Path: "${routeModel.path}"'),
            Text('Page Path Name: "${routeModel.pagePathName}"'),
          ],
        ),
      ),
    );
  }
}
