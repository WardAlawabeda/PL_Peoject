import 'package:flutter/material.dart';
import 'package:pl_project/pages/product_details.dart';

class ProductsCards extends StatefulWidget {
  const ProductsCards({super.key});
  @override
  State<ProductsCards> createState() => _ProductsCardsState();
}

class _ProductsCardsState extends State<ProductsCards> {
  IconData currentIcon = Icons.favorite_border; //initial icon.
  void changeIcon() {
    setState(() {
      if (currentIcon == Icons.favorite_border) {
        currentIcon = Icons.favorite;
      } else {
        currentIcon = Icons.favorite_border;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProductDetails()));
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 160,
            width: 220,
            child: Card(
              elevation: 11,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'burger', //product name
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '2500s.p',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                            child: Icon(
                              currentIcon,
                              color: Colors.red,
                            ),
                            onTap: changeIcon),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 5,
            bottom: 65,
            child: Image.asset(
              'assets/images/burger.png',
              height: 90,
            ),
          ),
          Positioned(
            child: GestureDetector(
                child: Icon(
                  Icons.add_circle,
                  color: const Color.fromARGB(255, 27, 110, 255),
                ),
                onTap: () {}),
            left: -5,
            top: -5,
          ),
        ],
      ),
    );
  }
}
