import 'package:product_management/models/form_field.dart';
import 'package:product_management/models/product.dart';

FieldProperties getFieldPropertiesByType(
    FieldType? type, Map<String, dynamic> json) {
  switch (type) {
    case FieldType.text:
      return TextFieldProperties.fromJson(json);
    case FieldType.number:
      return NumberFieldProperties.fromJson(json);
    case FieldType.file_upload:
      return ImageFieldProperties.fromJson(json);
    case null:
      return TextFieldProperties.fromJson(json);
  }
}

class Attribute {}

class LabelAttribute extends Attribute {
  final String text;

  LabelAttribute(this.text);

  factory LabelAttribute.fromJson(Map<String, dynamic> json) =>
      LabelAttribute(json["text"]);
}

class FormAttribute extends Attribute {
  final List<FieldProperties> form;

  FormAttribute(this.form);
  factory FormAttribute.fromJson(Map<String, dynamic> json) =>
      FormAttribute(List<Map<String, dynamic>>.from(json["form"])
          .map(
            (e) => getFieldPropertiesByType(FieldType.valueOf(e['type']), e),
          )
          .toList());
}

class ButtonAttribute extends Attribute {
  final String text;
  ButtonAttribute(this.text);
  factory ButtonAttribute.fromJson(Map<String, dynamic> json) {
    return ButtonAttribute(
      json['text'],
    );
  }
}

class ProductListAttribute extends Attribute {
  final List<Product> products;
  ProductListAttribute(this.products);
  factory ProductListAttribute.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;
    List<Product> products = list.map((i) => Product.fromJson(i)).toList();
    return ProductListAttribute(products);
  }
}
