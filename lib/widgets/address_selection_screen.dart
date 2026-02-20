// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sampleapp/providers/user_provider.dart';

// import 'payment_selection.dart';

// class AddressSelectionScreen extends StatelessWidget {
//   final double totalPrice;
//   const AddressSelectionScreen({super.key, required this.totalPrice});

//   @override
//   Widget build(BuildContext context) {
//     final userProvider = Provider.of<UserProvider>(context);
//     final addresses = userProvider.userDetails?.addresses ?? [];

//     return Scaffold(
//       appBar: AppBar(title: const Text("Select Address")),
//       body: addresses.isEmpty
//           ? const Center(child: Text("No addresses found"))
//           : ListView.builder(
//               itemCount: addresses.length,
//               itemBuilder: (context, index) {
//                 final address = addresses[index];
//                 return Card(
//                   child: ListTile(
//                     title: Text(address.label ?? "Address ${index + 1}"),
//                     subtitle: Text(
//                       "${address.street}, ${address.city}, ${address.state}, ${address.zip}, ${address.country}",
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => PaymentSelectionScreen(
//                             address: address,
//                             totalPrice: totalPrice,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleapp/providers/user_provider.dart';
import 'address_form_widget.dart';
import 'payment_selection.dart';
import '../models/address_model.dart';


class AddressSelectionScreen extends StatelessWidget {
  final String? storeId;
  final double totalPrice;
  const AddressSelectionScreen({super.key, required this.totalPrice, required this.storeId});

  void _showAddressForm(BuildContext context, {Addresses? existingAddress}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => AddressFormSheet(existingAddress: existingAddress),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final addresses = userProvider.userDetails?.addresses ?? [];

    return Scaffold(
      appBar: AppBar(title: const Text("Select Address")),
      body: addresses.isEmpty
          ? const Center(child: Text("No addresses found"))
          : ListView.builder(
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    title: Text(address.label ?? "Address ${index + 1}"),
                    subtitle: Text(
                      "${address.street}, ${address.city}, ${address.state}, ${address.zip}, ${address.country}",
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blueGrey),
                      onPressed: () => _showAddressForm(context, existingAddress: address),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PaymentSelectionScreen(
                            address: address,
                            totalPrice: totalPrice,
                            storeId: storeId,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddressForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

