import 'package:flutter/material.dart';
import 'package:pl_project/pages/product_details.dart';
import 'package:pl_project/services/CartService.dart';

class CartPage extends StatefulWidget {
  final CartService cartService;

  const CartPage({super.key, required this.cartService});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<List<dynamic>> cartProducts;

  @override
  void initState() {
    super.initState();
    fetchCartProducts();
  }

  void fetchCartProducts() {
    setState(() {
      cartProducts = widget.cartService.getCartProducts();
    });
  }

  void increaseQuantity(int productId, int currentQuantity) async {
    try {
      await widget.cartService
          .updateProductQuantity(productId, currentQuantity + 1);
      fetchCartProducts();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error increasing the quantity: $e'),
      ));
    }
  }

void decreaseQuantity(int productId, int currentQuantity) async {
    if (currentQuantity > 1) {
      try {
        await widget.cartService.updateProductQuantity(productId, currentQuantity - 1);
        fetchCartProducts();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error decreasing quantity: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Quantity cannot be less than 1')),
      );
    }
  }

  void deleteProduct(int productId) async {
    try {
      await widget.cartService.removeProductFromCart(productId);
      fetchCartProducts();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting product: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amber[600],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: cartProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Your cart is empty.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            );
          }

          final products = snapshot.data!;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetails(
                              product:
                                  product, // Pass product details to ProductDetails page
                            ),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.amber[300],
                                  ),
                                  height: 100,
                                  child: Row(
                                    children: [
                                      Image.network(
                                        product['image_url'],
                                        height: 80,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            product['name'],
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '${product['price']}s.p',
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 150,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    decreaseQuantity(product['id'], product['quantity']);
                                                  },
                                                  icon: const Icon(
                                                      Icons.remove_circle),
                                                  iconSize: 30,
                                                  color: Colors.black,
                                                ),
                                                Text(
                                                  '${product['quantity']}', // Dynamic quantity
                                                  style: const TextStyle(
                                                      fontSize: 30),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                   increaseQuantity(
                                                      product['id'],
                                                      product['quantity']);
                                                  },
                                                  icon: const Icon(
                                                      Icons.add_circle),
                                                  iconSize: 30,
                                                  color: Colors.black,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: IconButton(
                              iconSize: 50,
                              onPressed: () {
                                deleteProduct(product['id']);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const Divider(thickness: 1, height: 0, color: Colors.grey),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Subtotal:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${calculateSubtotal(products)}s.p',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delivery Fee:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '5000s.p',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(thickness: 1, height: 32, color: Colors.grey),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total:',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber),
                        ),
                        Text(
                          '${calculateSubtotal(products) + 5000}s.p',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        // Checkout logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber[600],
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'Checkout',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Helper function to calculate the subtotal
  int calculateSubtotal(List<dynamic> products) {
    return products.fold<int>(
      0,
      (sum, product) =>
          sum +
          ((product['price'] as num) * (product['quantity'] as num)).toInt(),
    );
  }
}
