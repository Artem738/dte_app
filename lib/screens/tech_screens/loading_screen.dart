import 'package:flutter/material.dart';
import 'dart:async';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _showAvatar = false;

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  void _startDelay() {
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) { // Проверка, что виджет все еще в дереве виджетов
        setState(() {
          _showAvatar = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _showAvatar
            ? Container(
          height: 100,
          width: 100,
          child: const FittedBox(
            child: CircularProgressIndicator(),
          ),
        )
            : Container(), // Пустой экран
      ),
    );
  }
}
