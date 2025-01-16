import 'package:flutter/material.dart';
import 'package:pl_project/helper/api.dart';
import 'package:pl_project/services/FavoriteProductsService.dart';

class FavoriteProductCard extends StatefulWidget {
  final String imagePath;
  final int productId;

  const FavoriteProductCard({
    super.key,
    required this.imagePath,
    required this.productId,
  });

  @override
  State<FavoriteProductCard> createState() => _FavoriteProductCardState();
}

class _FavoriteProductCardState extends State<FavoriteProductCard> {
  IconData currentIcon = Icons.favorite_border;

  void toggleFavorite() {
    setState(() {
      if (currentIcon == Icons.favorite_border) {
        currentIcon = Icons.favorite;
        // Add to favorites via API
        _updateFavoriteStatus(add: true);
      } else {
        currentIcon = Icons.favorite_border;
        // Remove from favorites via API
        _updateFavoriteStatus(add: false);
      }
    });
  }

  void _updateFavoriteStatus({required bool add}) async {
    try {
      final service = FavoriteProductsService(
        api: Api(),
        token: "your-auth-token-here", // Replace with actual token
      );
      if (add) {
        await service.addProductToFavorites(widget.productId);
      } else {
        await service.deleteProductFromFavorites(widget.productId);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update favorite status: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              // Navigate to product details page
            },
            child: Container(
              width: 150,
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: Colors.amber[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: widget.imagePath.isNotEmpty
                    ? Image.network(widget.imagePath, fit: BoxFit.cover)
                    : const Icon(Icons.image_not_supported, size: 50),
              ),
            ),
          ),
          Positioned(
            top: -2,
            right: 0,
            child: GestureDetector(
              onTap: toggleFavorite,
              child: Icon(
                currentIcon,
                color: Colors.red,
              ),
            ),
          ),
          Positioned(
            bottom: -2,
            child: GestureDetector(
              onTap: () {
                // Logic to add the product to the cart
              },
              child: const Icon(
                Icons.add_circle,
                color: Color.fromARGB(255, 27, 110, 255),
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
