
import 'package:dte_app/main.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Center(
        child: Column(
          children: [
            Text('This is the Settings Screen'),
            ElevatedButton(
              child: Text("Restart App"),
              onPressed: () {
                // Перезапуск приложения
                main();
              },
            ),
          ],
        ),
      ),
    );
  }
}