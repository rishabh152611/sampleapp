import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:sampleapp/models/order_model.dart';

import 'package:sampleapp/secrets.dart';
import 'package:sampleapp/services/auth_service.dart';

class OrderService {
  static final OrderService _instance = OrderService._internal();
  factory OrderService() => _instance;
  OrderService._internal();

  final authService = AuthService();

  // Fetch all cart items for the current user
  Future<List<OrderModel>> getAllOrders() async {
    final userId = await authService.getUserId();

    final url = "$baseurl/order/getByUserId?userId=$userId";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => OrderModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch orders');
    }
  }

  // Add an item to the order
  Future<bool> createOrder(
    String addressId,
    String paymentMethod,
    String paymentStatus,
    String paymentId,
    String orderId,
    String storeId,
  ) async {
    final userId = await authService.getUserId();

    final url = Uri.parse('$baseurl/order');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "userId": userId,
        "addressId": addressId,
        "orderId": orderId,
        "storeId": storeId,
        "paymentId": paymentId,
        "paymentStatus": paymentStatus,
        "paymentMethod": paymentMethod
      }),
    );

    print(response.body);
    if (response.statusCode == 200) {
      return true; // successfully added
    } else {
      print(" userid  :  $userId");
      print("storeid  :  $storeId");
      throw Exception("Failed to create order ");
    }
  }

  // update order status
  Future<bool> updateOrderStatus(String orderId, String status) async {
    final url = Uri.parse('$baseurl/order/status');
    final response = await http.patch(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"orderId": orderId, "status": status}),
    );

    if (response.statusCode == 200) {
      return true; // successfully updated
    } else {
      throw Exception('Failed to update order status');
    }
  }

  // update order payment status
  Future<bool> updateOrderPaymentStatus(
    String orderId,
    String paymentStatus,
  ) async {
    final url = Uri.parse('$baseurl/order/payment');
    final response = await http.patch(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"orderId": orderId, "paymentStatus": paymentStatus}),
    );

    if (response.statusCode == 200) {
      return true; // successfully updated
    } else {
      throw Exception('Failed to update payment status');
    }
  }
}
