// // // import 'package:cached_network_image/cached_network_image.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:clerk_flutter/clerk_flutter.dart';
// // // import 'package:provider/provider.dart';
// // // import 'package:sampleapp/providers/user_provider.dart';

// // // import 'package:sampleapp/screens/order_screen.dart';
// // // import 'package:sampleapp/screens/profile_screen.dart';
// // // import 'package:sampleapp/screens/wishlist_screen.dart';
// // // import 'package:sampleapp/widgets/product_details_widget.dart';
// // // import '../models/product_model.dart';

// // // import '../providers/order_provider.dart';
// // // import '../providers/product_provider.dart';
// // // import '../providers/wishlist_provider.dart';
// // // import '../screens/auth_screen.dart';
// // // import '../services/auth_service.dart';
// // // import '../widgets/favorite_widget.dart';

// // // class HomeScren extends StatefulWidget {
// // //   const HomeScren({super.key});

// // //   @override
// // //   State<HomeScren> createState() => _HomeScrenState();
// // // }

// // // class _HomeScrenState extends State<HomeScren> {
// // //   String? _userId;
// // //   bool _loading = true;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _loadUserId();

// // //     Future.microtask(() {
// // //       context.read<ProductProvider>().fetchInitialProducts();
// // //       context.read<WishlistProvider>().fetchWishlist();
// // //       context.read<UserProvider>().fetchUserDetails();
// // //       context.read<OrderProvider>().fetchOrders();
// // //     });
// // //   }

// // //   Future<void> _loadUserId() async {
// // //     final authService = AuthService();
// // //     final id = await authService.getUserId();
// // //     if (mounted) {
// // //       setState(() {
// // //         _userId = id;
// // //         _loading = false;
// // //       });
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final authService = AuthService();
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: const Text("home screen"),
// // //         actions: [
// // //           IconButton(
// // //             onPressed: () {
// // //               Navigator.push(
// // //                 context,
// // //                 MaterialPageRoute(builder: (_) => const OrdersScreen()),
// // //               );
// // //             },
// // //             icon: Icon(Icons.shopping_cart),
// // //           ),

// // //           IconButton(
// // //             onPressed: () {
// // //               Navigator.push(
// // //                 context,
// // //                 MaterialPageRoute(builder: (_) => const ProfileScreen()),
// // //               );
// // //             },
// // //             icon: Icon(Icons.person),
// // //           ),
// // //           IconButton(
// // //             onPressed: () {
// // //               Navigator.push(
// // //                 context,
// // //                 MaterialPageRoute(builder: (_) => const WishlistScreen()),
// // //               );
// // //             },
// // //             icon: Icon(Icons.favorite_border),
// // //           ),

// // //           IconButton(
// // //             icon: const Icon(Icons.logout),
// // //             onPressed: () async {
// // //               // 1️⃣ Dispose Clerk listener
// // //               CustomAuthScreen.disposeClerkListener();

// // //               // 2️⃣ Sign out from Clerk
// // //               final auth = ClerkAuth.of(context);
// // //               await auth.signOut();

// // //               // 3️⃣ Clear stored userId
// // //               await authService.clearUserId();

// // //               // 4️⃣ Navigate back to Auth screen
// // //               if (mounted) {
// // //                 Navigator.pushReplacement(
// // //                   context,
// // //                   MaterialPageRoute(builder: (_) => const CustomAuthScreen()),
// // //                 );
// // //               }
// // //             },
// // //           ),
// // //         ],
// // //       ),
// // //       body: Center(
// // //         child:
// // //             _loading
// // //                 ? const CircularProgressIndicator()
// // //                 : Consumer<ProductProvider>(
// // //                   builder: (context, provider, child) {
// // //                     final List<Product> products = provider.products;

// // //                     if (products.isEmpty && provider.isLoading) {
// // //                       return const Center(child: CircularProgressIndicator());
// // //                     }

// // //                     if (products.isEmpty && provider.isDone) {
// // //                       return const Center(child: Text("No products available"));
// // //                     }

// // //                     return ListView.builder(
// // //                       itemCount: products.length + (provider.isLoading ? 1 : 0),
// // //                       itemBuilder: (context, index) {
// // //                         // Trigger pagination
// // //                         provider.checkAndFetchMore(index);

// // //                         if (index < products.length) {
// // //                           final product = products[index];
// // //                           return GestureDetector(
// // //                             onTap: () {
// // //                               Navigator.push(
// // //                                 context,
// // //                                 MaterialPageRoute(
// // //                                   builder:
// // //                                       (context) =>
// // //                                           ProductDetailScreen(product: product),
// // //                                 ),
// // //                               );
// // //                             },
// // //                             child: Card(
// // //                               margin: const EdgeInsets.symmetric(
// // //                                 horizontal: 12,
// // //                                 vertical: 8,
// // //                               ),
// // //                               child: ListTile(
// // //                                 leading:
// // //                                     (product.images != null &&
// // //                                             product.images!.isNotEmpty &&
// // //                                             product.images!.first.url != null)
// // //                                         ? CachedNetworkImage(
// // //                                           imageUrl: product.images!.first.url!,
// // //                                           width: 50,
// // //                                           height: 50,
// // //                                           fit: BoxFit.cover,
// // //                                           placeholder:
// // //                                               (context, url) => const SizedBox(
// // //                                                 width: 50,
// // //                                                 height: 50,
// // //                                                 child: Center(
// // //                                                   child:
// // //                                                       CircularProgressIndicator(
// // //                                                         strokeWidth: 2,
// // //                                                       ),
// // //                                                 ),
// // //                                               ),
// // //                                           errorWidget:
// // //                                               (context, url, error) =>
// // //                                                   const Icon(
// // //                                                     Icons.broken_image,
// // //                                                     size: 50,
// // //                                                     color: Colors.grey,
// // //                                                   ),
// // //                                         )
// // //                                         : const Icon(
// // //                                           Icons.image_not_supported,
// // //                                           size: 50,
// // //                                           color: Colors.grey,
// // //                                         ),
// // //                                 title: Text(product.name ?? ""),
// // //                                 subtitle: Text(product.category ?? ""),
// // //                                 trailing: WishlistButton(
// // //                                   productId: product.productId!,
// // //                                 ),
// // //                               ),
// // //                             ),
// // //                           );
// // //                         } else {
// // //                           // Loader at bottom when fetching more
// // //                           return const Padding(
// // //                             padding: EdgeInsets.all(16.0),
// // //                             child: Center(child: CircularProgressIndicator()),
// // //                           );
// // //                         }
// // //                       },
// // //                     );
// // //                   },
// // //                 ),
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:cached_network_image/cached_network_image.dart';
// // import 'package:flutter/material.dart';
// // import 'package:clerk_flutter/clerk_flutter.dart';
// // import 'package:provider/provider.dart';
// // import 'package:sampleapp/providers/user_provider.dart';
// // import 'package:sampleapp/screens/order_screen.dart';
// // import 'package:sampleapp/screens/profile_screen.dart';
// // import 'package:sampleapp/screens/wishlist_screen.dart';
// // import 'package:sampleapp/widgets/product_details_widget.dart';
// // import '../models/product_model.dart';
// // import '../providers/order_provider.dart';
// // import '../providers/product_provider.dart';
// // import '../providers/wishlist_provider.dart';
// // import '../screens/auth_screen.dart';
// // import '../services/auth_service.dart';
// // import '../widgets/favorite_widget.dart';
// // import 'package:shimmer/shimmer.dart';

// // class HomeScren extends StatefulWidget {
// //   const HomeScren({super.key});

// //   @override
// //   State<HomeScren> createState() => _HomeScrenState();
// // }

// // class _HomeScrenState extends State<HomeScren> {
// //   String? _userId;
// //   bool _loading = true;
// //   final ScrollController _scrollController = ScrollController();

// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadUserId();

// //     Future.microtask(() {
// //       context.read<ProductProvider>().fetchInitialProducts();
// //       context.read<WishlistProvider>().fetchWishlist();
// //       context.read<UserProvider>().fetchUserDetails();
// //       context.read<OrderProvider>().fetchOrders();
// //     });

// //     // Setup scroll listener for pagination
// //     _scrollController.addListener(_onScroll);
// //   }

// //   @override
// //   void dispose() {
// //     _scrollController.dispose();
// //     super.dispose();
// //   }

// //   void _onScroll() {
// //     final provider = context.read<ProductProvider>();
// //     if (_scrollController.position.pixels >=
// //             _scrollController.position.maxScrollExtent - 200 &&
// //         !provider.isLoading &&
// //         !provider.isDone) {
// //       // Safely fetch next page
// //       provider.fetchMoreProducts();
// //     }
// //   }

// //   Future<void> _loadUserId() async {
// //     final authService = AuthService();
// //     final id = await authService.getUserId();
// //     if (mounted) {
// //       setState(() {
// //         _userId = id;
// //         _loading = false;
// //       });
// //     }
// //   }

// //   Widget _buildShimmer() {
// //     return Shimmer.fromColors(
// //       baseColor: Colors.grey[300]!,
// //       highlightColor: Colors.grey[100]!,
// //       child: ListView.builder(
// //         itemCount: 6,
// //         itemBuilder: (_, __) => Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// //           child: Container(
// //             height: 80,
// //             color: Colors.white,
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final authService = AuthService();

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Home Screen"),
// //         actions: [
// //           IconButton(
// //             onPressed: () {
// //               Navigator.push(
// //                 context,
// //                 MaterialPageRoute(builder: (_) => const OrdersScreen()),
// //               );
// //             },
// //             icon: const Icon(Icons.shopping_cart),
// //           ),
// //           IconButton(
// //             onPressed: () {
// //               Navigator.push(
// //                 context,
// //                 MaterialPageRoute(builder: (_) => const ProfileScreen()),
// //               );
// //             },
// //             icon: const Icon(Icons.person),
// //           ),
// //           IconButton(
// //             onPressed: () {
// //               Navigator.push(
// //                 context,
// //                 MaterialPageRoute(builder: (_) => const WishlistScreen()),
// //               );
// //             },
// //             icon: const Icon(Icons.favorite_border),
// //           ),
// //           IconButton(
// //             icon: const Icon(Icons.logout),
// //             onPressed: () async {
// //               CustomAuthScreen.disposeClerkListener();
// //               final auth = ClerkAuth.of(context);
// //               await auth.signOut();
// //               await authService.clearUserId();

// //               if (mounted) {
// //                 Navigator.pushReplacement(
// //                   context,
// //                   MaterialPageRoute(builder: (_) => const CustomAuthScreen()),
// //                 );
// //               }
// //             },
// //           ),
// //         ],
// //       ),
// //       body: _loading
// //           ? const Center(child: CircularProgressIndicator())
// //           : Consumer<ProductProvider>(
// //               builder: (context, provider, child) {
// //                 final products = provider.products;

// //                 if (products.isEmpty && provider.isLoading) {
// //                   return _buildShimmer();
// //                 }

// //                 if (products.isEmpty && provider.isDone) {
// //                   return const Center(child: Text("No products available"));
// //                 }

// //                 return ListView.builder(
// //                   controller: _scrollController,
// //                   itemCount: products.length + (provider.isLoading ? 1 : 0),
// //                   itemBuilder: (context, index) {
// //                     if (index < products.length) {
// //                       final product = products[index];
// //                       return GestureDetector(
// //                         onTap: () {
// //                           Navigator.push(
// //                             context,
// //                             MaterialPageRoute(
// //                               builder: (context) =>
// //                                   ProductDetailScreen(product: product),
// //                             ),
// //                           );
// //                         },
// //                         child: Card(
// //                           margin: const EdgeInsets.symmetric(
// //                               horizontal: 12, vertical: 8),
// //                           child: ListTile(
// //                             leading: (product.images != null &&
// //                                     product.images!.isNotEmpty &&
// //                                     product.images!.first.url != null)
// //                                 ? CachedNetworkImage(
// //                                     imageUrl: product.images!.first.url!,
// //                                     width: 50,
// //                                     height: 50,
// //                                     fit: BoxFit.cover,
// //                                     placeholder: (context, url) => const SizedBox(
// //                                       width: 50,
// //                                       height: 50,
// //                                       child: Center(
// //                                         child: CircularProgressIndicator(
// //                                           strokeWidth: 2,
// //                                         ),
// //                                       ),
// //                                     ),
// //                                     errorWidget: (context, url, error) =>
// //                                         const Icon(Icons.broken_image,
// //                                             size: 50, color: Colors.grey),
// //                                   )
// //                                 : const Icon(Icons.image_not_supported,
// //                                     size: 50, color: Colors.grey),
// //                             title: Text(product.name ?? ""),
// //                             subtitle: Text(product.category ?? ""),
// //                             trailing: WishlistButton(
// //                               productId: product.productId!,
// //                             ),
// //                           ),
// //                         ),
// //                       );
// //                     } else {
// //                       // Pagination loader at bottom
// //                       return const Padding(
// //                         padding: EdgeInsets.all(16.0),
// //                         child: Center(child: CircularProgressIndicator()),
// //                       );
// //                     }
// //                   },
// //                 );
// //               },
// //             ),
// //     );
// //   }
// // }


// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:clerk_flutter/clerk_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:sampleapp/providers/user_provider.dart';
// import 'package:sampleapp/screens/order_screen.dart';
// import 'package:sampleapp/screens/profile_screen.dart';
// import 'package:sampleapp/screens/wishlist_screen.dart';
// import 'package:sampleapp/widgets/product_details_widget.dart';
// import '../providers/cart_provider.dart';
// import '../providers/order_provider.dart';
// import '../providers/product_provider.dart';
// import '../providers/wishlist_provider.dart';
// import '../screens/auth_screen.dart';
// import '../services/auth_service.dart';
// import '../widgets/wishlist_button_widget.dart';
// import 'package:shimmer/shimmer.dart';

// class HomeScren extends StatefulWidget {
//   const HomeScren({super.key});

//   @override
//   State<HomeScren> createState() => _HomeScrenState();
// }

// class _HomeScrenState extends State<HomeScren> {
//   String? _userId;
//   bool _loading = true;
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     _loadUserId();

//     Future.microtask(() {
//       context.read<ProductProvider>().fetchInitialProducts();
//       context.read<WishlistProvider>().fetchWishlist();
//       context.read<UserProvider>().fetchUserDetails();
//       context.read<OrderProvider>().fetchOrders();
//       context.read<CartProvider>().fetchCartItems();
//     });

//     _scrollController.addListener(_onScroll);
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _onScroll() {
//     final provider = context.read<ProductProvider>();
//     if (_scrollController.position.pixels >=
//             _scrollController.position.maxScrollExtent - 200 &&
//         !provider.isLoading &&
//         !provider.isDone) {
//       provider.fetchMoreProducts();
//     }
//   }

//   Future<void> _loadUserId() async {
//     final authService = AuthService();
//     final id = await authService.getUserId();
//     if (mounted) {
//       setState(() {
//         _userId = id;
//         _loading = false;
//       });
//     }
//   }

//   Widget _buildShimmerRow() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       child: Shimmer.fromColors(
//         baseColor: Colors.grey[300]!,
//         highlightColor: Colors.grey[100]!,
//         child: Container(
//           height: 80,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }

//   Widget _buildInitialShimmer() {
//     return Shimmer.fromColors(
//       baseColor: Colors.grey[300]!,
//       highlightColor: Colors.grey[100]!,
//       child: ListView.builder(
//         itemCount: 6,
//         itemBuilder: (_, __) => Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//           child: Container(height: 80, color: Colors.white),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authService = AuthService();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Home Screen"),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const OrdersScreen()),
//               );
//             },
//             icon: const Icon(Icons.shopping_cart),
//           ),
//           IconButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const ProfileScreen()),
//               );
//             },
//             icon: const Icon(Icons.person),
//           ),
//           IconButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const WishlistScreen()),
//               );
//             },
//             icon: const Icon(Icons.favorite_border),
//           ),
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () async {
//               CustomAuthScreen.disposeClerkListener();
//               final auth = ClerkAuth.of(context);
//               await auth.signOut();
//               await authService.clearUserId();

//               if (mounted) {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (_) => const CustomAuthScreen()),
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//       body: _loading
//           ? const Center(child: CircularProgressIndicator())
//           : Consumer<ProductProvider>(
//               builder: (context, provider, child) {
//                 final products = provider.products;

//                 // Debug total products
//                 debugPrint("Total products: ${products.length}");

//                 if (products.isEmpty && provider.isLoading) {
//                   return _buildInitialShimmer();
//                 }

//                 if (products.isEmpty && provider.isDone) {
//                   return const Center(child: Text("No products available"));
//                 }

//                 return ListView.builder(
//                   controller: _scrollController,
//                   itemCount: products.length + (provider.isLoading ? 3 : 0),
//                   itemBuilder: (context, index) {
//                     if (index < products.length) {
//                       final product = products[index];
//                       return GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   ProductDetailScreen(product: product),
//                             ),
//                           );
//                         },
//                         child: Card(
//                           margin: const EdgeInsets.symmetric(
//                               horizontal: 12, vertical: 8),
//                           child: ListTile(
//                             leading: (product.images != null &&
//                                     product.images!.isNotEmpty &&
//                                     product.images!.first.url != null)
//                                 ? CachedNetworkImage(
//                                     imageUrl: product.images!.first.url!,
//                                     width: 50,
//                                     height: 50,
//                                     fit: BoxFit.cover,
//                                     placeholder: (context, url) => const SizedBox(
//                                       width: 50,
//                                       height: 50,
//                                       child: Center(
//                                         child: CircularProgressIndicator(
//                                           strokeWidth: 2,
//                                         ),
//                                       ),
//                                     ),
//                                     errorWidget: (context, url, error) =>
//                                         const Icon(Icons.broken_image,
//                                             size: 50, color: Colors.grey),
//                                   )
//                                 : const Icon(Icons.image_not_supported,
//                                     size: 50, color: Colors.grey),
//                             title: Text(product.name ?? ""),
//                             subtitle: Text(product.category ?? ""),
//                             trailing: WishlistButton(
//                               productId: product.productId!,
//                             ),
//                           ),
//                         ),
//                       );
//                     } else {
//                       // Shimmer for loading next page
//                       return Column(
//                         children: List.generate(3, (_) => _buildShimmerRow()),
//                       );
//                     }
//                   },
//                 );
//               },
//             ),
//     );
//   }
// }



import 'package:cached_network_image/cached_network_image.dart';
import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../models/product_model.dart';
import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';
import '../providers/product_provider.dart';
import '../providers/user_provider.dart';
import '../providers/wishlist_provider.dart';
import '../screens/order_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/wishlist_screen.dart';
import '../screens/auth_screen.dart';
import '../services/auth_service.dart';

import '../widgets/product_details_widget.dart';
import '../widgets/wishlist_button_widget.dart';

class HomeScren extends StatefulWidget {
  const HomeScren({super.key});

  @override
  State<HomeScren> createState() => _HomeScrenState();
}

class _HomeScrenState extends State<HomeScren> {
  String? _userId;
  bool _loading = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadUserId();

    Future.microtask(() {
      context.read<ProductProvider>().fetchInitialProducts();
      context.read<WishlistProvider>().fetchWishlist();
      context.read<UserProvider>().fetchUserDetails();
      context.read<OrderProvider>().fetchOrders();
      context.read<CartProvider>().fetchCartItems();
    });

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final provider = context.read<ProductProvider>();
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !provider.isLoading &&
        !provider.isDone) {
      provider.fetchMoreProducts();
    }
  }

  Future<void> _loadUserId() async {
    final authService = AuthService();
    final id = await authService.getUserId();
    if (mounted) {
      setState(() {
        _userId = id;
        _loading = false;
      });
    }
  }

  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildInitialShimmer() {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.65,
      ),
      itemCount: 6,
      itemBuilder: (_, __) => _buildShimmerCard(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OrdersScreen()),
              );
            },
            icon: const Icon(Icons.shopping_cart),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
            icon: const Icon(Icons.person),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WishlistScreen()),
              );
            },
            icon: const Icon(Icons.favorite_border),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              CustomAuthScreen.disposeClerkListener();
              final auth = ClerkAuth.of(context);
              await auth.signOut();
              await authService.clearUserId();
              if (mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const CustomAuthScreen()),
                );
              }
            },
          ),
        ],
      ),
      body: _loading
          ? _buildInitialShimmer()
          : Consumer<ProductProvider>(
              builder: (context, provider, _) {
                final products = provider.products;

                if (products.isEmpty && provider.isLoading) {
                  return _buildInitialShimmer();
                }

                if (products.isEmpty && provider.isDone) {
                  return const Center(child: Text("No products available"));
                }

                return RefreshIndicator(
                  onRefresh: provider.fetchInitialProducts,
                  child: GridView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: products.length + (provider.isLoading ? 2 : 0),
                    itemBuilder: (context, index) {
                      if (index < products.length) {
                        return ProductCard(product: products[index]);
                      } else {
                        return _buildShimmerCard();
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}


class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: (product.images?.isNotEmpty ?? false)
                    ? CachedNetworkImage(
                        imageUrl: product.images!.first.url ?? '',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.image_not_supported,
                                color: Colors.grey),
                      )
                    : const Icon(Icons.image_not_supported,
                        size: 50, color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name ?? "No Name",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.category ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      WishlistButton(productId: product.productId!),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


