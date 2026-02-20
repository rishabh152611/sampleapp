

import 'package:flutter/material.dart';
import 'package:sampleapp/models/user_details_model.dart';
import 'package:sampleapp/services/user_details_service.dart';

import '../models/address_model.dart';
import '../services/address_service.dart';

class UserProvider extends ChangeNotifier {
  final UserDetailsService _userService = UserDetailsService();
  final AddressService _addressService = AddressService();
  UserDetails? _userDetails;
  bool _isLoading = false;
  bool _isUpdating = false;

  UserDetails? get userDetails => _userDetails;
  bool get isLoading => _isLoading;
  bool get isUpdating => _isUpdating;

  // /// Fetch user details from backend
  // Future<void> fetchUserDetails() async {
  //   _isLoading = true;
  //   notifyListeners();

  //   try {
  //     _userDetails = await _userService.getAllUserDetails();
  //   } catch (e) {
  //     print("Error fetching user details: $e");
  //     _userDetails = null;
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  Future<void> fetchUserDetails() async {
  // Schedule the first notify after the current build completes
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _isLoading = true;
    notifyListeners();
  });

  try {
    _userDetails = await _userService.getAllUserDetails();
  } catch (e) {
    print("Error fetching user details: $e");
    _userDetails = null;
  } finally {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isLoading = false;
      notifyListeners();
    });
  }
}


  /// Update user phone number
  Future<bool> updatePhone(String phoneNumber) async {
    _isUpdating = true;
    notifyListeners();

    try {
      final success = await _userService.updateUserDetails(phoneNumber);
      if (success && _userDetails != null) {
        _userDetails = UserDetails(
          userId: _userDetails!.userId,
          name: _userDetails!.name,
          email: _userDetails!.email,
          phone: phoneNumber, // ✅ update locally
        );
        notifyListeners();
      }
      return success;
    } catch (e) {
      print("Error updating phone: $e");
      return false;
    } finally {
      _isUpdating = false;
      notifyListeners();
    }
  }

  /// Reset user details (on logout, etc.)
  void clearUser() {
    _userDetails = null;
    notifyListeners();
  }

/// Add a new address locally
void addAddressLocal(Addresses address) {
  if (_userDetails != null) {
    _userDetails!.addresses ??= [];
    _userDetails!.addresses!.add(address);
    notifyListeners();
  }
}

/// Update an existing address locally
void updateAddressLocal(Addresses address) {
  if (_userDetails?.addresses != null) {
    final index = _userDetails!.addresses!
        .indexWhere((a) => a.addressId == address.addressId);
    if (index != -1) {
      _userDetails!.addresses![index] = address;
      notifyListeners();
    }
  }
}

/// Remove an address locally
void removeAddressLocal(String addressId) {
  if (_userDetails?.addresses != null) {
    _userDetails!.addresses!
        .removeWhere((a) => a.addressId == addressId);
    notifyListeners();
  }
}

/// Get list of addresses (for cart screen, etc.)
List<Addresses> getAddressList() {
  return _userDetails?.addresses ?? [];
}


}
