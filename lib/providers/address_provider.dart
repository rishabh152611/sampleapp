


import 'package:flutter/material.dart';
import 'package:sampleapp/models/address_model.dart';
import 'package:sampleapp/models/user_details_model.dart';
import 'package:sampleapp/services/address_service.dart';
import 'package:sampleapp/providers/user_provider.dart';

class AddressProvider extends ChangeNotifier {
  final AddressService _addressService = AddressService();
  late UserProvider _userProvider;

  bool _isLoading = false; // for global actions (like add new)
  String? _errorMessage;

  String? _processingAddressId; // ✅ track only one address (update/delete)

  AddressProvider(this._userProvider);

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get processingAddressId => _processingAddressId;

  /// Update the internal reference to UserProvider
  void updateUserProvider(UserProvider userProvider) {
    _userProvider = userProvider;
  }

  /// Add new address (UserAddress → backend returns Addresses with ID)
  Future<void> addAddress(UserAddress address) async {
    _setGlobalLoading(true);
    try {
      final Addresses newAddress = await _addressService.addAddress(address);
      _userProvider.addAddressLocal(newAddress); // sync with UserProvider
      _errorMessage = null;
    } catch (e) {
      _errorMessage = "Failed to add address: $e";
      rethrow;
    } finally {
      _setGlobalLoading(false);
    }
  }

  /// Update existing address
  Future<void> updateAddress(Addresses address) async {
    _setProcessing(address.addressId);
    try {
      final success = await _addressService.updateAddress(address);
      if (success) {
        _userProvider.updateAddressLocal(address); // sync updated
        _errorMessage = null;
      } else {
        _errorMessage = "Failed to update address.";
      }
    } catch (e) {
      _errorMessage = "Error updating address: $e";
      rethrow;
    } finally {
      _clearProcessing();
    }
  }

  /// Delete address
  Future<void> deleteAddress(String addressId) async {
    _setProcessing(addressId);
    try {
      final success = await _addressService.removeAddress(addressId);
      if (success) {
        _userProvider.removeAddressLocal(addressId); // sync removal
        _errorMessage = null;
      } else {
        _errorMessage = "Failed to delete address.";
      }
    } catch (e) {
      _errorMessage = "Error deleting address: $e";
      rethrow;
    } finally {
      _clearProcessing();
    }
  }

  /// Helpers
  void _setGlobalLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setProcessing(String? addressId) {
    _processingAddressId = addressId;
    notifyListeners();
  }

  void _clearProcessing() {
    _processingAddressId = null;
    notifyListeners();
  }
}
