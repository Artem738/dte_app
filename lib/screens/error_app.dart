import 'package:dte_app/main.dart';
import 'package:flutter/material.dart';

class ErrorApp extends StatelessWidget {
  final String errorMessage;

  ErrorApp({required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Ошибка'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Перезапуск приложения
                  main();
                },
                child: Text('Попробовать снова'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
