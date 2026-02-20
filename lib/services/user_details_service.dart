

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sampleapp/models/user_details_model.dart';

import '../secrets.dart';
import 'auth_service.dart';

class UserDetailsService {
  static final UserDetailsService _instance = UserDetailsService._internal();
  factory UserDetailsService() => _instance;
  UserDetailsService._internal();

  final authService = AuthService();

  /// ✅ Fetch all user details for the current user
  Future<UserDetails> getAllUserDetails() async {
    final userId = await authService.getUserId();
    if (userId == null || userId.isEmpty) {
      throw Exception("User ID not found");
    }

    final url = "$baseurl/user/getByUserId?userId=$userId";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserDetails.fromJson(data);
    } else {
      throw Exception('Failed to fetch user details');
    }
  }

  /// ✅ Update user details for the current user
  Future<bool> updateUserDetails(String phoneNumber) async {
    final userId = await authService.getUserId();
    if (userId == null || userId.isEmpty) return false;

    final url = "$baseurl/user/update";
    final response = await http.patch(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "userId": userId,
        "updatedFields": {"phone": phoneNumber},
      }),
    );

    return response.statusCode == 200;
  }

  /// ✅ Check if user exists in backend (used in splash screen)
  Future<bool> checkUserExists() async {
    final userId = await authService.getUserId();
    if (userId == null || userId.isEmpty) return false;

    final url = "$baseurl/user/ispresent?userId=$userId";
    final response = await http.get(Uri.parse(url)).timeout(
      const Duration(seconds: 10),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data['exists'] == true;
    } else {
      throw Exception("Failed to check user (status ${response.statusCode})");
    }
  }
}
