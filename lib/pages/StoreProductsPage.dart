import 'package:flutter/material.dart';
import 'package:pl_project/components/products_cards.dart';
import 'package:pl_project/services/GetProductsService.dart';
import 'package:pl_project/models/ProductModel.dart';

class StoreProductsPage extends StatefulWidget {
  final String storeName;
  final int storeId;

  const StoreProductsPage({
    super.key,
    required this.storeName,
    required this.storeId
  });

  @override
  State<StoreProductsPage> createState() => _StoreProductsPageState();
}

class _StoreProductsPageState extends State<StoreProductsPage> {

  late Future<List<ProductModel>> products;

  @override
  void initState() {
    super.initState();
    products = GetProductsService().getProducts(storeId: widget.storeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.storeName} Products'),
        centerTitle: true,
        backgroundColor: Colors.amber[600],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: FutureBuilder<List<ProductModel>>(
          future: products,
          builder:(context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child : CircularProgressIndicator()
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No products found in this store'),
              );
            } else {
              final productsList = snapshot.data!;

              return GridView.builder(
                clipBehavior: Clip.none,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.35,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 25,
                  ),
              itemCount: productsList.length,
              itemBuilder: (context, index) {
                final product = productsList[index];
                return ProductsCards(product: product);
              },
              );
            }
          }
        )
      ),
    );
  }
}






