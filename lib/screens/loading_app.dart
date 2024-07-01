import 'package:dte_app/env_config.dart';
import 'package:flutter/material.dart';

class LoadingApp extends StatelessWidget {
  const LoadingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: EnvConfig.showDebugUpRightBanner,
      home: Scaffold(
        body: Center(
            child: SizedBox(
          height: 100,
          width: 100,
          child: FittedBox(
            child: CircularProgressIndicator(),
          ),
        )),
      ),
    );
  }
}
