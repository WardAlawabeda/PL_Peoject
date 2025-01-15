import 'package:pl_project/helper/api.dart';

class OrderService {
  final Api api;
  final String? token;

  OrderService({required this.api, required this.token});

  // Fetch all orders for the user
  Future<List<dynamic>> getOrders() async {
    if (token == null) {
      throw Exception('User is not authenticated');
    }

    try {
      final response = await Api.getList(
        endPoint: '/api/orders',
        token: token,
      );
      return response; // List of orders
    } catch (e) {
      throw Exception('Error fetching orders: $e');
    }
  }

  // Create a new order from cart items
  Future<Map<String, dynamic>> createOrder() async {
    if (token == null) {
      throw Exception('User is not authenticated');
    }

    try {
      final response = await Api.post(
        endPoint: '/api/orders',
       token: token,
        data: {},
      );
      return response; // Newly created order details
    } catch (e) {
      throw Exception('Error creating order: $e');
    }
  }

  // Get the details of a specific order
  Future<Map<String, dynamic>> getOrderDetails(int orderId) async {
    if (token == null) {
      throw Exception('User is not authenticated');
    }

    try {
      final response = await Api.get(
        endPoint: '/api/orders/$orderId',
        token: token,
      );
      return response; // Order details, including items
    } catch (e) {
      throw Exception('Error fetching order details: $e');
    }
  }

  // Update the quantity of an item in the order
  Future<Map<String, dynamic>> updateOrderItemQuantity({
    required int orderId,
    required int itemId,
    required int quantity,
  }) async {
    if (token == null) {
      throw Exception('User is not authenticated');
    }

    try {
      final response = await Api.put(
        endPoint: '/api/orders/$orderId/items/$itemId',
       token: token,
        data: {
          'quantity': quantity,
        },
      );
      return response; // Updated order details
    } catch (e) {
      throw Exception('Error updating order item quantity: $e');
    }
  }

  // Delete an item in the order
  Future<String> deleteOrderItem({
    required int orderId,
    required int itemId,
  }) async {
    if (token == null) {
      throw Exception('User is not authenticated');
    }

    try {
      final response = await Api.delete(
        endPoint: '/api/orders/$orderId/items/$itemId',
        token: token,
      );
      return response['message']; // Success message
    } catch (e) {
      throw Exception('Error deleting order item: $e');
    }
  }

  // Delete an entire order
  Future<String> deleteOrder(int orderId) async {
    if (token == null) {
      throw Exception('User is not authenticated');
    }

    try {
      final response = await Api.delete(
        endPoint: '/api/orders/$orderId',
        token: token,
      );
      return response['message']; // Success message
    } catch (e) {
      throw Exception('Error deleting order: $e');
    }
  }
}
