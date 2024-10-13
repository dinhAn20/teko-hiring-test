import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_management/common/extension/build_context_extension.dart';
import 'package:product_management/models/product.dart';
import 'package:product_management/widgets/product_widget.dart';

class SearchProductsScreen extends StatefulWidget {
  static route(List<Product> products) => MaterialPageRoute(
      builder: (context) => SearchProductsScreen(
            products: products,
          ));
  const SearchProductsScreen({super.key, required this.products});
  final List<Product> products;
  @override
  State<SearchProductsScreen> createState() => _SearchProductsScreenState();
}

class _SearchProductsScreenState extends State<SearchProductsScreen> {
  List<Product> filteredProducts = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredProducts = widget.products;
  }

  void _filterProducts(String query) {
    setState(() {
      searchQuery = query;
      filteredProducts = widget.products
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tìm Kiếm"),
      ),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.search),
                    hintText: 'Tìm kiếm sản phẩm...',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: _filterProducts,
                ),
              ),
              Expanded(
                child: filteredProducts.isNotEmpty
                    ? GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          var product = filteredProducts[index];
                          return ProductWidget(product: product);
                        },
                      )
                    : const Center(
                        child: Text("Không có sản phẩm"),
                      ),
              ),
              SizedBox(height: context.paddingBottom)
            ],
          ),
        ),
      ),
    );
  }
}
