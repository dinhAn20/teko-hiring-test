import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle {
  TextStyle get error => copyWith(
        color: Colors.red,
      );
  TextStyle get w600 => copyWith(
    fontWeight: FontWeight.w600
      );
  TextStyle get bold => copyWith(
    fontWeight: FontWeight.bold
      );
}
