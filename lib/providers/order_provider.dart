// import 'package:flutter/material.dart';
// import 'package:sampleapp/models/order_model.dart';
// import 'package:sampleapp/services/order_service.dart';

// class OrderProvider extends ChangeNotifier {
//   final OrderService _orderService = OrderService();

//   List<OrderModel> _orders = [];
//   bool _isLoading = false;

//   List<OrderModel> get orders => _orders;
//   bool get isLoading => _isLoading;

//   // Fetch orders from backend
//   Future<void> fetchOrders() async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       _orders = await _orderService.getAllOrders();
//     } catch (e) {
//       print("Error fetching orders: $e");
//       _orders = [];
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   // Update order payment status
//   Future<bool> payOrder(String orderId) async {
//     try {
//       final success = await _orderService.updateOrderPaymentStatus(orderId, "paid");
//       if (success) {
//         final index = _orders.indexWhere((order) => order.sId == orderId);
//         if (index != -1) {
//           _orders[index].paymentStatus = "paid";
//           notifyListeners();
//         }
//       }
//       return success;
//     } catch (e) {
//       print("Error paying order: $e");
//       return false;
//     }
//   }

//   // Update order status (optional, admin feature)
//   Future<bool> updateOrderStatus(String orderId, String status) async {
//     try {
//       final success = await _orderService.updateOrderStatus(orderId, status);
//       if (success) {
//         final index = _orders.indexWhere((order) => order.sId == orderId);
//         if (index != -1) {
//           _orders[index].orderStatus = status;
//           notifyListeners();
//         }
//       }
//       return success;
//     } catch (e) {
//       print("Error updating order status: $e");
//       return false;
//     }
//   }


//   OrderModel? getOrderById(String orderId) {
//     return _orders.firstWhere((order) => order.sId == orderId);
//   }
// }


import 'package:flutter/material.dart';
import 'package:sampleapp/models/order_model.dart';
import 'package:sampleapp/services/order_service.dart';

class OrderProvider with ChangeNotifier {
  final OrderService _orderService = OrderService();

  List<OrderModel> _orders = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<OrderModel> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Fetch all orders for the current user
  Future<void> fetchOrders() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _orders = await _orderService.getAllOrders();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Create a new order
  Future<bool> createOrder({
    required String addressId,
    required String paymentMethod,
    required String paymentStatus,
    required String paymentId,
    required String orderId,
    required String storeId,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final success = await _orderService.createOrder(
        addressId,
        paymentMethod,
        paymentStatus,
        paymentId,
        orderId,
        storeId,
      );

      if (success) {
        await fetchOrders(); // Refresh order list after creation
      }

      return success;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update order status
  Future<bool> updateOrderStatus(String orderId, String status) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final success = await _orderService.updateOrderStatus(orderId, status);
      if (success) await fetchOrders();
      return success;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update payment status
  Future<bool> updatePaymentStatus(String orderId, String paymentStatus) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final success =
          await _orderService.updateOrderPaymentStatus(orderId, paymentStatus);
      if (success) await fetchOrders();
      return success;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Optional: Clear orders
  void clearOrders() {
    _orders = [];
    notifyListeners();
  }
}
