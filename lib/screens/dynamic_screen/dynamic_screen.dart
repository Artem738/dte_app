import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:dte_app/providers/menu_provider.dart';
import 'package:dte_app/screens/drawer_menu.dart';
import 'package:dte_app/screens/tech_screens/error_screen.dart';
import 'package:dte_app/screens/tech_screens/loading_screen.dart';

class DynamicScreen extends StatelessWidget {
  final String pageName;
  final String path;
  final String pageType;
  final String pagePathName;

  const DynamicScreen({
    super.key,
    required this.pageName,
    required this.path,
    required this.pageType,
    required this.pagePathName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: (pageType == "page")
            ? IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  context.go('/'); // home route
                },
              )
            : null,
        title: Text(pageName),
      ),
      body: FutureBuilder(
        future: Provider.of<MenuProvider>(context, listen: false).fetchContent(pageName, path, pageType, pagePathName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: LoadingScreen(),
            );
          } else if (snapshot.hasError) {
            return ErrorScreen(errorMessage: snapshot.error.toString());
          } else {
            final content = Provider.of<MenuProvider>(context).content;
            return Center(
              child: Text(
                'Dynamic Content for $pageName\n'
                'Page Type: $pageType\n'
                'Content: ${content.toString()}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            );
          }
        },
      ),
      endDrawer: const DrawerMenu(),
    );
  }
}
