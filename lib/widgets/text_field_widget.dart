import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_management/common/extension/build_context_extension.dart';
import 'package:product_management/common/extension/text_style_extension.dart';
import 'package:product_management/models/form_field.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.nameController,
    required this.textFieldProperties,
  });

  final TextEditingController nameController;
  final TextFieldProperties textFieldProperties;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text.rich(
          TextSpan(
              text: textFieldProperties.required ? '* ' : '',
              children: [
                TextSpan(
                  text: textFieldProperties.label,
                  style: context.textTheme.labelLarge?.w600,
                ),
              ],
              style: context.textTheme.labelLarge?.w600.error),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: nameController,
          validator: (value) {
            if (textFieldProperties.required && (value?.isEmpty ?? true)) {
              return "Nhập ${textFieldProperties.label.toLowerCase()}";
            }
            if (value?.isNotEmpty == true &&
                value!.length > textFieldProperties.maxLength) {
              return "${textFieldProperties.label} không được quá ${textFieldProperties.maxLength} ký tự";
            }
            return null;
          },
        ),
      ],
    );
  }
}
