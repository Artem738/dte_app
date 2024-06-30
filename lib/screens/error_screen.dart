import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  ErrorScreen({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ошибка'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onRetry,
              child: Text('Попробовать снова'),
            ),
          ],
        ),
      ),
    );
  }
}
