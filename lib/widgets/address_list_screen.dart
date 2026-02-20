import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

import 'package:sampleapp/models/address_model.dart';
import 'package:sampleapp/providers/address_provider.dart';
import 'package:sampleapp/providers/user_provider.dart';

import '../models/user_details_model.dart';

class AddressListScreen extends StatelessWidget {
  const AddressListScreen({super.key});


  Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;


  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {

    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {

      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {

    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 


  return await Geolocator.getCurrentPosition();
}


  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final addressProvider = Provider.of<AddressProvider>(context);

    final addresses = userProvider.userDetails?.addresses ?? [];

    final ValueNotifier<String?> deletingAddressId = ValueNotifier(null);
    return Scaffold(
      appBar: AppBar(title: const Text("My Addresses")),
      body: addressProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : addresses.isEmpty
              ? const Center(child: Text("No addresses found"))
              : ValueListenableBuilder<String?>(
                  valueListenable: deletingAddressId,
                  builder: (_, deletingId, __) {
                    return ListView.builder(
                      itemCount: addresses.length,
                      itemBuilder: (context, index) {
                        final address = addresses[index];
                        return Card(
                          margin: const EdgeInsets.all(8),
                          child: ListTile(
                            title: Text(address.label ?? 'No Label'),
                            subtitle: Text(
                              "${address.street}, ${address.city}, ${address.state}, ${address.zip}, ${address.country}\n"
                              "Lat: ${address.latitude}, Lng: ${address.longitude}",
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () => _showAddressForm(context, existingAddress: address),
                                ),
                                IconButton(
                                  icon: deletingId == address.addressId
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.red),
                                        )
                                      : const Icon(Icons.delete),
                                  onPressed: deletingId == address.addressId
                                      ? null
                                      : () async {
                                          deletingAddressId.value = address.addressId;
                                          try {
                                            await Provider.of<AddressProvider>(context, listen: false)
                                                .deleteAddress(address.addressId as String);
                                                ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text("Delete successful")),
                                            );
                                          } catch (e) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text("Delete failed: $e")),
                                            );
                                          } finally {
                                            deletingAddressId.value = null;
                                          }
                                        },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddressForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddressForm(BuildContext context, {Addresses? existingAddress}) {
    final labelController = TextEditingController(text: existingAddress?.label ?? '');
    final streetController = TextEditingController(text: existingAddress?.street ?? '');
    final cityController = TextEditingController(text: existingAddress?.city ?? '');
    final stateController = TextEditingController(text: existingAddress?.state ?? '');
    final zipController = TextEditingController(text: existingAddress?.zip ?? '');
    final countryController = TextEditingController(text: existingAddress?.country ?? '');
    final latitudeController = TextEditingController(text: existingAddress?.latitude ?? '');
    final longitudeController = TextEditingController(text: existingAddress?.longitude ?? '');

  final ValueNotifier<bool> isFetchingLocation = ValueNotifier(false);
  final ValueNotifier<bool> isSaving = ValueNotifier(false);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                existingAddress == null ? "Add Address" : "Update Address",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              // Normal fields
              TextField(controller: labelController, decoration: const InputDecoration(labelText: 'Label')),
              TextField(controller: streetController, decoration: const InputDecoration(labelText: 'Street')),
              TextField(controller: cityController, decoration: const InputDecoration(labelText: 'City')),
              TextField(controller: stateController, decoration: const InputDecoration(labelText: 'State')),
              TextField(controller: zipController, decoration: const InputDecoration(labelText: 'Zip')),
              TextField(controller: countryController, decoration: const InputDecoration(labelText: 'Country')),
              const SizedBox(height: 12),
              // Coordinates fields
              TextField(
                controller: latitudeController,
                readOnly: true,
                decoration: const InputDecoration(labelText: 'Latitude'),
              ),
              TextField(
                controller: longitudeController,
                readOnly: true,
                decoration: const InputDecoration(labelText: 'Longitude'),
              ),
              const SizedBox(height: 12),
              // Fetch coordinates button
              ValueListenableBuilder<bool>(
                valueListenable: isFetchingLocation,
                builder: (_, fetching, __) {
                  return ElevatedButton.icon(
                    onPressed: fetching
                        ? null
                        : () async {
                            isFetchingLocation.value = true;
                            try {
                              final position = await _determinePosition();
                              print("get location: $position");
                              latitudeController.text = position.latitude.toString();
                              longitudeController.text = position.longitude.toString();
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Failed to fetch location: $e")),
                              );
                            } finally {
                              isFetchingLocation.value = false;
                            }
                          },
                    icon: fetching
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : const Icon(Icons.my_location),
                    label: Text(fetching ? "Fetching..." : "Fetch Coordinates"),
                  );
                },
              ),
              const SizedBox(height: 16),
              ValueListenableBuilder<bool>(
                valueListenable: isSaving,
                builder: (_, saving, __) {
                  return ElevatedButton(
                    onPressed: saving
                        ? null
                        : () async {
                            isSaving.value = true;
                            try {
                              if (existingAddress == null) {
                                final newAddress = UserAddress(
                                  label: labelController.text,
                                  street: streetController.text,
                                  city: cityController.text,
                                  state: stateController.text,
                                  zip: zipController.text,
                                  country: countryController.text,
                                  latitude: latitudeController.text,
                                  longitude: longitudeController.text,
                                );
                                await Provider.of<AddressProvider>(context, listen: false).addAddress(newAddress);
                              } else {
                                final updatedAddress = Addresses(
                                  addressId: existingAddress.addressId,
                                  label: labelController.text,
                                  street: streetController.text,
                                  city: cityController.text,
                                  state: stateController.text,
                                  zip: zipController.text,
                                  country: countryController.text,
                                  latitude: latitudeController.text,
                                  longitude: longitudeController.text,
                                );
                                await Provider.of<AddressProvider>(context, listen: false).updateAddress(updatedAddress);
                              }
                              Navigator.pop(context);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Save failed: $e")),
                              );
                            } finally {
                              isSaving.value = false;
                            }
                          },
                    child: saving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : Text(existingAddress == null ? "Add Address" : "Update Address"),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
