import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:product_management/common/extension/build_context_extension.dart';
import 'package:product_management/models/product.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: (product.imageSrc?.isEmpty ?? true)
                ? Container(
                    decoration: BoxDecoration(color: Colors.grey.shade200),
                    child: const Center(
                      child: Text("No Image"),
                    ),
                  )
                : CachedNetworkImage(
                    imageUrl: product.imageSrc!,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                product.name,
                style: context.textTheme.labelLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text('${product.price} đ')
            ],
          ),
        ),
      ],
    );
  }
}
