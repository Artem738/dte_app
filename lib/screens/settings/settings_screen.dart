import 'package:flutter/material.dart';
import 'package:dte_app/screens/drawer_menu.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Text('Settings Page'),
      ),
      endDrawer: const DrawerMenu(),
    );
  }
}
