import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:myapp/user/data/user_repo.dart';
import 'product_model.dart';

class ProductRepo {
  // Update base URL to include http:// and proper IP/port
  String baseUrl = 'http://192.168.84.57:8000/api'; // For Android emulator
  // Use 'http://localhost:8000/api' for iOS simulator
  // Use actual IP address for physical device

  Future<List<Product>> getProducts() async {
    try {
      print('Fetching products from: $baseUrl/products/');
      final response = await http.get(Uri.parse('$baseUrl/products/'));
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> productsJson = json.decode(response.body);
        return productsJson.map((json) => Product.fromJson(json)).toList();
      } else {
        print('Error response: ${response.body}');
        throw Exception(
            'Failed to load products: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Exception in getProducts: $e');
      throw Exception('Failed to load products: $e');
    }
  }

  Future<Product> createProduct({
    required String title,
    required String description,
    required String price,
    required int mainCategoryId,
    required int subCategoryId,
    required List<File> images,
  }) async {
    try {
      final token = await UserRepo().getToken();

      if (token == null) {
        throw Exception('Authentication token not found');
      }
      print(token);

      var uri = Uri.parse('$baseUrl/products/');
      var request = http.MultipartRequest('POST', uri);

      // Add headers
      request.headers.addAll({
        'Authorization': 'Token $token',
        'Accept': 'application/json',
        'Content-Type': 'multipart/form-data',
      });

      // Add text fields
      request.fields['title'] = title;
      request.fields['description'] = description;
      request.fields['price'] = price;
      request.fields['main_category_id'] = mainCategoryId.toString();
      request.fields['sub_category_id'] = subCategoryId.toString();

      // Add image files
      for (var i = 0; i < images.length; i++) {
        var file = images[i];
        var stream = http.ByteStream(file.openRead());
        var length = await file.length();
        var multipartFile = http.MultipartFile(
          'images',
          stream,
          length,
          filename: file.path.split('/').last,
        );
        request.files.add(multipartFile);
      }

      print('Sending request to: $uri');
      print('Request headers: ${request.headers}');
      print('Request fields: ${request.fields}');

      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Request timed out');
        },
      );

      final response = await http.Response.fromStream(streamedResponse);
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        return Product.fromJson(json.decode(response.body));
      } else {
        throw Exception(
            'Failed to create product: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error creating product: $e');
      throw Exception('Failed to create product: $e');
    }
  }

  Future<List<Product>> getProductsByMainCategory(int mainCategoryId) async {
    try {
      print('Fetching products for category: $mainCategoryId');
      final response = await http.get(
        Uri.parse(
            '$baseUrl/products/get_by_main_category/?main_category_id=$mainCategoryId'),
      );
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> productsJson = json.decode(response.body);
        return productsJson.map((json) => Product.fromJson(json)).toList();
      } else {
        print('Error response: ${response.body}');
        throw Exception(
            'Failed to load products: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Exception in getProductsByMainCategory: $e');
      throw Exception('Failed to load products: $e');
    }
  }
}
