import 'package:flutter/material.dart';
import 'package:product_management/common/extension/build_context_extension.dart';
import 'package:product_management/common/extension/text_style_extension.dart';
import 'package:product_management/models/form_field.dart';

class NumberFieldWidget extends StatelessWidget {
  const NumberFieldWidget({
    super.key,
    required this.priceController,
    required this.numberFieldProperties,
  });

  final TextEditingController priceController;
  final NumberFieldProperties numberFieldProperties;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text.rich(
          TextSpan(
              text: numberFieldProperties.required ? '* ' : '',
              children: [
                TextSpan(
                  text: numberFieldProperties.label,
                  style: context.textTheme.labelLarge?.w600,
                ),
              ],
              style: context.textTheme.labelLarge?.w600.error),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: priceController,
          decoration: const InputDecoration(suffixText: 'đ'),
          keyboardType: TextInputType.number,
          validator: (value) {
            int? price = int.tryParse(value ?? "");
            if (numberFieldProperties.required && (value?.isEmpty ?? true)) {
              return "Nhập ${numberFieldProperties.label.toLowerCase()}";
            }
            if (price == null) {
              return '${numberFieldProperties.label} không hợp lệ';
            }
            if (price < numberFieldProperties.minValue ||
                price > numberFieldProperties.maxValue) {
              return "${numberFieldProperties.label} phải trong khoảng ${numberFieldProperties.minValue}đ - ${numberFieldProperties.maxValue}đ";
            }
            return null;
          },
        ),
      ],
    );
  }
}
