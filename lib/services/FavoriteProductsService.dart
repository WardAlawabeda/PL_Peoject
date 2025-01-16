import 'package:pl_project/helper/api.dart';

class FavoriteProductsService {
  final Api api;
  final String? token; // The user's token for authentication

  FavoriteProductsService({required this.api, required this.token});

  // Fetch favorite products by category
  Future<Map<String, List<Map<String, dynamic>>>> getFavoriteProducts() async {
    if (token == null) {
      throw Exception('User is not authenticated');
    }

    try {
      final response = await Api.get(
        endPoint: '/favorites',
        token: token,
      );

      // Parse the response
      List<dynamic> categories = response['categories'] ?? [];

      // Create a map of categories with their respective favorite products
      Map<String, List<Map<String, dynamic>>> favoritesByCategory = {};

      for (var category in categories) {
        String categoryName = category['category_name'] ?? 'Unknown';
        List<dynamic> favorites = category['favorites'] ?? [];

        // Map each favorite product
        List<Map<String, dynamic>> favoriteProducts = favorites.map((favorite) {
          final product = favorite['product'] ?? {};
          final store = product['store'] ?? {};
          final category = store['category'] ?? {};

          return {
            'id': favorite['id'] ?? 0,
            'product_id': favorite['product_id'] ?? 0,
            'name': product['name'] ?? 'Unknown',
            'price': product['price'] ?? 0,
            'description': product['description'] ?? '',
            'image_url': product['image_url'] ?? '',
            'store_name': store['name'] ?? 'Unknown',
            'category_name': category['name'] ?? 'Unknown',
          };
        }).toList();

        // Add to the category map
        favoritesByCategory[categoryName] = favoriteProducts;
      }

      return favoritesByCategory;
    } catch (e) {
      throw Exception('Error fetching favorite products: $e');
    }
  }

  // Add a product to favorites
  Future<String> addProductToFavorites(int productId) async {
    if (token == null) {
      throw Exception('User is not authenticated');
    }

    try {
      final response = await Api.post(
        endPoint: '/favorites',
        token: token,
        data: {
          'product_id': productId,
        },
      );
      return response['message'] ?? 'Product added to favorites';
    } catch (e) {
      throw Exception('Error adding product to favorites: $e');
    }
  }

  // Delete a product from favorites
  Future<String> deleteProductFromFavorites(int productId) async {
    if (token == null) {
      throw Exception('User is not authenticated');
    }

    try {
      final response = await Api.delete(
        endPoint: '/favorites',
        token: token,
        data: {
          'product_id': productId,
        },
      );
      return response['message'] ?? 'Product removed from favorites';
    } catch (e) {
      throw Exception('Error deleting product from favorites: $e');
    }
  }
}
