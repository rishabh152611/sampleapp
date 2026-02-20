// import 'package:hive/hive.dart';

// import '../../models/address_model.dart';

// class AddressHiveService {
//   static final AddressHiveService _instance = AddressHiveService._internal();
//   factory AddressHiveService() => _instance;
//   AddressHiveService._internal();

//   final String _boxName = 'addresses';

//   Future<Box<Addresses>> _openBox() async {
//     if (!Hive.isBoxOpen(_boxName)) {
//       return await Hive.openBox<Addresses>(_boxName);
//     }
//     return Hive.box<Addresses>(_boxName);
//   }

//   Future<Addresses> addAddress(Addresses address) async {
//     final box = await _openBox();
//     final key = address.addressId ?? DateTime.now().toIso8601String();
//     await box.put(key, address);
//     return address;
//   }

//   Future<bool> updateAddress(Addresses address) async {
//     final box = await _openBox();
//     if (address.addressId != null && box.containsKey(address.addressId)) {
//       await box.put(address.addressId, address);
//       return true;
//     }
//     return false;
//   }

//   Future<bool> removeAddress(String addressId) async {
//     final box = await _openBox();
//     if (box.containsKey(addressId)) {
//       await box.delete(addressId);
//       return true;
//     }
//     return false;
//   }

//   Future<List<Addresses>> getAllAddresses() async {
//     final box = await _openBox();
//     return box.values.toList();
//   }
// }
