

// // import 'package:flutter/material.dart';
// // import 'package:sampleapp/models/order_model.dart';
// // import 'package:sampleapp/services/order_service.dart';

// // class OrderDetailsScreen extends StatefulWidget {
// //   final OrderModel order;
// //   const OrderDetailsScreen({super.key, required this.order});

// //   @override
// //   State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
// // }

// // class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
// //   final OrderService _orderService = OrderService();
// //   bool isPaying = false;
// //   bool isUpdating = false;

// //   Future<void> payOrder() async {
// //     setState(() => isPaying = true);
// //     try {
// //       final success =
// //           await _orderService.updateOrderPaymentStatus(widget.order.sId!, "paid");
// //       if (success) {
// //         ScaffoldMessenger.of(context)
// //             .showSnackBar(const SnackBar(content: Text("Payment successful ✅")));
// //         setState(() {
// //           widget.order.paymentStatus = "paid";
// //         });
// //       }
// //     } catch (e) {
// //       print("Payment error: $e");
// //       ScaffoldMessenger.of(context)
// //           .showSnackBar(const SnackBar(content: Text("Payment failed ❌")));
// //     } finally {
// //       setState(() => isPaying = false);
// //     }
// //   }

// //   Future<void> cancelOrder() async {
// //     setState(() => isUpdating = true);
// //     try {
// //       final success =
// //           await _orderService.updateOrderStatus(widget.order.sId!, "canceled");
// //       if (success) {
// //         ScaffoldMessenger.of(context)
// //             .showSnackBar(const SnackBar(content: Text("Order canceled ✅")));
// //         setState(() {
// //           widget.order.orderStatus = "canceled";
// //         });
// //       }
// //     } catch (e) {
// //       print("Cancel error: $e");
// //       ScaffoldMessenger.of(context)
// //           .showSnackBar(const SnackBar(content: Text("Cancel failed ❌")));
// //     } finally {
// //       setState(() => isUpdating = false);
// //     }
// //   }

// //   Widget buildItemCard(Items item) {
// //     return Card(
// //       margin: const EdgeInsets.symmetric(vertical: 6),
// //       child: ListTile(
// //         title: Text(item.name ?? ""),
// //         subtitle: Text(
// //             "Quantity: ${item.quantity ?? 0}\nSize: ${item.size ?? "-"}, Color: ${item.color ?? "-"}\nPrice: \$${item.price ?? 0}"),
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final order = widget.order;
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Order Details")),
// //       body: SingleChildScrollView(
// //         padding: const EdgeInsets.all(12),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text("Order ID: ${order.sId}",
// //                 style: const TextStyle(fontWeight: FontWeight.bold)),
// //             Text("Total: \$${order.total ?? 0}"),
// //             Text("Payment Status: ${order.paymentStatus ?? "-"}"),
// //             Text("Order Status: ${order.orderStatus ?? "-"}"),
// //             const SizedBox(height: 12),
// //             const Text("Items:", style: TextStyle(fontWeight: FontWeight.bold)),
// //             ...?order.items?.map((item) => buildItemCard(item)),
// //             const SizedBox(height: 12),
// //             const Text("Delivery Address:", style: TextStyle(fontWeight: FontWeight.bold)),
// //             if (order.address != null)
// //               Text(
// //                   "${order.address!.label}, ${order.address!.street}, ${order.address!.city}, ${order.address!.state} ${order.address!.zip}, ${order.address!.country}"),
// //             const SizedBox(height: 20),
// //             if (order.paymentStatus != "paid")
// //               Center(
// //                 child: isPaying
// //                     ? const CircularProgressIndicator()
// //                     : ElevatedButton(
// //                         onPressed: payOrder,
// //                         child: const Text("Pay Now"),
// //                       ),
// //               ),
// //             if (order.orderStatus == "pending")
// //               Center(
// //                 child: isUpdating
// //                     ? const CircularProgressIndicator()
// //                     : ElevatedButton(
// //                         onPressed: cancelOrder,
// //                         child: const Text("Cancel Order"),
// //                       ),
// //               ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }



// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sampleapp/models/order_model.dart';
// import '../providers/order_provider.dart';

// class OrderDetailsScreen extends StatefulWidget {
//   final OrderModel order;
//   const OrderDetailsScreen({super.key, required this.order});

//   @override
//   State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
// }

// class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
//   bool isPaying = false;
//   bool isUpdating = false;

//   Future<void> payOrder() async {
//     final orderProvider = Provider.of<OrderProvider>(context, listen: false);

//     setState(() => isPaying = true);
//     try {
//       final success =
//           await orderProvider.updatePaymentStatus(widget.order.sId!, "paid");
//       if (success) {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(const SnackBar(content: Text("Payment successful ✅")));
//         setState(() {
//           widget.order.paymentStatus = "paid";
//         });
//       }
//     } catch (e) {
//       print("Payment error: $e");
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text("Payment failed ❌")));
//     } finally {
//       setState(() => isPaying = false);
//     }
//   }

//   Future<void> cancelOrder() async {
//     final orderProvider = Provider.of<OrderProvider>(context, listen: false);

//     setState(() => isUpdating = true);
//     try {
//       final success =
//           await orderProvider.updateOrderStatus(widget.order.sId!, "canceled");
//       if (success) {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(const SnackBar(content: Text("Order canceled ✅")));
//         setState(() {
//           widget.order.orderStatus = "canceled";
//         });
//       }
//     } catch (e) {
//       print("Cancel error: $e");
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text("Cancel failed ❌")));
//     } finally {
//       setState(() => isUpdating = false);
//     }
//   }

//   Widget buildItemCard(Items item) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 6),
//       child: ListTile(
//         title: Text(item.name ?? ""),
//         subtitle: Text(
//             "Quantity: ${item.quantity ?? 0}\nSize: ${item.size ?? "-"}, Color: ${item.color ?? "-"}\nPrice: \$${item.price ?? 0}"),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final order = widget.order;

//     return Scaffold(
//       appBar: AppBar(title: const Text("Order Details")),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Order ID: ${order.sId}",
//                 style: const TextStyle(fontWeight: FontWeight.bold)),
//             Text("Total: \$${order.total ?? 0}"),
//             Text("Payment Status: ${order.paymentStatus ?? "-"}"),
//             Text("Order Status: ${order.orderStatus ?? "-"}"),
//             const SizedBox(height: 12),
//             const Text("Items:", style: TextStyle(fontWeight: FontWeight.bold)),
//             ...?order.items?.map((item) => buildItemCard(item)),
//             const SizedBox(height: 12),
//             const Text("Delivery Address:", style: TextStyle(fontWeight: FontWeight.bold)),
//             if (order.address != null)
//               Text(
//                   "${order.address!.label}, ${order.address!.street}, ${order.address!.city}, ${order.address!.state} ${order.address!.zip}, ${order.address!.country}"),
//             const SizedBox(height: 20),
//             if (order.paymentStatus != "paid")
//               Center(
//                 child: isPaying
//                     ? const CircularProgressIndicator()
//                     : ElevatedButton(
//                         onPressed: payOrder,
//                         child: const Text("Pay Now"),
//                       ),
//               ),
//             if (order.orderStatus == "Pending")
//               Center(
//                 child: isUpdating
//                     ? const CircularProgressIndicator()
//                     : ElevatedButton(
//                         onPressed: cancelOrder,
//                         child: const Text("Cancel Order"),
//                       ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleapp/models/order_model.dart';
import '../providers/order_provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrderModel order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  bool isPaying = false;
  bool isUpdating = false;

  Future<void> payOrder() async {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    setState(() => isPaying = true);
    try {
      final success =
          await orderProvider.updatePaymentStatus(widget.order.sId!, "paid");
      if (success) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Payment successful ✅")));
        setState(() {
          widget.order.paymentStatus = "paid";
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Payment failed ❌")));
    } finally {
      setState(() => isPaying = false);
    }
  }

  Future<void> cancelOrder() async {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    setState(() => isUpdating = true);
    try {
      final success =
          await orderProvider.updateOrderStatus(widget.order.sId!, "canceled");
      if (success) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Order canceled ✅")));
        setState(() {
          widget.order.orderStatus = "canceled";
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Cancel failed ❌")));
    } finally {
      setState(() => isUpdating = false);
    }
  }

  Widget buildItemCard(Items item) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Item Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: item.image ?? '',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(strokeWidth: 2),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.image_not_supported, size: 60),
              ),
            ),
            const SizedBox(width: 12),

            // Item Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name ?? "-",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Text("Qty: ${item.quantity ?? 0}"),
                  Text("Size: ${item.size ?? '-'}"),
                  Text("Color: ${item.color ?? '-'}"),
                  Text("\$${item.price?.toStringAsFixed(2) ?? '0.00'}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case "pending":
        return Colors.orange;
      case "completed":
        return Colors.green;
      case "canceled":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order;

    return Scaffold(
      appBar: AppBar(title: const Text("Order Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Summary
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Order ID: ${order.sId}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 6),
                    Text("Total: \$${order.total ?? 0}"),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.info_outline, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          order.orderStatus ?? "-",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _getStatusColor(order.orderStatus)),
                        ),
                        const SizedBox(width: 16),
                        const Icon(Icons.payment, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          order.paymentStatus ?? "-",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Items Section
            const Text("Items:", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            ...?order.items?.map((item) => buildItemCard(item)),

            const SizedBox(height: 12),

            // Address Section
            const Text("Delivery Address:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            if (order.address != null)
              Text(
                  "${order.address!.label}, ${order.address!.street}, ${order.address!.city}, ${order.address!.state} ${order.address!.zip}, ${order.address!.country}"),

            const SizedBox(height: 20),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (order.paymentStatus != "paid")
                  ElevatedButton(
                    onPressed: isPaying ? null : payOrder,
                    child: isPaying
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text("Pay Now"),
                  ),
                if (order.orderStatus?.toLowerCase() == "pending")
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: isUpdating ? null : cancelOrder,
                    child: isUpdating
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white),
                          )
                        : const Text("Cancel Order"),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
