import 'package:flutter/material.dart';
import 'package:pl_project/components/products_cards.dart';

// TODO : make the service to get the products of a store

class FoodStoreProducts extends StatelessWidget {
  final String storeName;
  const FoodStoreProducts({super.key, required this.storeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$storeName - Products'),
        centerTitle: true,
        backgroundColor: Colors.amber[600],
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, top: 65),
        child: GridView.builder(
          clipBehavior: Clip.none,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.7,
            crossAxisSpacing: 10,
            mainAxisSpacing: 100,
          ),
          itemBuilder: (context, index) {
            return const ProductsCards();
          },
          itemCount: 10,
        ),
      ),
    );
  }
}
