import 'package:flutter/material.dart';
import 'package:pl_project/components/stores_cards.dart';
import 'package:pl_project/pages/food_store_products.dart';

//عرض المتاجر
class FoodStoresList extends StatelessWidget {
  const FoodStoresList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber[600],
          title: Text(
            'FoodStores',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 50),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FoodStoreProducts(storeName: 'Store')));
            },
            child: GridView.builder(
                clipBehavior: Clip.none,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 2,
                  mainAxisSpacing: 10,
                ),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return StoresCards(
                      storeName: 'McDonalds',
                      StoreImage: 'assets/images/mcdonalds.png',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FoodStoreProducts(
                                    storeName: 'Store ${index + 1}')));
                      });
                }),
          ),
        ));
  }
}
