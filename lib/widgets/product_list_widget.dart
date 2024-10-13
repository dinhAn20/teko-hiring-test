import 'package:flutter/material.dart';
import 'package:product_management/models/product.dart';
import 'package:product_management/widgets/product_widget.dart';

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({
    super.key,
    required this.products,
  });
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      sliver: SliverGrid.builder(
        itemBuilder: (context, index) {
          var product = products[index];
          return ProductWidget(product: product);
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.7),
        itemCount: products.length,
      ),
    );
  }
}
