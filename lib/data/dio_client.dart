import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:product_management/models/app_component.dart';
import 'package:product_management/models/product.dart';
import 'package:product_management/screens/home_screen.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();

  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    _addInterceptor(LogInterceptor(requestBody: true, responseBody: true));
  }

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://hiring-test.stag.tekoapis.net/api/",
      headers: {'Accept': 'application/json'},
      connectTimeout: const Duration(minutes: 3),
      receiveTimeout: const Duration(minutes: 3),
    ),
  );

  void _addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  // Future<Response<Map<String, dynamic>>> get(String uri,
  //     {Map<String, dynamic>? queryParameters}) async {
  //   return _dio.get<Map<String, dynamic>>(uri,
  //       queryParameters: queryParameters);
  // }

  Future<List<AppComponent>> getAllComponents() async {
    var res = await _dio.get<Map<String, dynamic>>('/products/management');
    if (res.data != null && res.data!['data'] is List) {
      return List<Map<String, dynamic>>.from(res.data!['data'])
          .map(AppComponent.fromJson)
          .toList();
    }
    return [];
  }

  Future<Product> addProduct(ProductRequestModel model) async {
    if (model.imgFile != null) {
      var imageUrl = await _uploadImage(model.imgFile!);
      return Product(name: model.name, price: model.price, imageSrc: imageUrl);
    }
    return Product(name: model.name, price: model.price);
  }

  Future<String> _uploadImage(File file) async {
    const String apiUrl = 'https://api.imgur.com/3/image';
    const String clientId = 'ded82ae92cf55ff';
    final bytes = await file.readAsBytes();
    final base64Image = base64Encode(bytes);
    var res = await _dio.post(
      apiUrl,
      options: Options(headers: {
        'Authorization': 'Client-ID $clientId',
      }),
      data: {
        'image': base64Image,
        'type': 'base64',
      },
    );
    return res.data['data']['link'];
  }
}
