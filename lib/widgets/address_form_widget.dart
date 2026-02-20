import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

import 'package:sampleapp/models/address_model.dart';
import 'package:sampleapp/providers/address_provider.dart';

import '../models/user_details_model.dart';

class AddressFormSheet extends StatefulWidget {
  final Addresses? existingAddress;

  const AddressFormSheet({super.key, this.existingAddress});

  @override
  State<AddressFormSheet> createState() => _AddressFormSheetState();
}

class _AddressFormSheetState extends State<AddressFormSheet> {
  late final TextEditingController labelController;
  late final TextEditingController streetController;
  late final TextEditingController cityController;
  late final TextEditingController stateController;
  late final TextEditingController zipController;
  late final TextEditingController countryController;
  late final TextEditingController latitudeController;
  late final TextEditingController longitudeController;

  final ValueNotifier<bool> isFetchingLocation = ValueNotifier(false);
  final ValueNotifier<bool> isSaving = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    labelController = TextEditingController(text: widget.existingAddress?.label ?? '');
    streetController = TextEditingController(text: widget.existingAddress?.street ?? '');
    cityController = TextEditingController(text: widget.existingAddress?.city ?? '');
    stateController = TextEditingController(text: widget.existingAddress?.state ?? '');
    zipController = TextEditingController(text: widget.existingAddress?.zip ?? '');
    countryController = TextEditingController(text: widget.existingAddress?.country ?? '');
    latitudeController = TextEditingController(text: widget.existingAddress?.latitude ?? '');
    longitudeController = TextEditingController(text: widget.existingAddress?.longitude ?? '');
  }

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
      return Future.error('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              widget.existingAddress == null ? "Add Address" : "Update Address",
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
            TextField(controller: latitudeController, readOnly: true, decoration: const InputDecoration(labelText: 'Latitude')),
            TextField(controller: longitudeController, readOnly: true, decoration: const InputDecoration(labelText: 'Longitude')),
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
                          width: 16, height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.my_location),
                  label: Text(fetching ? "Fetching..." : "Fetch Coordinates"),
                );
              },
            ),
            const SizedBox(height: 16),

            // Save button
            ValueListenableBuilder<bool>(
              valueListenable: isSaving,
              builder: (_, saving, __) {
                return ElevatedButton(
                  onPressed: saving
                      ? null
                      : () async {
                          isSaving.value = true;
                          try {
                            if (widget.existingAddress == null) {
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
                                addressId: widget.existingAddress!.addressId,
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
                          width: 20, height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : Text(widget.existingAddress == null ? "Add Address" : "Update Address"),
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
