  import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product_model.dart';


class ProductService {

  // fetch all products
      Future<List<Product>> fetchProducts() async {
    final url = Uri.parse(
        'https://jovial-narwhal-607.convex.site/app/products/get/all');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  }