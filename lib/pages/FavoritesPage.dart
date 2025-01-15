import 'package:flutter/material.dart';
import 'package:pl_project/services/FavoriteProductsService.dart';
import 'package:pl_project/widgets/favoritelisthelper.dart';
import 'package:pl_project/helper/api.dart';


class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late Future<Map<String, List<Map<String, dynamic>>>> favoriteProductsFuture;

  @override
  void initState() {
    super.initState();
    final favoriteProductsService = FavoriteProductsService(
      api: Api(), // Replace with your Api instance
      token: "your-auth-token-here", // Replace with actual token
    );
    favoriteProductsFuture = favoriteProductsService.getFavoriteProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, List<Map<String, dynamic>>>>(
      future: favoriteProductsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final favoriteProducts = snapshot.data!;
          return ScrollablePage(favoriteProducts: favoriteProducts);
        } else {
          return const Center(child: Text('No favorites found.'));
        }
      },
    );
  }
}


class ScrollablePage extends StatelessWidget {
  final Map<String, List<Map<String, dynamic>>> favoriteProducts;

  const ScrollablePage({super.key, required this.favoriteProducts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorite',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.amber[600],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: favoriteProducts.entries.map((entry) {
            final categoryName = entry.key;
            final products = entry.value;

            return axisListBuilder(
              listName: categoryName,
              products: products,
            );
          }).toList(),
        ),
      ),
    );
  }
}
