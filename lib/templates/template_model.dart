

class TemplateModel {
  final String componentName;
  final Map<String, dynamic> componentData;

  TemplateModel({
    required this.componentName,
    required this.componentData,
  });

  factory TemplateModel.fromJson(String componentName, Map<String, dynamic> json) {
    return TemplateModel(
      componentName: componentName,
      componentData: json,
    );
  }
}