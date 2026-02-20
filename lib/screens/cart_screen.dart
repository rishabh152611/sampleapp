// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:sampleapp/providers/cart_provider.dart';
// // import 'package:sampleapp/providers/user_provider.dart';
// // import '../widgets/address_selection_screen.dart';

// // class CartScreen extends StatefulWidget {
// //   const CartScreen({super.key});

// //   @override
// //   State<CartScreen> createState() => _CartScreenState();
// // }

// // class _CartScreenState extends State<CartScreen> {
// //   @override
// //   void initState() {
// //     super.initState();
// //     Future.microtask(() {
// //       Provider.of<CartProvider>(context, listen: false).fetchCartItems();
// //       Provider.of<UserProvider>(context, listen: false).fetchUserDetails();
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final cartProvider = Provider.of<CartProvider>(context);

// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Cart")),
// //       body:
// //           cartProvider.isLoading
// //               ? const Center(child: CircularProgressIndicator())
// //               : cartProvider.cartItems.isEmpty
// //               ? const Center(child: Text("No items in cart"))
// //               : Column(
// //                 children: [
// //                   // Cart items list
// //                   Expanded(
// //                     child: ListView.builder(
// //                       itemCount: cartProvider.cartItems.length,
// //                       itemBuilder: (context, index) {
// //                         final item = cartProvider.cartItems[index];
// //                         final product = item.product;
// //                         final productId = item.productId;

// //                         if (product == null || productId == null) {
// //                           return const SizedBox();
// //                         }

// //                         final price = product.price![0];
// //                         final subtotal = price * (item.quantity ?? 1);

// //                         return Card(
// //                           margin: const EdgeInsets.symmetric(
// //                             vertical: 4,
// //                             horizontal: 8,
// //                           ),
// //                           child: ListTile(
// //                             leading:
// //                                 product.images != null &&
// //                                         product.images!.isNotEmpty
// //                                     ? Image.network(
// //                                       product.images!.first.url ?? "",
// //                                       width: 50,
// //                                       height: 50,
// //                                       fit: BoxFit.cover,
// //                                     )
// //                                     : const Icon(Icons.image_not_supported),
// //                             title: Text(product.name ?? "Product $productId"),
// //                             subtitle: Column(
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               children: [
// //                                 Text("Qty: ${item.quantity ?? 0}"),
// //                                 Text("Price: \$${price.toStringAsFixed(2)}"),
// //                                 Text(
// //                                   "Subtotal: \$${subtotal.toStringAsFixed(2)}",
// //                                   style: const TextStyle(
// //                                     fontWeight: FontWeight.bold,
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                             trailing: IconButton(
// //                               icon: const Icon(Icons.delete, color: Colors.red),
// //                               onPressed: () {
// //                                 cartProvider.removeItem(productId);
// //                               },
// //                             ),
// //                           ),
// //                         );
// //                       },
// //                     ),
// //                   ),

// //                   // Total + Next button
// //                   Container(
// //                     padding: const EdgeInsets.all(16),
// //                     decoration: BoxDecoration(
// //                       color: Colors.grey.shade100,
// //                       border: const Border(
// //                         top: BorderSide(color: Colors.black12),
// //                       ),
// //                     ),
// //                     child: Column(
// //                       children: [
// //                         Row(
// //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                           children: [
// //                             const Text(
// //                               "Total:",
// //                               style: TextStyle(
// //                                 fontSize: 18,
// //                                 fontWeight: FontWeight.bold,
// //                               ),
// //                             ),
// //                             Text(
// //                               "\$${cartProvider.totalPrice.toStringAsFixed(2)}",
// //                               style: const TextStyle(
// //                                 fontSize: 18,
// //                                 fontWeight: FontWeight.bold,
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                         const SizedBox(height: 12),
// //                         SizedBox(
// //                           width: double.infinity,
// //                           child: ElevatedButton(
// //                             onPressed: () async {
// //                               if (cartProvider.cartItems.isEmpty) {
// //                                 ScaffoldMessenger.of(context).showSnackBar(
// //                                   const SnackBar(
// //                                     content: Text(
// //                                       "Cart is empty. Add items first.",
// //                                     ),
// //                                   ),
// //                                 );
// //                                 return;
// //                               }

// //                               // Navigate to address selection
// //                               await Navigator.push(
// //                                 context,
// //                                 MaterialPageRoute(
// //                                   builder:
// //                                       (_) => AddressSelectionScreen(
// //                                         totalPrice:
// //                                             cartProvider.totalPrice.toDouble(),
// //                                         storeId: cartProvider.cartItems.first.product!.store.storeId!,

// //                                       ),
// //                                 ),
// //                               );
// //                             },
// //                             child: const Text("Next"),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sampleapp/providers/cart_provider.dart';
// import 'package:sampleapp/providers/user_provider.dart';
// import '../widgets/address_selection_screen.dart';

// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});

//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       Provider.of<CartProvider>(context, listen: false).fetchCartItems();
//       Provider.of<UserProvider>(context, listen: false).fetchUserDetails();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cartProvider = Provider.of<CartProvider>(context);

//     return Scaffold(
//       appBar: AppBar(title: const Text("Cart")),
//       body: cartProvider.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : cartProvider.cartItems.isEmpty
//               ? const Center(child: Text("No items in cart"))
//               : Column(
//                   children: [
//                     // Cart items list
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: cartProvider.cartItems.length,
//                         itemBuilder: (context, index) {
//                           final item = cartProvider.cartItems[index];
//                           final product = item.product;
//                           final productId = item.productId;

//                           if (product == null || productId == null) {
//                             return const SizedBox();
//                           }

//                           final price = (product.price?.isNotEmpty ?? false)
//                               ? product.price!.first
//                               : 0;
//                           final subtotal = price * (item.quantity ?? 1);

//                           return Card(
//                             margin: const EdgeInsets.symmetric(
//                               vertical: 4,
//                               horizontal: 8,
//                             ),
//                             child: ListTile(
//                               leading: product.images != null &&
//                                       product.images!.isNotEmpty
//                                   ? Image.network(
//                                       product.images!.first.url ?? "",
//                                       width: 50,
//                                       height: 50,
//                                       fit: BoxFit.cover,
//                                     )
//                                   : const Icon(Icons.image_not_supported),
//                               title: Text(product.name ?? "Product $productId"),
//                               subtitle: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text("Qty: ${item.quantity ?? 0}"),
//                                   Text("Price: \$${price.toStringAsFixed(2)}"),
//                                   Text(
//                                     "Subtotal: \$${subtotal.toStringAsFixed(2)}",
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               trailing: IconButton(
//                                 icon:
//                                     const Icon(Icons.delete, color: Colors.red),
//                                 onPressed: () {
//                                   cartProvider.removeItem(productId);
//                                 },
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),

//                     // Total + Next button
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade100,
//                         border: const Border(
//                           top: BorderSide(color: Colors.black12),
//                         ),
//                       ),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Text(
//                                 "Total:",
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 "\$${cartProvider.totalPrice.toStringAsFixed(2)}",
//                                 style: const TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 12),
//                           SizedBox(
//                             width: double.infinity,
//                             child: ElevatedButton(
//                               onPressed: () async {
//                                 final items = cartProvider.cartItems;

//                                 if (items.isEmpty) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text(
//                                         "Cart is empty. Add items first.",
//                                       ),
//                                     ),
//                                   );
//                                   return;
//                                 }

//                                 final firstItem = items.first;
//                                 final product = firstItem.product;

//                                 print(product!.storeId);

//                                 final storeId = product.storeId;

//                                 await Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (_) => AddressSelectionScreen(
//                                       totalPrice: cartProvider.totalPrice
//                                           .toDouble(),
//                                       storeId: storeId,
//                                     ),
//                                   ),
//                                 );
//                               },
//                               child: const Text("Next"),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sampleapp/providers/cart_provider.dart';
// import 'package:sampleapp/providers/user_provider.dart';
// import '../widgets/address_selection_screen.dart';

// class CartScreen extends StatefulWidget {
//   const CartScreen({super.key});

//   @override
//   State<CartScreen> createState() => _CartScreenState();
// }

// class _CartScreenState extends State<CartScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       Provider.of<CartProvider>(context, listen: false).fetchCartItems();
//       Provider.of<UserProvider>(context, listen: false).fetchUserDetails();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cartProvider = Provider.of<CartProvider>(context);

//     return Scaffold(
//       appBar: AppBar(title: const Text("Cart")),
//       body: cartProvider.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : cartProvider.cartItems.isEmpty
//               ? const Center(child: Text("No items in cart"))
//               : Column(
//                   children: [
//                     // Cart items list
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: cartProvider.cartItems.length,
//                         itemBuilder: (context, index) {
//                           final item = cartProvider.cartItems[index];
//                           final product = item.product;
//                           final productId = item.productId;

//                           if (product == null || productId == null) {
//                             return const SizedBox();
//                           }

//                           // Use optionIndex to get selected size and price
//                           final sizeIndex = item.optionIndex ?? 0;
//                           final colorIndex = item.colorIndex ?? 0;

//                           final selectedSize = (product.size != null &&
//                                   product.size!.length > sizeIndex)
//                               ? product.size![sizeIndex]
//                               : "-";

//                           final selectedPrice = (product.price != null &&
//                                   product.price!.length > sizeIndex)
//                               ? product.price![sizeIndex]
//                               : 0;

//                           final selectedColor = (product.availability != null &&
//                                   product.availability!.length > colorIndex)
//                               ? product.availability![colorIndex]
//                               : "-";

//                           final subtotal = selectedPrice * (item.quantity ?? 1);

//                           return Card(
//                             margin: const EdgeInsets.symmetric(
//                               vertical: 4,
//                               horizontal: 8,
//                             ),
//                             child: ListTile(
//                               leading: product.images != null &&
//                                       product.images!.isNotEmpty
//                                   ? Image.network(
//                                       product.images!.first.url ?? "",
//                                       width: 50,
//                                       height: 50,
//                                       fit: BoxFit.cover,
//                                     )
//                                   : const Icon(Icons.image_not_supported),
//                               title: Text(product.name ?? "Product $productId"),
//                               subtitle: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text("Size: $selectedSize"),
//                                   Text("Color: $selectedColor"),
//                                   Text("Qty: ${item.quantity ?? 0}"),
//                                   Text(
//                                     "Price: \$${selectedPrice.toStringAsFixed(2)}",
//                                   ),
//                                   Text(
//                                     "Subtotal: \$${subtotal.toStringAsFixed(2)}",
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               trailing: IconButton(
//                                 icon:
//                                     const Icon(Icons.delete, color: Colors.red),
//                                 onPressed: () {
//                                   cartProvider.removeItem(productId);
//                                 },
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),

//                     // Total + Next button
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade100,
//                         border: const Border(
//                           top: BorderSide(color: Colors.black12),
//                         ),
//                       ),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Text(
//                                 "Total:",
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 cartProvider.totalPrice.toStringAsFixed(2),
//                                 style: const TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 12),
//                           SizedBox(
//                             width: double.infinity,
//                             child: ElevatedButton(
//                               onPressed: () async {
//                                 final items = cartProvider.cartItems;

//                                 if (items.isEmpty) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text(
//                                         "Cart is empty. Add items first.",
//                                       ),
//                                     ),
//                                   );
//                                   return;
//                                 }

//                                 final firstItem = items.first;
//                                 final product = firstItem.product;
//                                 final storeId = product?.storeId ?? "";

//                                 await Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (_) => AddressSelectionScreen(
//                                       totalPrice:
//                                           cartProvider.totalPrice.toDouble(),
//                                       storeId: storeId,
//                                     ),
//                                   ),
//                                 );
//                               },
//                               child: const Text("Next"),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleapp/providers/cart_provider.dart';
import 'package:sampleapp/providers/user_provider.dart';
import '../widgets/address_selection_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<UserProvider>(context, listen: false).fetchUserDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body:
          cartProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : cartProvider.cartItems.isEmpty
              ? const Center(child: Text("No items in cart"))
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartProvider.cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartProvider.cartItems[index];
                        final product = item.product;
                        final productId = item.productId;
                        final cartId = item.sId;

                        if (product == null || productId == null) {
                          return const SizedBox();
                        }

                        final sizeIndex = item.optionIndex ?? 0;
                        final colorIndex = item.colorIndex ?? 0;

                        final selectedSize =
                            (product.size != null &&
                                    product.size!.length > sizeIndex)
                                ? product.size![sizeIndex]
                                : "-";

                        final selectedPrice =
                            (product.price != null &&
                                    product.price!.length > sizeIndex)
                                ? product.price![sizeIndex]
                                : 0;

                        final availability =
                            (product.availability != null &&
                                    product.availability!.length > sizeIndex)
                                ? product.availability![sizeIndex]
                                : "-";

                        final selectedColor =
                            (product.color != null &&
                                    product.color!.length > colorIndex)
                                ? product.color![colorIndex]
                                : "-";

                        final subtotal = selectedPrice * (item.quantity ?? 1);

                        return Card(
                          margin: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          child: ListTile(
                            leading:
                                product.images != null &&
                                        product.images!.isNotEmpty
                                    ? Image.network(
                                      product.images!.first.url ?? "",
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    )
                                    : const Icon(Icons.image_not_supported),
                            title: Text(product.name ?? "Product $productId"),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Size: $selectedSize"),
                                Text("Availability: $availability"),
                                Text("Color: $selectedColor"),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.remove_circle_outline,
                                      ),
                                      onPressed:
                                          (item.quantity ?? 1) > 1 &&
                                                  !cartProvider.isUpdating(
                                                    productId,
                                                  )
                                              ? () async {
                                                cartProvider
                                                    .decreaseQuantityLocal(
                                                      productId,
                                                    );
                                                await cartProvider
                                                    .updateQuantity(productId);
                                              }
                                              : null,
                                    ),
                                    Text("${item.quantity ?? 0}"),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.add_circle_outline,
                                      ),
                                      onPressed:
                                          !cartProvider.isUpdating(productId)
                                              ? () async {
                                                cartProvider
                                                    .increaseQuantityLocal(
                                                      productId,
                                                    );
                                                await cartProvider
                                                    .updateQuantity(productId);
                                              }
                                              : null,
                                    ),
                                    if (cartProvider.isUpdating(productId))
                                      const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                  ],
                                ),
                                Text(
                                  "Price: \$${selectedPrice.toStringAsFixed(2)}",
                                ),
                                Text(
                                  "Subtotal: \$${subtotal.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            trailing:
                                cartProvider.isDeleting(cartId!)
                                    ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                    : IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () async {
                                        await cartProvider.removeItem(cartId);
                                      },
                                    ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Total + Next button
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      border: const Border(
                        top: BorderSide(color: Colors.black12),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Total:",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "\$${cartProvider.totalPrice.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              final items = cartProvider.cartItems;
                              if (items.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Cart is empty. Add items first.",
                                    ),
                                  ),
                                );
                                return;
                              }

                              final firstItem = items.first;
                              final storeId = firstItem.product?.storeId ;
                              print(  " storeId is $storeId");

                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => AddressSelectionScreen(
                                        totalPrice:
                                            cartProvider.totalPrice.toDouble(),
                                        storeId: storeId,
                                      ),
                                ),
                              );
                            },
                            child: const Text("Next"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
