import 'package:flutter/material.dart';
import 'package:pl_project/widgets/FavoriteProductCard.dart';

class axisListBuilder extends StatelessWidget {
  final String listName;
  final List<Map<String, dynamic>> products;

  const axisListBuilder({
    super.key,
    required this.listName,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            listName, // name of the list
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return FavoriteProductCard(
                  imagePath: product['image_url'] ?? '',
                  productId: product['id'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
