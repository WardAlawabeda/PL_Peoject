// ignore_for_file: missing_required_param

import 'package:pl_project/helper/api.dart';

class CartService {
  final Api api;
  final String? token;

  CartService({required this.api, required this.token});

  // Fetch cart products
  Future<List<dynamic>> getCartProducts() async {
    if (token == null) {
      throw Exception('User is not authenticated');
    }

    try {
      final response = await Api.getList(
        endPoint: '/cart',
        token: token,
      );
      return response;
    } catch (e) {
      throw Exception('Error fetching cart products: $e');
    }
  }

  // Add a product to the cart
  Future<Map<String, dynamic>> addProductToCart(int productId, int quantity) async {
    if (token == null) {
      throw Exception('User is not authenticated');
    }

    try {
      final response = await Api.post(
        endPoint: '/cart',
        data: {
          'product_id': productId,
          'quantity': quantity,
        },
        token: token,
      );
      return response;
    } catch (e) {
      throw Exception('Error adding product to cart: $e');
    }
  }

  // Remove a product from the cart
  Future<String> removeProductFromCart(int productId) async {
    if (token == null) {
      throw Exception('User is not authenticated');
    }

    try {
      final response = await Api.delete(
        endPoint: '/cart/$productId',
       token: token,
      );
      return response['message'];
    } catch (e) {
      throw Exception('Error removing product from cart: $e');
    }
  }

   // Update the quantity of a product in the cart
  Future<Map<String, dynamic>> updateProductQuantity(int productId, int quantity) async {
    if (token == null) {
      throw Exception('User is not authenticated');
    }

    try {
      final response = await Api.put(
        endPoint: '/cart/$productId',
        token: token,
        data: {
          'quantity': quantity,
        },
      );
      return response;
    } catch (e) {
      throw Exception('Error updating product quantity: $e');
    }
  }
}
