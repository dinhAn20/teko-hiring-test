import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  double get paddingBottom => MediaQuery.paddingOf(this).bottom;
  showLoading() => showDialog(
      context: this,
      builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ));
}
