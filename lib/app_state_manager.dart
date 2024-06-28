import 'package:flutter/material.dart';

class AppStateManager extends StatefulWidget {
  final Widget child;

  AppStateManager({required this.child});

  static void restartApp(BuildContext context) {
    final _AppStateManagerState? state = context.findAncestorStateOfType<_AppStateManagerState>();
    state?.restartApp();
  }

  static void changeTheme(BuildContext context) {
    final _AppStateManagerState? state = context.findAncestorStateOfType<_AppStateManagerState>();
    state?.changeTheme();
  }

  static void changeLanguage(BuildContext context) {
    final _AppStateManagerState? state = context.findAncestorStateOfType<_AppStateManagerState>();
    state?.changeLanguage();
  }

  @override
  _AppStateManagerState createState() => _AppStateManagerState();
}

class _AppStateManagerState extends State<AppStateManager> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey(); // Генерируем новый ключ, чтобы обновить виджет
    });
  }

  void changeTheme() {
    // Логика изменения темы
    setState(() {
      // Обновление состояния для применения новой темы
    });
  }

  void changeLanguage() {
    // Логика изменения языка
    setState(() {
      // Обновление состояния для применения нового языка
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}