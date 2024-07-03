// widget_factory.dart
import 'package:dte_app/widgets/text/main_title_subtitle_center.dart';
import 'package:dte_app/widgets/text/text_2col_notitle.dart';
import 'package:flutter/material.dart';


typedef WidgetCreator = Widget Function(Map<String, dynamic>);

final Map<String, WidgetCreator> widgetRegistry = {
  'components.text.main_title_subtitle_center': (data) => MainTitleSubtitleCenter(data: data),
  'components.text.text_2col_notitle': (data) => Text2ColNoTitle(data: data),
  // Зарегистрируйте другие виджеты здесь
};

Widget? createWidget(String componentName, Map<String, dynamic> componentData, Map<String, dynamic> content) {
  final widgetCreator = widgetRegistry[componentName];
  if (widgetCreator != null) {
    // Объединяем componentData и content для передачи в виджет
    final combinedData = {...componentData, ...content};
    return widgetCreator(combinedData);
  } else {
    print('Widget for $componentName not found');
    return null;
  }
}
