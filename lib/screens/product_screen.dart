

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sampleapp/secrets.dart';

import '../models/product_model.dart';


class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<Product>> _futureProducts;

  @override
  void initState() {
    super.initState();
    _futureProducts = fetchProducts();
  }

  Future<List<Product>> fetchProducts() async {
    final url = Uri.parse(
        '$baseurl/products/getAll');
    final response = await http.get(url);


    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body);

      final List<dynamic> jsonListDynamic = jsonList['page'];
      return jsonListDynamic.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: FutureBuilder<List<Product>>(
        future: _futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products found'));
          } else {
            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(product.name ?? 'No Name'),
                    subtitle: Text(
                        '${product.category ?? 'universal'} - \$${product.price ?? '0'}'),
                    trailing: Text(product.size![0] ),
                    onTap: () {
                      // Navigate to product detail screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailScreen(product: product),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name ?? 'Product Detail')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name ?? '',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Category: ${product.category ?? ''}'),
            Text('Price: \$${product.price ?? 0}'),
            Text('Size: ${product.size ?? ''}'),
            Text('Color: ${product.color ?? ''}'),
            SizedBox(height: 8),
            Text('Description:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(product.description ?? ''),
            SizedBox(height: 8),
            Text('Details:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(product.details ?? ''),
            SizedBox(height: 8),
            Text('Fabric: ${product.fabric ?? ''}'),
            Text('Fit: ${product.fit ?? ''}'),
            Text('Material Care: ${product.materialCare ?? ''}'),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle order action
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Order placed for ${product.name}!')),
                  );
                },
                child: Text('Order Now'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

