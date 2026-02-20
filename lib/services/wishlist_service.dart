
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sampleapp/models/wishlist_model.dart';
import 'package:sampleapp/secrets.dart';
import 'package:sampleapp/services/auth_service.dart';

class WishlistService {

  static final WishlistService _instance = WishlistService._internal();
  factory WishlistService() => _instance;
  WishlistService._internal();

  final authService = AuthService();


  // Fetch all wishlist items for the current user
    Future<List<WishlistModel>> getAllWishlistItems() async {
      final userId = await authService.getUserId();

      final url = "$baseurl/wishlist/getByUserId?userId=$userId";
      final response = await http.get(Uri.parse(url));
    

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => WishlistModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch lwishlist items');
      }
    }

// Add an item to the wishlist
  Future<bool> addToWishlist(String productId) async {
          final userId = await authService.getUserId();

    final url = Uri.parse('$baseurl/wishlist');
final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "userId": userId,
      "productId": productId,
    }),
  );

  if (response.statusCode == 200) {
    return true; // successfully added
  } else {
    print(" userid  :  $userId");
    throw Exception("Failed to add to wishlist: ");
  }
}

  // Remove an item from the wishlist
  Future<bool> removeFromWishlist(String productId) async {
          final userId = await authService.getUserId();
    final url = Uri.parse('$baseurl/wishlist');
    final response = await http.delete(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({

    "userId": userId,
    "productId": productId

        }));

    if (response.statusCode == 200) {
      return true; // successfully removed
    } else {
      throw Exception('Failed to remove from wishlist');
    }
  }

}
