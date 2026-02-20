import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // ---- Singleton ----
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  static const  useridkey = "useridval";


  /// Save userId to storage + cache
  Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(useridkey, userId);
    print("user saved");
    }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final temp = await prefs.getString(useridkey);
    return temp;
  }

  /// Clear userId everywhere
  Future<void> clearUserId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(useridkey);
    print("user cleared");
    print(useridkey);
    
  }

}
