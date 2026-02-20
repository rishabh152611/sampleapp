// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sampleapp/providers/cart_provider.dart';
// import 'package:sampleapp/screens/cart_screen.dart';
// import '../models/product_model.dart';

// class ProductDetailScreen extends StatefulWidget {
//   final Product product;

//   const ProductDetailScreen({super.key, required this.product});

//   @override
//   State<ProductDetailScreen> createState() => _ProductDetailScreenState();
// }

// class _ProductDetailScreenState extends State<ProductDetailScreen> {
//   int _quantity = 1;

//   @override
//   Widget build(BuildContext context) {
//     final cartProvider = Provider.of<CartProvider>(context);

//     final isAdding = cartProvider.isUpdating(widget.product.productId ?? "");

//     return Scaffold(
//       appBar: AppBar(title: Text(widget.product.name ?? 'Product Detail')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             Container(
//               height: 100,
//               width: 100,
//               child:
//                   (widget.product.images?.isNotEmpty ?? false) &&
//                           (widget.product.images!.first.url?.isNotEmpty ??
//                               false)
//                       ? CachedNetworkImage(
//                         imageUrl: widget.product.images!.first.url!,
//                         fit: BoxFit.cover,
//                         placeholder:
//                             (context, url) => const Center(
//                               child: CircularProgressIndicator(strokeWidth: 2),
//                             ),
//                         errorWidget:
//                             (context, url, error) => const Icon(
//                               Icons.image_not_supported,
//                               size: 50,
//                               color: Colors.grey,
//                             ),
//                       )
//                       : const Icon(
//                         Icons.image_not_supported,
//                         size: 50,
//                         color: Colors.grey,
//                       ),
//             ),

//             const SizedBox(height: 16),

//             Text(
//               widget.product.name ?? '',
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Text('Category: ${widget.product.category ?? ''}'),
//             Text('Price: \$${widget.product.price ?? 0}'),
//             Text('Size: ${widget.product.size ?? ''}'),
//             Text('Color: ${widget.product.color ?? ''}'),
//             const SizedBox(height: 8),
//             const Text(
//               'Description:',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text(widget.product.description ?? ''),
//             const SizedBox(height: 8),
//             const Text(
//               'Details:',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text(widget.product.details ?? ''),
//             const SizedBox(height: 8),
//             Text('Fabric: ${widget.product.fabric ?? ''}'),
//             Text('Fit: ${widget.product.fit ?? ''}'),
//             Text('Material Care: ${widget.product.materialCare ?? ''}'),
//             const SizedBox(height: 16),

//             // Quantity selector
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 IconButton(
//                   onPressed:
//                       _quantity > 1
//                           ? () {
//                             setState(() {
//                               _quantity--;
//                             });
//                           }
//                           : null,
//                   icon: const Icon(Icons.remove_circle_outline),
//                 ),
//                 Text(
//                   "$_quantity",
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     setState(() {
//                       _quantity++;
//                     });
//                   },
//                   icon: const Icon(Icons.add_circle_outline),
//                 ),
//               ],
//             ),

//             // Add to cart button
//             Center(
//               child:
//                   isAdding
//                       ? const SizedBox(
//                         width: 40,
//                         height: 40,
//                         child: CircularProgressIndicator(strokeWidth: 2),
//                       )
//                       : ElevatedButton(
//                         onPressed: () async {
//                           try {
//                             await cartProvider.addItemToCart(
//                               widget.product.productId ?? "",
//                               _quantity,
//                               0,
//                               0
//                             );

//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(content: Text("Added to cart ✅")),
//                             );
//                           } catch (e) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text("Error: $e")),
//                             );
//                           }
//                         },
//                         child: const Text('Add to Cart'),
//                       ),
//             ),
//             const SizedBox(height: 10),

//             // Cart screen button
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const CartScreen()),
//                   );
//                 },
//                 child: const Text('Go to Cart'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleapp/providers/cart_provider.dart';
import 'package:sampleapp/screens/cart_screen.dart';
import '../models/product_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  int _selectedColorIndex = 0;
  int _selectedSizeIndex = 0;
  int _currentPrice = 0;

  @override
  void initState() {
    super.initState();
    // Initialize current price based on the first size index
    if (widget.product.price != null && widget.product.price!.isNotEmpty) {
      _currentPrice = widget.product.price![_selectedSizeIndex];
    }
  }

  void _updatePrice(int sizeIndex) {
    if (widget.product.price != null &&
        sizeIndex < widget.product.price!.length) {
      setState(() {
        _selectedSizeIndex = sizeIndex;
        _currentPrice = widget.product.price![sizeIndex];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final isAdding = cartProvider.isUpdating(widget.product.productId ?? "");

    return Scaffold(
      appBar: AppBar(title: Text(widget.product.name ?? 'Product Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Product image
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: (widget.product.images?.isNotEmpty ?? false) &&
                      (widget.product.images!.first.url?.isNotEmpty ?? false)
                  ? CachedNetworkImage(
                      imageUrl: widget.product.images!.first.url!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.grey,
                      ),
                    )
                  : const Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: Colors.grey,
                    ),
            ),
            const SizedBox(height: 16),

            // Product details
            Text(
              widget.product.name ?? '',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Category: ${widget.product.category ?? '-'}'),
            const SizedBox(height: 8),
            Text('Price: \$$_currentPrice'),
            const SizedBox(height: 16),

            // Color selector
            if (widget.product.color != null && widget.product.color!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Select Color:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: List.generate(widget.product.color!.length, (index) {
                      final color = widget.product.color![index];
                      final isSelected = _selectedColorIndex == index;
                      return ChoiceChip(
                        label: Text(color),
                        selected: isSelected,
                        onSelected: (_) {
                          setState(() {
                            _selectedColorIndex = index;
                          });
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                ],
              ),

            // Size selector (update price when size changes)
            if (widget.product.size != null && widget.product.size!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Select Size:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: List.generate(widget.product.size!.length, (index) {
                      final size = widget.product.size![index];
                      final isSelected = _selectedSizeIndex == index;
                      return ChoiceChip(
                        label: Text(size),
                        selected: isSelected,
                        onSelected: (_) {
                          _updatePrice(index); // update price when size changes
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                ],
              ),

            // Quantity selector
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _quantity > 1
                      ? () => setState(() => _quantity--)
                      : null,
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text(
                  "$_quantity",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => setState(() => _quantity++),
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Add to Cart button
            Center(
              child: isAdding
                  ? const SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        try {
                          await cartProvider.addItemToCart(
                            widget.product.productId ?? "",
                            _quantity,
                            _selectedSizeIndex,
                            _selectedColorIndex

                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Added to cart ✅")),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error: $e")),
                          );
                        }
                      },
                      child: const Text('Add to Cart'),
                    ),
            ),
            const SizedBox(height: 10),

            // Go to Cart button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartScreen()),
                  );
                },
                child: const Text('Go to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
