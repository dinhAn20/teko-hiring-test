import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_management/common/extension/build_context_extension.dart';
import 'package:product_management/models/attribute.dart';

class LabelComponentWidget extends StatelessWidget {
  const LabelComponentWidget({
    super.key,
    required this.attribute,
    this.onSearchProduct,
  });
  final LabelAttribute attribute;
  final VoidCallback? onSearchProduct;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 6,
      shadowColor: Colors.black,
      actions: [
        if (onSearchProduct != null)
          IconButton(
            onPressed: onSearchProduct,
            icon: const Icon(CupertinoIcons.search),
          )
      ],
      pinned: true,
      title: Text(
        attribute.text,
        style: context.textTheme.headlineSmall,
      ),
    );
  }
}
