import 'package:flutter/material.dart';
import 'package:product_management/models/attribute.dart';

class ButtonComponentWidget extends StatelessWidget {
  const ButtonComponentWidget({
    super.key,
    required this.attribute,
    required this.onPressed,
    required this.isLoading,
  });
  final ButtonAttribute attribute;
  final VoidCallback onPressed;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Center(
        child: SizedBox(
          width: 200,
          child: FilledButton(
            onPressed: onPressed,
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Text(attribute.text),
          ),
        ),
      ),
    ));
  }
}
