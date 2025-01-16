import 'package:flutter/material.dart';
import 'package:pl_project/pages/StoreProductsPage.dart';
import 'package:pl_project/pages/product_details.dart';
import 'package:pl_project/services/SearchService.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  final SearchService searchService = SearchService();

  List<dynamic> products = [];
  List<dynamic> stores = [];
  bool isLoading = false;

  Future<void> performSearch(String query) async {
    setState(() {
      isLoading = true;
    });

    try {
      final result = await searchService.search(query: query);
      setState(() {
        products = result["products"] ?? [];
        stores = result["stores"] ?? [];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Search'),
      //   backgroundColor: Colors.amber[600],
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                  label: const Text('Search'),
                  hintText: 'enter a product or a store name',
                  suffix: IconButton(
                      onPressed: () async {
                        await performSearch(searchController.text);
                      },
                      icon: const Icon(Icons.search)),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)))),
              onSubmitted: performSearch,
            ),
            const SizedBox(
              height: 20.0,
            ),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(child: buildSearchResults())
          ],
        ),
      ),
    );
  }

  Widget buildSearchResults() {
    if (products.isEmpty && stores.isEmpty) {
      return const Center(
        child: Text(
          'No results found.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView(
      children: [
        if (products.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Products:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ...products.map((product) {
            return ListTile(
              leading: Image.network(
                product['image_url'],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(product['name']),
              subtitle: Text('${product['price']} \$'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProductDetails(product: product)));
              },
            );
          }),
        ],
        if (stores.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Stores:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ...stores.map((store) {
            return ListTile(
              leading: const Icon(Icons.store),
              title: Text(store['name']),
              subtitle: const Text('Store details here'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StoreProductsPage(
                      storeName: store.name,
                      storeId: store.id,
                    ),
                  ),
                );
              },
            );
          }),
        ],
      ],
    );
  }
}
