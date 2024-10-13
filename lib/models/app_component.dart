import 'package:collection/collection.dart';
import 'package:product_management/models/attribute.dart';

enum ComponentType {
  Label,
  ProductSubmitForm,
  Button,
  ProductList;

  static ComponentType? valueOf(String? value) =>
      ComponentType.values.firstWhereOrNull(
        (element) => element.name == value,
      );
}

class AppComponent {
  final ComponentType type;
  final Attribute attribute;

  AppComponent({required this.type, required this.attribute});
  factory AppComponent.fromJson(Map<String, dynamic> json) {
    var type = ComponentType.valueOf(json['type']) ?? ComponentType.Label;
    return AppComponent(
        type: type,
        attribute: getAttributeByType(type, json['customAttributes']));
  }
  AppComponent copyWith({
    ComponentType? type,
    Attribute? attribute,
  }) =>
      AppComponent(
        type: type ?? this.type,
        attribute: attribute ?? this.attribute,
      );
}

Attribute getAttributeByType(ComponentType type, Map<String, dynamic> json) {
  switch (type) {
    case ComponentType.Label:
      return LabelAttribute.fromJson(json['label']);
    case ComponentType.ProductSubmitForm:
      return FormAttribute.fromJson(json);
    case ComponentType.Button:
      return ButtonAttribute.fromJson(json['button']);
    case ComponentType.ProductList:
      return ProductListAttribute.fromJson(json['productlist']);
  }
}
