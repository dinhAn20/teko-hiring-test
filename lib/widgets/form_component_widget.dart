import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_management/models/attribute.dart';
import 'package:product_management/models/form_field.dart';
import 'package:product_management/widgets/image_field_widget.dart';
import 'package:product_management/widgets/number_field_widget.dart';
import 'package:product_management/widgets/text_field_widget.dart';

class FormComponentWidget extends StatelessWidget {
  const FormComponentWidget({
    super.key,
    required this.attribute,
    required this.formKey,
    required this.nameController,
    required this.priceController,
    this.imgfile,
    required this.onImgFileChanged,
  });
  final TextEditingController nameController;
  final TextEditingController priceController;
  final File? imgfile;
  final GlobalKey<FormState> formKey;
  final FormAttribute attribute;
  final Function(File imgfile) onImgFileChanged;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: attribute.form
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: _renderField(context, e),
                      ))
                  .toList(),
            )),
      ),
    );
  }

  Widget _renderField(BuildContext context, FieldProperties properties) {
    switch (properties.runtimeType) {
      case const (TextFieldProperties):
        return TextFieldWidget(
            nameController: nameController,
            textFieldProperties: properties as TextFieldProperties);
      case const (NumberFieldProperties):
        return NumberFieldWidget(
            priceController: priceController,
            numberFieldProperties: properties as NumberFieldProperties);
      case const (ImageFieldProperties):
        return ImageFieldWidget(
            onImgFileChanged: onImgFileChanged,
            imgfile: imgfile,
            properties: properties as ImageFieldProperties);
      default:
        return const SizedBox();
    }
  }
}
