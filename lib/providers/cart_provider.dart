// providers/cart_provider.dart
import 'package:flutter/material.dart';
import 'package:sampleapp/models/cart_model.dart';
import 'package:sampleapp/services/cart_service.dart';

class CartProvider with ChangeNotifier {
  final CartService _cartService = CartService();

  List<CartModel> _cartItems = [];
  bool _isLoading = false;

  // Separate loading states
  Set<String> _updatingItems = {};
  Set<String> _deletingItems = {};

  List<CartModel> get cartItems => _cartItems;
  bool get isLoading => _isLoading;

  bool isUpdating(String productId) => _updatingItems.contains(productId);
  bool isDeleting(String productId) => _deletingItems.contains(productId);

  Future<void> fetchCartItems() async {
    _isLoading = true;
    notifyListeners();
    try {
      _cartItems = await _cartService.getAllCartItems();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void increaseQuantityLocal(String productId) {
    final item = _cartItems.firstWhere((e) => e.productId == productId);
    item.quantity = (item.quantity ?? 1) + 1;
    notifyListeners();
  }

  void decreaseQuantityLocal(String productId) {
    final item = _cartItems.firstWhere((e) => e.productId == productId);
    if ((item.quantity ?? 1) > 1) {
      item.quantity = (item.quantity ?? 1) - 1;
      notifyListeners();
    }
  }

  Future<void> updateQuantity(String productId) async {
    final item = _cartItems.firstWhere((e) => e.productId == productId);
    _updatingItems.add(productId);
    notifyListeners();

    try {
      await _cartService.updateCartItem(productId, item.quantity ?? 1);
    } finally {
      _updatingItems.remove(productId);
      notifyListeners();
    }
  }

  Future<void> removeItem(String cartId) async {
    _deletingItems.add(cartId);
    notifyListeners();

    try {
      await _cartService.removeFromCart(cartId);
      _cartItems.removeWhere((item) => item.sId == cartId);
    } finally {
      _deletingItems.remove(cartId);
      notifyListeners();
    }
  }


  Future<void> addItemToCart(String productId, int quantity, int optionIndex, int colorIndex) async {
  _updatingItems.add(productId);
  notifyListeners();

  try {
    final success = await _cartService.addToCart(productId, quantity, optionIndex, colorIndex);
    if (success) {
      // refresh cart
      await fetchCartItems();
    }
  } finally {
    _updatingItems.remove(productId);
    notifyListeners();
  }
}

// double get totalPrice {
//   double total = 0;
//   for (var item in _cartItems) {
//     final price = item.product!.price![0] ; // make sure your CartModel has price
//     total += price * (item.quantity ?? 1);
//   }
//   return total;
// }


double get totalPrice {
  double total = 0;

  for (var item in _cartItems) {
    if (item.product != null && item.product!.price != null && item.product!.price!.isNotEmpty) {
      final priceIndex = item.optionIndex ?? 0;
      // Ensure index is within bounds
      final price = (priceIndex < item.product!.price!.length)
          ? item.product!.price![priceIndex]
          : 0;

      total += price * (item.quantity ?? 1);
    }
  }

  return total;
}


}
