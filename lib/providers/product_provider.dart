import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sampleapp/secrets.dart';

import '../models/product_model.dart';

class ProductProvider extends ChangeNotifier {


  final List<Product> _products = [];
  String? _continueCursor;
  bool _isDone = false;
  bool _isLoading = false;

  List<Product> get products => List.unmodifiable(_products);
  bool get isDone => _isDone;
  bool get isLoading => _isLoading;

  /// Load initial products (refresh / first page)
  Future<void> fetchInitialProducts() async {
    _products.clear();
    _continueCursor = null;
    _isDone = false;
    notifyListeners();
    await fetchMoreProducts();
  }

  /// Fetch next page and append to the list
  Future<void> fetchMoreProducts() async {
    if (_isLoading || _isDone) return;

    _isLoading = true;
    notifyListeners();

    try {
      final result = await fetchProducts(cursor: _continueCursor, limit: 10);

      _products.addAll(result['products']);
      _continueCursor = result['continueCursor'];
      _isDone = result['isDone'];
    } catch (e) {
      debugPrint("Error fetching products: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Check if we need to load more based on current index (for ListView.builder)
  void checkAndFetchMore(int currentIndex, {int threshold = 4}) {
    if (!_isDone &&
        !_isLoading &&
        currentIndex >= _products.length - threshold) {
      fetchMoreProducts();
    }
  }

  /// Common API call to fetch products (with optional cursor + limit)
  Future<Map<String, dynamic>> fetchProducts({
    String? cursor,
    int limit = 20,
  }) async {
    final queryParams = {
      'limit': limit.toString(),
      if (cursor != null) 'cursor': cursor,
    };

    final uri = Uri.parse('$baseurl/products/getAll')
        .replace(queryParameters: queryParams);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      final List<dynamic> pageData = data['page'] ?? [];

      return {
        'products': pageData.map((json) => Product.fromJson(json)).toList(),
        'continueCursor': data['continueCursor'],
        'isDone': data['isDone'] ?? false,
      };
    } else {
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  }
}
