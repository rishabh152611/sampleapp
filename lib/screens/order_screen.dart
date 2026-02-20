
// import 'package:flutter/material.dart';
// import 'package:sampleapp/models/order_model.dart';
// import 'package:sampleapp/services/order_service.dart';
// import '../widgets/order_details_screen.dart';

// class OrdersScreen extends StatefulWidget {
//   const OrdersScreen({super.key});

//   @override
//   State<OrdersScreen> createState() => _OrdersScreenState();
// }

// class _OrdersScreenState extends State<OrdersScreen> {
//   final OrderService _orderService = OrderService();
//   List<OrderModel> _orders = [];
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchOrders();
//   }

//   Future<void> fetchOrders() async {
//     setState(() => _isLoading = true);
//     try {
//       _orders = await _orderService.getAllOrders();
//     } catch (e) {
//       print("Error fetching orders: $e");
//       _orders = [];
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("My Orders")),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : _orders.isEmpty
//               ? const Center(child: Text("No orders found"))
//               : RefreshIndicator(
//                   onRefresh: fetchOrders,
//                   child: ListView.builder(
//                     itemCount: _orders.length,
//                     itemBuilder: (context, index) {
//                       final order = _orders[index];
//                       return Card(
//                         margin: const EdgeInsets.all(8),
//                         child: ListTile(
//                           title: Text("Order ID: ${order.sId}"),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text("Total: \$${order.total}"),
//                               Text("Payment: ${order.paymentStatus}"),
//                               Text("Status: ${order.orderStatus}"),
//                               const SizedBox(height: 4),
//                               Text(
//                                 "Items: ${order.items?.map((e) => e.name).join(", ")}",
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ],
//                           ),
//                           // Remove pay button here
//                           onTap: () async {
//                             // Navigate to order details and refresh list after return
//                             await Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_) => OrderDetailsScreen(order: order),
//                               ),
//                             );
//                             fetchOrders(); // refresh after returning
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sampleapp/providers/order_provider.dart';
// import '../widgets/order_details_screen.dart';

// class OrdersScreen extends StatefulWidget {
//   const OrdersScreen({super.key});

//   @override
//   State<OrdersScreen> createState() => _OrdersScreenState();
// }

// class _OrdersScreenState extends State<OrdersScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Fetch orders when screen loads
//     Future.microtask(() {
//       Provider.of<OrderProvider>(context, listen: false).fetchOrders();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final orderProvider = Provider.of<OrderProvider>(context);

//     return Scaffold(
//       appBar: AppBar(title: const Text("My Orders")),
//       body: orderProvider.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : orderProvider.errorMessage != null
//               ? Center(child: Text(orderProvider.errorMessage!))
//               : orderProvider.orders.isEmpty
//                   ? const Center(child: Text("No orders found"))
//                   : RefreshIndicator(
//                       onRefresh: () => orderProvider.fetchOrders(),
//                       child: ListView.builder(
//                         itemCount: orderProvider.orders.length,
//                         itemBuilder: (context, index) {
//                           final order = orderProvider.orders[index];

//                           return Card(
//                             margin: const EdgeInsets.all(8),
//                             child: ListTile(
//                               title: Text("Order ID: ${order.sId}"),
//                               subtitle: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text("Total: \$${order.total}"),
//                                   Text("Payment: ${order.paymentStatus}"),
//                                   Text("Status: ${order.orderStatus}"),
//                                   const SizedBox(height: 4),
//                                   Text(
//                                     "Items: ${order.items?.map((e) => e.name).join(", ")}",
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ],
//                               ),
//                               onTap: () async {
//                                 // Navigate to order details screen
//                                 await Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (_) =>
//                                         OrderDetailsScreen(order: order),
//                                   ),
//                                 );
//                                 // Refresh orders after returning
//                                 await orderProvider.fetchOrders();
//                               },
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleapp/providers/order_provider.dart';
import '../widgets/order_details_screen.dart';
import '../models/order_model.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<OrderProvider>(context, listen: false).fetchOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("My Orders")),
      body: orderProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : orderProvider.errorMessage != null
              ? Center(child: Text(orderProvider.errorMessage!))
              : orderProvider.orders.isEmpty
                  ? const Center(child: Text("No orders found"))
                  : RefreshIndicator(
                      onRefresh: () => orderProvider.fetchOrders(),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: orderProvider.orders.length,
                        itemBuilder: (context, index) {
                          final order = orderProvider.orders[index];
                          return OrderCard(
                            order: order,
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      OrderDetailsScreen(order: order),
                                ),
                              );
                              await orderProvider.fetchOrders();
                            },
                          );
                        },
                      ),
                    ),
    );
  }
}

/// Reusable Order Card Widget
class OrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback? onTap;

  const OrderCard({super.key, required this.order, this.onTap});

  @override
  Widget build(BuildContext context) {
    final firstImage = order.items?.isNotEmpty == true
        ? order.items!.first.image
        : null;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order header with image and basic info
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: firstImage != null
                        ? CachedNetworkImage(
                            imageUrl: firstImage,
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            height: 80,
                            width: 80,
                            color: Colors.grey.shade200,
                            child: const Icon(Icons.image, size: 40),
                          ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order ID: ${order.sId}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Total: \$${order.total?.toStringAsFixed(2) ?? '0.00'}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.info_outline,
                                size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              order.orderStatus ?? "Unknown",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _getStatusColor(order.orderStatus),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Icon(Icons.payment,
                                size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              order.paymentStatus ?? "-",
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 20, thickness: 1),
              // Items list
              if (order.items != null && order.items!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Items:",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    ...order.items!.map(
                      (item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item.name ?? "-",
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            Text("x${item.quantity ?? 1}",
                                style: const TextStyle(fontSize: 14)),
                            const SizedBox(width: 8),
                            Text("\$${item.price?.toStringAsFixed(2) ?? '0.00'}",
                                style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
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
      case "cancelled":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
