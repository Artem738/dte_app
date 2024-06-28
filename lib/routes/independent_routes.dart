import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:dte_app/providers/route_provider.dart';
import 'package:dte_app/screens/details/details_screen.dart';
import 'package:dte_app/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';

void initializeIndependentRoutes(BuildContext context) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    final routeProvider = context.read<RouteProvider>();

    // Add independent routes
    routeProvider.addIndependentRoute({
      "path": "/settings",
      "widget": (context, state) => SettingsScreen(),
      "pageName": "Settings",
      "pagePathName": "settings",
    });

    routeProvider.addIndependentRoute({
      "path": "/about",
      "widget": (context, state) => DetailsScreen(),
      "pageName": "About",
      "pagePathName": "about",
    });
  });
}
