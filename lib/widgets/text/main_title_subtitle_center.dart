// main_title_subtitle_center.dart
import 'package:flutter/material.dart';

class MainTitleSubtitleCenter extends StatelessWidget {
  final Map<String, dynamic> data;

  MainTitleSubtitleCenter({required this.data});

  @override
  Widget build(BuildContext context) {
    //print(data);
    //print(content['content']['title'].toString());

    final title = data['title'] ?? '';
    final subtitle = data['subtitle'] ?? '';

    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Text(
          subtitle,
          style: TextStyle(fontSize: 17),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
