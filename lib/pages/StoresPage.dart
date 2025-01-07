import 'package:flutter/material.dart';
import 'package:pl_project/widgets/stores_cards.dart';
import 'package:pl_project/pages/StoreProductsPage.dart';
import 'package:pl_project/models/StoreModel.dart';
import 'package:pl_project/services/GetStoresService.dart';

class StoresPage extends StatelessWidget {
  final int categoryId; // ID of the category
  final String? categoryName; // Name of the category (e.g., Food Stores, Electronics)

  const StoresPage({super.key, required this.categoryId, required this.categoryName});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber[600],
          title: Text(
            categoryName!, // Use the categoryName dynamically for the title
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: FutureBuilder<List<StoreModel>>(
          future: GetStoresService().getStores(categoryId: categoryId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No stores found.'));
            } else {
              final stores = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 50),
                child: ListView.builder(
                  itemCount: stores.length,
                  itemBuilder: (context, index) {
                    final store = stores[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StoreProductsPage(
                              storeName: store.name, storeId: store.id,
                            ),
                          ),
                        );
                      },
                      child: StoresCards(
                        storeName: store.name,
                        // StoreImage: store.imageUrl,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StoreProductsPage(
                                storeName: store.name, storeId: store.id,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            }
          },
        ));
  }
}
