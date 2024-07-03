// text_2col_notitle.dart
import 'package:flutter/material.dart';

class Text2ColNoTitle extends StatelessWidget {
  final Map<String, dynamic> data;

  Text2ColNoTitle({required this.data});

  @override
  Widget build(BuildContext context) {
    final textColLeft = data['text_col_left'] ?? '';
    final textColRight = data['text_col_right'] ?? '';

    return Row(
      children: [
        Expanded(
          child: Text(textColLeft),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(textColRight),
        ),
      ],
    );
  }
}
