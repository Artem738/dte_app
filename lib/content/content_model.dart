import 'package:flutter/material.dart';

class ContentModel {
  final String pagePathName;
  final Map<String, dynamic> content;

  ContentModel({
    required this.pagePathName,
    required this.content,
  });

  factory ContentModel.fromJson(String pagePathName, Map<String, dynamic> json) {
    return ContentModel(
      pagePathName: pagePathName,
      content: json,
    );
  }
}
