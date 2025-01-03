import 'package:flutter/material.dart';

// TODO : make the cart page

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
          backgroundColor: Colors.amber[600],
          title: const Text(
            "Cart",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
    ));
  }
}