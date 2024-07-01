import 'package:flutter/material.dart';

class RouteModel {
  final String path;
  final String pageName;
  final String pageType;
  final String pagePathName;
  final List<RouteModel>? subRoutes;
  final Widget Function(BuildContext, RouteSettings)? builder;

  RouteModel({
    required this.path,
    required this.pageName,
    required this.pageType,
    required this.pagePathName,
    this.subRoutes,
    this.builder,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      path: json['path'],
      pageName: json['pageName'],
      pageType: json['pageType'],
      pagePathName: json['pagePathName'],
      subRoutes: json['subRoutes'] != null
          ? (json['subRoutes'] as List)
          .map((i) => RouteModel.fromJson(i))
          .toList()
          : null,
      builder: null, // builder не из JSON, добавляется позже
    );
  }
}
