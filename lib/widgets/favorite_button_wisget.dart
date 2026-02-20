import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wishlist_provider.dart';

class FavoriteButton extends StatefulWidget {
  final String productId;
  final VoidCallback? onRemoved; // Callback when item is removed
  const FavoriteButton({super.key, required this.productId, this.onRemoved});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isLoading = false;

  Future<void> _toggleWishlist(BuildContext context) async {
    setState(() => _isLoading = true);

    final wishlistProvider =
        Provider.of<WishlistProvider>(context, listen: false);

    try {
      await wishlistProvider.toggleProduct(widget.productId);

      final removed = !wishlistProvider.isWishlisted(widget.productId);
      if (removed && widget.onRemoved != null) {
        widget.onRemoved!(); // Notify parent to remove from list
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            wishlistProvider.isWishlisted(widget.productId)
                ? "Added to wishlist ❤️"
                : "Removed from wishlist ❌",
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WishlistProvider>(
      builder: (context, wishlistProvider, child) {
        final isWishlisted = wishlistProvider.isWishlisted(widget.productId);

        return IconButton(
          onPressed: _isLoading ? null : () => _toggleWishlist(context),
          icon: _isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.red,
                    strokeWidth: 2,
                  ),
                )
              : Icon(
                  isWishlisted ? Icons.favorite : Icons.favorite_border,
                  color: isWishlisted ? Colors.red : Colors.grey,
                ),
        );
      },
    );
  }
}
