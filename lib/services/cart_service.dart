
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sampleapp/models/cart_model.dart';

import 'package:sampleapp/secrets.dart';
import 'package:sampleapp/services/auth_service.dart';

class CartService {

  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final authService = AuthService();


  // Fetch all cart items for the current user
    Future<List<CartModel>> getAllCartItems() async {
      final userId = await authService.getUserId();

      final url = "$baseurl/cart/getByUserId?userId=$userId";
      final response = await http.get(Uri.parse(url));
    

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => CartModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch cart items');
      }
    }

// Add an item to the cart
  Future<bool> addToCart(String productId, int quantity, int optionIndex, int colorIndex) async {
          final userId = await authService.getUserId();

    final url = Uri.parse('$baseurl/cart');
    final response = await http.post(
      url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "userId": userId,
      "productId": productId,
      "quantity": quantity,
      "optionIndex": optionIndex,
    "colorIndex": colorIndex,
    }),
  );

  if (response.statusCode == 200) {
    return true; // successfully added
  } else {
    print(" userid  :  $userId");
    throw Exception("Failed to add to wishlist: ");
  }
}

  // Remove an item from the cart
  Future<bool> removeFromCart(String cartId) async {

    final url = Uri.parse('$baseurl/cart');
    final response = await http.delete(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
    "cartId": cartId
        }));

    if (response.statusCode == 200) {
      return true; // successfully removed
    } else {
      throw Exception('Failed to remove from cart');
    }
  }


// update cart item quantity
Future<bool> updateCartItem(String productId, int quantity) async {
        final userId = await authService.getUserId();
  final url = Uri.parse('$baseurl/cart');
  final response = await http.patch(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "userId": userId,
      "productId": productId,
      "quantity": quantity
    }),
  );

  if (response.statusCode == 200) {
    return true; // successfully updated
  } else {
    throw Exception('Failed to update cart item');
  }
}


}