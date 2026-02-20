import 'package:flutter/foundation.dart';
import 'package:sampleapp/services/wishlist_service.dart';

class WishlistProvider with ChangeNotifier {
  final WishlistService _wishlistService = WishlistService();

  final List<String> _wishlist = [];
  bool _loading = false;

  List<String> get wishlist => List.unmodifiable(_wishlist);
  bool get isLoading => _loading;

  bool isWishlisted(String productId) {
    return _wishlist.contains(productId);
  }

  /// 🔹 Load wishlist from backend
  Future<void> fetchWishlist() async {
    _loading = true;
    notifyListeners();

    try {
      final items = await _wishlistService.getAllWishlistItems();
      _wishlist
        ..clear()
        ..addAll(items.map((e) => e.productId!));
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching wishlist: $e");
      }
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> addProduct(String productId) async {
    try {
      final success = await _wishlistService.addToWishlist(productId);
      if (success && !_wishlist.contains(productId)) {
        _wishlist.add(productId);
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) print("Error adding product: $e");
    }
  }

  Future<void> removeProduct(String productId) async {
    try {
      final success = await _wishlistService.removeFromWishlist(productId);
      if (success) {
        _wishlist.remove(productId);
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) print("Error removing product: $e");
    }
  }

  Future<void> toggleProduct(String productId) async {
    if (isWishlisted(productId)) {
      await removeProduct(productId);
    } else {
      await addProduct(productId);
    }
  }
}
