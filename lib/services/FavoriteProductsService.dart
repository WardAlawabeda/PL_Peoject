// ignore_for_file: missing_required_param

import 'package:flutter/material.dart';
import 'package:pl_project/helper/api.dart'; // Import your custom Api class

class FavoriteProductsService {
  final Api api;
  final String? token; // The user's token for authentication

  FavoriteProductsService({required this.api, @required this.token});

  // Fetch favorite products
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
    List<dynamic> categories = response['categories'];

    // Create a map of categories with their respective favorite products
    Map<String, List<Map<String, dynamic>>> favoritesByCategory = {};

    for (var category in categories) {
      String categoryName = category['category_name'];
      List<dynamic> favorites = category['favorites'];

      // Map each favorite product
      List<Map<String, dynamic>> favoriteProducts = favorites.map((favorite) {
        return {
          'id': favorite['id'],
          'product_id': favorite['product_id'],
          'name': favorite['product']['name'],
          'price': favorite['product']['price'],
          'description': favorite['product']['description'],
          'image_url': favorite['product']['image_url'],
          'store_name': favorite['product']['store']['name'],
          'category_name': favorite['product']['store']['category']['name'],
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
    // if (token == null) {
    //   throw Exception('User is not authenticated');
    // }

    try {
      final response = await Api.post(
        endPoint: '/favorites',
        data: {
          'product_id': productId,
        },
      );
      return response['message']; // Return the success message
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
        data: {
          "product_id" : productId,
        }
      );
      return response['message']; // Return the success message
    } catch (e) {
      throw Exception('Error deleting product from favorites: $e');
    }
  }
}
