import 'package:collection/collection.dart';



enum FieldType {
  text,
  number,
  file_upload;

  static FieldType? valueOf(String? value) => FieldType.values.firstWhereOrNull(
        (element) => element.name == value,
      );
}

class FieldProperties {
  final String label;
  final String name;
  final bool required;

  FieldProperties({required this.label, required this.name,this.required = false, });
}

class TextFieldProperties extends FieldProperties {
  final int maxLength;

  TextFieldProperties({
    required super.label,
    required super.name,
    required super.required,
    required this.maxLength,
  });

  factory TextFieldProperties.fromJson(Map<String, dynamic> json) {
    return TextFieldProperties(
      label: json['label'],
      name: json['name'],
      required: json['required'] ?? false,
      maxLength: json['maxLength'],
    );
  }
}

class NumberFieldProperties extends FieldProperties {
  final int maxValue;
  final int minValue;

  NumberFieldProperties({
    required super.label,
    required super.name,
    required super.required,
    required this.maxValue,
    required this.minValue,
  });

  factory NumberFieldProperties.fromJson(Map<String, dynamic> json) {
    return NumberFieldProperties(
      label: json['label'],
      name: json['name'],
      required: json['required']??false,
      maxValue: json['maxValue'],
      minValue: json['minValue'],
    );
  }
}

class ImageFieldProperties extends FieldProperties {
  ImageFieldProperties({
    required super.label,
    required super.name,
    required super.required,
  });

  factory ImageFieldProperties.fromJson(Map<String, dynamic> json) {
    return ImageFieldProperties(
      label: json['label'],
      name: json['name'],
      required: json['required']??false,
    );
  }
}
