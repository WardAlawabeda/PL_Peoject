import 'package:flutter/material.dart';
import 'package:pl_project/services/OrdersService.dart';

class OrdersPage extends StatefulWidget {
  final OrderService orderService;

  const OrdersPage({super.key, required this.orderService});

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<Map<String, dynamic>> orderItems = []; // Dynamic list for fetched orders
  bool isLoading = true; // To show loading indicator
  String errorMessage = ""; // To display errors

  @override
  void initState() {
    super.initState();
    _fetchOrders(); // Fetch orders on initialization
  }

  // Fetch orders from OrderService
  Future<void> _fetchOrders() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = "";
      });

      final orders = await widget.orderService.getOrders();
      setState(() {
        orderItems = orders.map<Map<String, dynamic>>((order) {
          return {
            'id': order['id'], // Add `id` to track each order
            'name': order['name'] ?? "Order Item",
            'price': order['price'] ?? 0.0,
            'status': order['status'] ?? "Pending",
            'image': 'assets/download.jfif', // Placeholder for now
          };
        }).toList();
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Remove an order using the OrderService
  Future<void> _removeOrder(int orderId, int index) async {
    try {
      await widget.orderService.deleteOrder(orderId); // Delete order
      setState(() {
        orderItems.removeAt(index); // Remove from UI
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Order removed successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting order: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        backgroundColor: Colors.amber,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Loading indicator
          : errorMessage.isNotEmpty
              ? Center(
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ) // Display error message
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: orderItems.length,
                        itemBuilder: (context, index) {
                          final item = orderItems[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            elevation: 4,
                            child: Stack(
                              children: [
                                // Remove order button
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: IconButton(
                                    icon: Icon(Icons.close,
                                        color: (item['status'] == 'On the Way')
                                            ? Colors.grey
                                            : Colors.red[900]),
                                    onPressed: item['status'] == 'On the Way'
                                        ? null // Disable if "On the Way"
                                        : () => _removeOrder(
                                              item['id'],
                                              index,
                                            ),
                                  ),
                                ),
                                // Card content
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      // Item image
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          item['image'], // Placeholder image
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      // Item details
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item['name'],
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Price: \$${item['price'].toStringAsFixed(2)}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.green,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                          ],
                                        ),
                                      ),
                                      // Static order status
                                      Text(
                                        item['status'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              _getStatusColor(item['status']),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const Divider(),
                  ],
                ),
    );
  }

  // Helper function to get status color
  Color _getStatusColor(String status) {
    switch (status) {
      case 'On the Way':
        return Colors.orange;
      case 'Arrived':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
