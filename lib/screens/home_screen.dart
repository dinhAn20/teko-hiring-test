import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:product_management/common/extension/build_context_extension.dart';
import 'package:product_management/common/utils/show_snackbar.dart';
import 'package:product_management/data/dio_client.dart';
import 'package:product_management/models/app_component.dart';
import 'package:product_management/models/attribute.dart';
import 'package:product_management/models/product.dart';
import 'package:product_management/screens/search_products_screen.dart';
import 'package:product_management/widgets/button_component_widget.dart';
import 'package:product_management/widgets/form_component_widget.dart';
import 'package:product_management/widgets/label_component_widget.dart';
import 'package:product_management/widgets/product_list_widget.dart';

class ProductRequestModel {
  final String name;
  final int price;
  final File? imgFile;
  factory ProductRequestModel.empty() => ProductRequestModel(
        name: '',
        price: 0,
      );
  ProductRequestModel({required this.name, required this.price, this.imgFile});
  ProductRequestModel copyWith({
    String? name,
    int? price,
    File? imgFile,
  }) {
    return ProductRequestModel(
      name: name ?? this.name,
      price: price ?? this.price,
      imgFile: imgFile ?? this.imgFile,
    );
  }
}

class HomeScreen extends StatefulWidget {
  static route(List<AppComponent> components) => MaterialPageRoute(
      builder: (context) => HomeScreen(
            components: components,
          ));
  const HomeScreen({super.key, required this.components});
  final List<AppComponent> components;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<AppComponent> components = widget.components;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  File? _file;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            ...components.map(_renderComponent),
            SliverPadding(
              padding: EdgeInsets.only(bottom: context.paddingBottom),
            ),
          ],
        ),
      ),
    );
  }

  void _onAddProduct(Product product) {
    setState(() {
      components = components.map((component) {
        if (component.type == ComponentType.ProductList) {
          var products = [
            product,
            ...(component.attribute as ProductListAttribute).products
          ];
          return component.copyWith(attribute: ProductListAttribute(products));
        }
        return component;
      }).toList();
      _nameController.clear();
      _priceController.clear();
      _file = null;
    });
  }

  Widget _renderComponent(AppComponent component) {
    switch (component.type) {
      case ComponentType.Label:
        var onSearchProduct = components
                .any((component) => component.type == ComponentType.ProductList)
            ? () {
                var products = (components
                        .firstWhere((component) =>
                            component.type == ComponentType.ProductList)
                        .attribute as ProductListAttribute)
                    .products;
                Navigator.push(context, SearchProductsScreen.route(products));
              }
            : null;
        return LabelComponentWidget(
          onSearchProduct: onSearchProduct,
          attribute: component.attribute as LabelAttribute,
        );
      case ComponentType.ProductSubmitForm:
        return FormComponentWidget(
          imgfile: _file,
          nameController: _nameController,
          priceController: _priceController,
          onImgFileChanged: (imgfile) => setState(() {
            _file = imgfile;
          }),
          formKey: _formKey,
          attribute: component.attribute as FormAttribute,
        );
      case ComponentType.Button:
        return ButtonComponentWidget(
          isLoading: _isLoading,
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final DioClient dioClient = DioClient();

              try {
                setState(() {
                  _isLoading = true;
                });
                var product = await dioClient.addProduct(
                  ProductRequestModel(
                      name: _nameController.text,
                      price: int.tryParse(_priceController.text) ?? 0,
                      imgFile: _file),
                );
                _onAddProduct(product);
                if (mounted) {
                  showSnackBar(context, 'Thêm sản phẩm thành công');
                }
              } on DioException catch (e) {
                if (mounted) {
                  showSnackBar(context,
                      e.message ?? "Đã có lỗi xảy ra, vui lòng thử lại");
                }
              } catch (e) {
                if (mounted) {
                  showSnackBar(context, e.toString());
                }
              }
              setState(() {
                _isLoading = false;
              });
            }
          },
          attribute: component.attribute as ButtonAttribute,
        );
      case ComponentType.ProductList:
        return ProductListWidget(
          products: (component.attribute as ProductListAttribute).products,
        );
    }
  }
}
