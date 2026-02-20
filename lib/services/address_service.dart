import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sampleapp/models/address_model.dart';

import 'package:sampleapp/models/user_details_model.dart';
import 'package:sampleapp/services/auth_service.dart';

import '../secrets.dart';

class AddressService {
  //  ---singleton ---
  static final AddressService _instance = AddressService._internal();
  factory AddressService() => _instance;
  AddressService._internal();

  final authService = AuthService();

  // Add an item to the cart
  Future<Addresses> addAddress(UserAddress address) async {
    final userId = await authService.getUserId();

    final url = Uri.parse('$baseurl/user/address');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"userId": userId, "address": address.toJson()}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Addresses.fromJson(data['address']);
    } else {
      print(response.body);
      throw Exception("Failed to add address");
    }
  }

  // Remove an item from the cart
  Future<bool> removeAddress(String addressId) async {
    final userId = await authService.getUserId();
    final url = Uri.parse('$baseurl/user/address');
    final response = await http.delete(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"userId": userId, "addressId": addressId}),
    );

    if (response.statusCode == 200) {
      return true; 
    } else {
      throw Exception('Failed to remove address');
    }
  }

  // 🔄 Update Address
  Future<bool> updateAddress(Addresses address) async {
    final userId = await authService.getUserId();

    final url = "$baseurl/user/address";
    final response = await http.patch(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "userId": userId,
        "addressId": address.addressId,
        "updatedFields": {
          "city": address.city,
          "country": address.country,
          "label": address.label,
          "latitude": address.latitude,
          "longitude": address.longitude,
          "state": address.state,
          "street": address.street,
          "zip": address.zip,
        },
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print("❌ Failed to update address: ${response.body}");
      return false;
    }
  }
}
