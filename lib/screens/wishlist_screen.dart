// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:sampleapp/services/wishlist_service.dart';

// import 'package:flutter/material.dart';

// import '../models/wishlist_model.dart';

// class WishlistScreen extends StatefulWidget {
//   const WishlistScreen({super.key});

//   @override
//   _WishlistScreenState createState() => _WishlistScreenState();
// }

// class _WishlistScreenState extends State<WishlistScreen> {
//   List<WishlistModel> wishlistitems = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchedwishlistitems();
//   }

//   // Method to fetch data and update the state
//   Future<void> fetchedwishlistitems() async {
//     try {
//       final apiService = WishlistService();
//       final List<WishlistModel> fetchedwishlistitems =
//           await apiService.getAllWishlistItems();
//       setState(() {
//         wishlistitems = fetchedwishlistitems;
//         isLoading = false;
//       });
//     } catch (error) {
//       setState(() {
//         isLoading = false;
//       });
//       print("Error: $error");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Wihshlist Items'),
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : wishlistitems.isEmpty
//               ? const Center(child: Text('No wishlist items found'))
//               : ListView.builder(
//                   itemCount: wishlistitems.length,
//                   itemBuilder: (context, index) {
//                     return Card(
//                       child: Column(
//                         children: [
//                           Text("id ${wishlistitems[index].sId}"),
//                           Text("product name ${wishlistitems[index].productId}"),
//                           Text("description ${wishlistitems[index].userId}"),
// Container(
//   height: 100,
//   width: 100,
//   child: (wishlistitems[index].product?.images?.isNotEmpty ?? false) &&
//           (wishlistitems[index].product!.images!.first.url?.isNotEmpty ?? false)
//       ? CachedNetworkImage(
//           imageUrl: wishlistitems[index].product!.images!.first.url!,
//           fit: BoxFit.cover,
//           placeholder: (context, url) => const Center(
//             child: CircularProgressIndicator(strokeWidth: 2),
//           ),
//           errorWidget: (context, url, error) => const Icon(
//             Icons.image_not_supported,
//             size: 50,
//             color: Colors.grey,
//           ),
//         )
//       : const Icon(
//           Icons.image_not_supported,
//           size: 50,
//           color: Colors.grey,
//         ),
// ),

//                         ],
//                       ),
//                     );
//                   }),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:sampleapp/widgets/product_details_widget.dart';
import '../services/wishlist_service.dart';
import '../models/wishlist_model.dart';
import '../widgets/favorite_button_wisget.dart';


class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  List<WishlistModel> wishlistItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWishlistItems();
  }

  Future<void> fetchWishlistItems() async {
    setState(() => isLoading = true);
    try {
      final apiService = WishlistService();
      final List<WishlistModel> fetchedItems =
          await apiService.getAllWishlistItems();
      setState(() {
        wishlistItems = fetchedItems;
      });
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error fetching wishlist: $error")),
        );
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> removeFromWishlist(String wishlistId) async {
    try {
      final apiService = WishlistService();
      print("DEBUG: Removing wishlist item with id $wishlistId");
      final success = await apiService.removeFromWishlist(wishlistId);
      if (success) {
        setState(() {
          wishlistItems.removeWhere(
            (item) => item.product!.productId == wishlistId,
          );
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Removed from wishlist")));
      }
    } catch (error) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error removing item: $error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wishlist")),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : wishlistItems.isEmpty
              ? const Center(child: Text("No wishlist items found"))
              : RefreshIndicator(
                onRefresh: fetchWishlistItems,
                child: GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: wishlistItems.length,
                  itemBuilder: (context, index) {
                    final item = wishlistItems[index];
                    final product = item.product;

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) =>
                                    ProductDetailScreen(product: item.product!),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                child:
                                    (product?.images?.isNotEmpty ?? false)
                                        ? CachedNetworkImage(
                                          imageUrl:
                                              product!.images!.first.url ?? '',
                                          fit: BoxFit.cover,
                                          placeholder:
                                              (context, url) => const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                          errorWidget:
                                              (context, url, error) =>
                                                  const Icon(
                                                    Icons.image_not_supported,
                                                    color: Colors.grey,
                                                  ),
                                        )
                                        : const Icon(
                                          Icons.image_not_supported,
                                          size: 50,
                                          color: Colors.grey,
                                        ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product?.name ?? "No Name",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    product?.description ?? "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      FavoriteButton(
                                        productId: item.productId!,
                                        onRemoved: () {
                                          setState(() {
                                            wishlistItems.removeAt(
                                              index,
                                            ); // Remove item from list
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
    );
  }
}
