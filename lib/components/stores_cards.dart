import 'package:flutter/material.dart';
import 'package:pl_project/pages/food_store_products.dart';
// بطاقة المتجر

class StoresCards extends StatelessWidget {
  final String storeName;
  final String StoreImage;
  final VoidCallback onTap;
  const StoresCards({
    required this.storeName,
    required this.StoreImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FoodStoreProducts(storeName: 'Store')));
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            height: 150,
            child: Card(
              color: Color.fromRGBO(251, 188, 30, 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18, left: 18),
                    child: Text(
                      'McDonalds',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 7, left: 18, right: 10),
                        child: Text(
                          '20min',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      Icon(Icons.delivery_dining_sharp, color: Colors.white),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7, left: 18, right: 10),
                    child: Text(
                      'delivery fee:5000s.p',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              child: Image.asset(
                'assets/images/mcdonalds.png',
                height: 150,
              ),
              right: 10,
              top: -50),
        ],
      ),
    );
  }
}
