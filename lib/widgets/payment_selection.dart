// // import 'package:flutter/material.dart';
// // import 'package:sampleapp/screens/home_scren.dart';
// // import 'package:sampleapp/services/order_service.dart';
// // import 'package:sampleapp/services/auth_service.dart';
// // import 'package:provider/provider.dart';
// // import 'package:sampleapp/providers/cart_provider.dart';

// // class PaymentSelectionScreen extends StatefulWidget {
// //   final dynamic address;
// //   final double totalPrice;
// //   final String? storeId;

// //   const PaymentSelectionScreen({
// //     super.key,
// //     required this.address,
// //     required this.totalPrice,
// //     this.storeId,
// //   });

// //   @override
// //   State<PaymentSelectionScreen> createState() => _PaymentSelectionScreenState();
// // }

// // class _PaymentSelectionScreenState extends State<PaymentSelectionScreen> {
// //   String? _selectedMethod;
// //   bool _isPlacingOrder = false;
// //   final OrderService _orderService = OrderService();
// //   final AuthService authService = AuthService();

// //   Future<String> _generateOrderId() async {
// //     final userId = await authService.getUserId();
// //     final timestamp = DateTime.now().millisecondsSinceEpoch;
// //     return "$userId-$timestamp";
// //   }

// //   Future<void> _placeOrder() async {
// //     if (_selectedMethod == null) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text("Please select a payment method")),
// //       );
// //       return;
// //     }

// //     setState(() => _isPlacingOrder = true);
// //     try {
// //       final orderId = await _generateOrderId();

// //       String? paymentId;
// //       String paymentStatus;
// //       String storeId =  widget.storeId ?? "";

// //       if (_selectedMethod == "Cash on Delivery") {
// //         paymentId = null;
// //         paymentStatus = "Pending";
// //       } else {
// //         paymentId = "txn_${DateTime.now().millisecondsSinceEpoch}";
// //         paymentStatus = "Success";
// //       }

// //       final success = await _orderService.createOrder(
// //         widget.address.addressId!,
// //         _selectedMethod!,
// //         paymentStatus,
// //         paymentId ?? "null",
// //         orderId,
// //         storeId
// //       );

// //       if (success && mounted) {
// //         // clear cart
// //         Provider.of<CartProvider>(context, listen: false).cartItems.clear();

// //         Navigator.pushAndRemoveUntil(
// //           context,
// //           MaterialPageRoute(
// //             builder: (_) => HomeScren(),
// //           ),
// //           (route) => false,
// //         );
// //       }
// //     } catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("Failed: $e")),
// //       );
// //     } finally {
// //       setState(() => _isPlacingOrder = false);
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Select Payment Method")),
// //       body: Column(
// //         children: [
// //           ListTile(
// //             title: const Text("Deliver To"),
// //             subtitle: Text(
// //               "${widget.address.street}, ${widget.address.city}, ${widget.address.state}, ${widget.address.zip}, ${widget.address.country}",
// //             ),
// //           ),
// //           RadioListTile<String>(
// //             title: const Text("Cash on Delivery"),
// //             value: "Cash on Delivery",
// //             groupValue: _selectedMethod,
// //             onChanged: (val) => setState(() => _selectedMethod = val),
// //           ),
// //           RadioListTile<String>(
// //             title: const Text("Online Payment"),
// //             value: "Online",
// //             groupValue: _selectedMethod,
// //             onChanged: (val) => setState(() => _selectedMethod = val),
// //           ),
// //           const SizedBox(height: 20),
// //           _isPlacingOrder
// //               ? const CircularProgressIndicator()
// //               : ElevatedButton(
// //                   onPressed: _placeOrder,
// //                   child: const Text("Place Order"),
// //                 ),
// //         ],
// //       ),
// //     );
// //   }
// // }


// import 'package:flutter/material.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfdropcheckoutpayment.dart';

// import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
// import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
// import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';

// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:sampleapp/services/order_service.dart';
// import 'package:sampleapp/services/auth_service.dart';
// import 'package:sampleapp/providers/cart_provider.dart';
// import 'package:sampleapp/screens/home_scren.dart';

// class PaymentSelectionScreen extends StatefulWidget {
//   final dynamic address;
//   final double totalPrice;
//   final String? storeId;

//   const PaymentSelectionScreen({
//     super.key,
//     required this.address,
//     required this.totalPrice,
//     this.storeId,
//   });

//   @override
//   State<PaymentSelectionScreen> createState() => _PaymentSelectionScreenState();
// }

// class _PaymentSelectionScreenState extends State<PaymentSelectionScreen> {
//   String? _selectedMethod;
//   bool _isPlacingOrder = false;

//   final OrderService _orderService = OrderService();
//   final AuthService authService = AuthService();

//   // Cashfree variables
//   CFPaymentGatewayService cfPaymentGatewayService = CFPaymentGatewayService();
//   static const clientId = 'TEST106725695c949e5b51106a0f061796527601';
//   static const clientSecret = 'cfsk_ma_test_de7445b385ba6c73b2a8e3f384aa8abc_a757ce74';

//   @override
//   void initState() {
//     super.initState();
//     print(widget.storeId);
//   }

//   Future<String> _generateOrderId() async {
//     final userId = await authService.getUserId();
//     final timestamp = DateTime.now().millisecondsSinceEpoch;
//     return "$userId-$timestamp";
//   }

//   Future<CFSession?> _createPaymentSession(String orderId) async {
//     final url = Uri.parse('https://sandbox.cashfree.com/pg/orders');
//     final headers = {
//       'accept': 'application/json',
//       'content-type': 'application/json',
//       'x-api-version': '2025-01-01',
//       'x-client-id': clientId,
//       'x-client-secret': clientSecret,
//     };

//     final body = jsonEncode({
//       "order_amount": widget.totalPrice,
//       "order_currency": "INR",
//       "customer_details": {
//         "customer_id": orderId,
//         "customer_name": "widget.address.name",
//         "customer_email":"email@example.com",
//         "customer_phone": "9876543210"
//       },
//       "order_meta": {
//         "return_url": "https://www.cashfree.com"
//       },
//       "order_id": orderId,
//     });

//     try {
//       final response = await http.post(url, headers: headers, body: body);
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final data = jsonDecode(response.body);
//         return CFSessionBuilder()
//             .setEnvironment(CFEnvironment.SANDBOX)
//             .setOrderId(orderId)
//             .setPaymentSessionId(data['payment_session_id'])
//             .build();
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Failed to create payment session: ${response.body}")),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Exception: $e")),
//       );
//     }
//     return null;
//   }

//   Future<Map<String, String>?> _makeOnlinePayment(String orderId) async {
//     Map<String, String>? result;

//     cfPaymentGatewayService.setCallback((orderIdFromSdk) {
//       final timestamp = DateTime.now().millisecondsSinceEpoch;
//       final paymentId = "$orderId-DROP-$timestamp";
//       result = {
//         "paymentId": paymentId,
//         "paymentMethod": "DROP_CHECKOUT",
//         "paymentStatus": "SUCCESS"
//       };
//     }, (errorResponse, orderIdFromSdk) {
//       final timestamp = DateTime.now().millisecondsSinceEpoch;
//       final paymentId = "$orderId-DROP-$timestamp";
//       result = {
//         "paymentId": paymentId,
//         "paymentMethod": "DROP_CHECKOUT",
//         "paymentStatus": "FAILED",
//         "error": errorResponse.toString()
//       };
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Payment Failed: ${errorResponse.toString()}")),
//       );
//     });

//     final session = await _createPaymentSession(orderId);
//     if (session != null) {
//       await cfPaymentGatewayService.doPayment(
//         CFDropCheckoutPaymentBuilder().setSession(session).build(),
//       );

//       // Wait until callback sets result
//       while (result == null) {
//         await Future.delayed(const Duration(milliseconds: 500));
//       }
//       return result;
//     }
//     return null;
//   }

//   Future<void> _placeOrder() async {

  
//     if (_selectedMethod == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Select a payment method")),
//       );
//       return;
//     }

//     setState(() => _isPlacingOrder = true);

//     try {
//       final orderId = await _generateOrderId();
//       String? paymentId;
//       String paymentStatus;
//       String paymentMethod = _selectedMethod!;
//       String storeid = widget.storeId!;

//       if (_selectedMethod == "Cash on Delivery") {
//         paymentId = null;
//         paymentStatus = "Pending";
//       } else {
//         final paymentResult = await _makeOnlinePayment(orderId);
//         if (paymentResult == null || paymentResult['paymentStatus'] == "FAILED") {
//           setState(() => _isPlacingOrder = false);
//           return; // stay on same screen
//         }
//         paymentId = paymentResult['paymentId'];
//         paymentStatus = paymentResult['paymentStatus']!;
//         paymentMethod = paymentResult['paymentMethod']!;
//       }


//       final success = await _orderService.createOrder(
//         widget.address.addressId!,
//         paymentMethod,
//         paymentStatus,
//         paymentId ?? "null",
//         orderId,
//         storeid,
//       );

//       if (success && mounted) {
//         Provider.of<CartProvider>(context, listen: false).cartItems.clear();
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (_) => HomeScren()),
//           (route) => false,
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Failed: $e")),
//       );
//     } finally {
//       setState(() => _isPlacingOrder = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Select Payment Method")),
//       body: Column(
//         children: [
//           ListTile(
//             title: const Text("Deliver To"),
//             subtitle: Text(
//               "${widget.address.street}, ${widget.address.city}, ${widget.address.state}, ${widget.address.zip}, ${widget.address.country}",
//             ),
//           ),
//           RadioListTile<String>(
//             title: const Text("Cash on Delivery"),
//             value: "Cash on Delivery",
//             groupValue: _selectedMethod,
//             onChanged: (val) => setState(() => _selectedMethod = val),
//           ),
//           RadioListTile<String>(
//             title: const Text("Online Payment"),
//             value: "Online",
//             groupValue: _selectedMethod,
//             onChanged: (val) => setState(() => _selectedMethod = val),
//           ),
//           const SizedBox(height: 20),
//           _isPlacingOrder
//               ? const CircularProgressIndicator()
//               : ElevatedButton(
//                   onPressed: _placeOrder,
//                   child: const Text("Place Order"),
//                 ),
//         ],
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfdropcheckoutpayment.dart';

import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sampleapp/services/order_service.dart';
import 'package:sampleapp/services/auth_service.dart';
import 'package:sampleapp/providers/cart_provider.dart';
import 'package:sampleapp/screens/home_scren.dart';

class PaymentSelectionScreen extends StatefulWidget {
  final dynamic address;
  final double totalPrice;
  final String? storeId;

  const PaymentSelectionScreen({
    super.key,
    required this.address,
    required this.totalPrice,
    this.storeId,
  });

  @override
  State<PaymentSelectionScreen> createState() => _PaymentSelectionScreenState();
}

class _PaymentSelectionScreenState extends State<PaymentSelectionScreen> {
  String? _selectedMethod;
  bool _isPlacingOrder = false;

  final OrderService _orderService = OrderService();
  final AuthService authService = AuthService();

  // Cashfree variables
  CFPaymentGatewayService cfPaymentGatewayService = CFPaymentGatewayService();
  static const clientId = 'TEST106725695c949e5b51106a0f061796527601';
  static const clientSecret = 'cfsk_ma_test_de7445b385ba6c73b2a8e3f384aa8abc_a757ce74';

  @override
  void initState() {
    super.initState();
    print(widget.storeId);
  }

  Future<String> _generateOrderId() async {
    final userId = await authService.getUserId();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return "$userId-$timestamp";
  }

  Future<CFSession?> _createPaymentSession(String orderId) async {
    final url = Uri.parse('https://sandbox.cashfree.com/pg/orders');
    final headers = {
      'accept': 'application/json',
      'content-type': 'application/json',
      'x-api-version': '2025-01-01',
      'x-client-id': clientId,
      'x-client-secret': clientSecret,
    };

    final body = jsonEncode({
      "order_amount": widget.totalPrice,
      "order_currency": "INR",
      "customer_details": {
        "customer_id": orderId,
        "customer_name": "widget.address.name",
        "customer_email":"email@example.com",
        "customer_phone": "9876543210"
      },
      "order_meta": {
        "return_url": "https://www.cashfree.com"
      },
      "order_id": orderId,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return CFSessionBuilder()
            .setEnvironment(CFEnvironment.SANDBOX)
            .setOrderId(orderId)
            .setPaymentSessionId(data['payment_session_id'])
            .build();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to create payment session: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Exception: $e")),
      );
    }
    return null;
  }

  Future<Map<String, String>?> _makeOnlinePayment(String orderId) async {
    Map<String, String>? result;

    cfPaymentGatewayService.setCallback((orderIdFromSdk) {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final paymentId = "$orderId-DROP-$timestamp";
      result = {
        "paymentId": paymentId,
        "paymentMethod": "DROP_CHECKOUT",
        "paymentStatus": "SUCCESS"
      };
    }, (errorResponse, orderIdFromSdk) {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final paymentId = "$orderId-DROP-$timestamp";
      result = {
        "paymentId": paymentId,
        "paymentMethod": "DROP_CHECKOUT",
        "paymentStatus": "FAILED",
        "error": errorResponse.toString()
      };
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Payment Failed: ${errorResponse.toString()}")),
      );
    });

    final session = await _createPaymentSession(orderId);
    if (session != null) {
      await cfPaymentGatewayService.doPayment(
        CFDropCheckoutPaymentBuilder().setSession(session).build(),
      );

      // Wait until callback sets result
      while (result == null) {
        await Future.delayed(const Duration(milliseconds: 500));
      }
      return result;
    }
    return null;
  }

  Future<void> _placeOrder() async {
  if (_selectedMethod == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Select a payment method")),
    );
    return;
  }

  setState(() => _isPlacingOrder = true);

  try {
    final orderId = await _generateOrderId();
    String? paymentId;
    String paymentStatus;
    String paymentMethod = _selectedMethod!;
    String storeid = widget.storeId!;

    if (_selectedMethod == "Cash on Delivery") {
      paymentId = null;
      paymentStatus = "Pending";
    } else {
      final paymentResult = await _makeOnlinePayment(orderId);

      if (paymentResult == null) {
        setState(() => _isPlacingOrder = false);
        return;
      }

      paymentId = paymentResult['paymentId'];
      paymentStatus = paymentResult['paymentStatus']!;
      paymentMethod = paymentResult['paymentMethod']!;

      // Only proceed if status is SUCCESS or PENDING
      if (paymentStatus != "SUCCESS" && paymentStatus != "PENDING") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Payment not completed: $paymentStatus")),
        );
        setState(() => _isPlacingOrder = false);
        return; // do not create order
      }
    }

    // Create order only if payment is SUCCESS or PENDING
    final success = await _orderService.createOrder(
      widget.address.addressId!,
      paymentMethod,
      paymentStatus,
      paymentId ?? "null",
      orderId,
      storeid,
    );

    if (success && mounted) {
      Provider.of<CartProvider>(context, listen: false).cartItems.clear();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => HomeScren()),
        (route) => false,
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Failed: $e")),
    );
  } finally {
    setState(() => _isPlacingOrder = false);
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Payment Method")),
      body: Column(
        children: [
          ListTile(
            title: const Text("Deliver To"),
            subtitle: Text(
              "${widget.address.street}, ${widget.address.city}, ${widget.address.state}, ${widget.address.zip}, ${widget.address.country}",
            ),
          ),
          RadioListTile<String>(
            title: const Text("Cash on Delivery"),
            value: "Cash on Delivery",
            groupValue: _selectedMethod,
            onChanged: (val) => setState(() => _selectedMethod = val),
          ),
          RadioListTile<String>(
            title: const Text("Online Payment"),
            value: "Online",
            groupValue: _selectedMethod,
            onChanged: (val) => setState(() => _selectedMethod = val),
          ),
          const SizedBox(height: 20),
          _isPlacingOrder
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: _placeOrder,
                  child: const Text("Place Order"),
                ),
        ],
      ),
    );
  }
}
