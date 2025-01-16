import 'package:flutter/material.dart';
import 'package:pl_project/helper/api.dart';
import 'package:pl_project/services/FavoriteProductsService.dart';
import 'package:pl_project/widgets/favoritelisthelper.dart';
import 'package:pl_project/helper/TokenStorage.dart'; // Import the TokenStorage class

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late Future<Map<String, List<Map<String, dynamic>>>> favoriteProductsFuture;

  String? _token;

  @override
  void initState() {
    super.initState();
    _loadToken(); // Load the token when the page is initialized
  }

  // Function to load the token from SharedPreferences using TokenStorage
  Future<void> _loadToken() async {
    try {
      _token = await TokenStorage.getToken(); // Retrieve the token
      if (_token != null) {
        final favoriteProductsService = FavoriteProductsService(
          api: Api(),
          token: _token, // Pass the token to FavoriteProductsService
        );
        favoriteProductsFuture = favoriteProductsService.getFavoriteProducts();
        setState(() {}); // Refresh the UI once the token is available
      }
    } catch (e) {
      print('Error loading token: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: Colors.amber[600],
      ),
      body: _token == null
          ? const Center(child: CircularProgressIndicator()) // Waiting for token
          : FutureBuilder<Map<String, List<Map<String, dynamic>>>>(
              future: favoriteProductsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  final favoriteProducts = snapshot.data!;
                  return ScrollablePage(favoriteProducts: favoriteProducts);
                } else {
                  return const Center(child: Text('No favorites found.'));
                }
              },
            ),
    );
  }
}

class ScrollablePage extends StatelessWidget {
  final Map<String, List<Map<String, dynamic>>> favoriteProducts;

  const ScrollablePage({super.key, required this.favoriteProducts});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }
}
