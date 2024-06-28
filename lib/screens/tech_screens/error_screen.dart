import 'package:flutter/material.dart';
import 'package:dte_app/app_state_manager.dart';
import 'package:dte_app/main.dart'; // Импортируем main.dart для доступа к RestartWidget

class ErrorScreen extends StatelessWidget {
  final String errorMessage;

  const ErrorScreen({Key? key, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Some Error'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(errorMessage, textAlign: TextAlign.center,),
              ElevatedButton(
                onPressed: () {
                  AppStateManager.restartApp(context); // Вызываем функцию перезагрузки
                },
                child: Text('Restart'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
