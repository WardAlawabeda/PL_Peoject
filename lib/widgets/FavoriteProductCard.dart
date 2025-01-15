import 'package:flutter/material.dart';
// import 'package:pl_project/pages/product_details.dart';

class FavoriteProductCard extends StatefulWidget {
  final String imagePath;
  FavoriteProductCard({required this.imagePath});
  @override
  State<FavoriteProductCard> createState() => _FavoriteProductCardState();
}

class _FavoriteProductCardState extends State<FavoriteProductCard> {
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => ProductDetails(product:,)));
            },
            child: Container(
              width: 150,
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: Colors.amber[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Image(
                    image: AssetImage(
                        widget.imagePath)), //path of the product's picture.
              ),
            ),
          ),
          Positioned(
            top: -2,
            right: 0,
            child: GestureDetector(
                onTap: changeIcon,
                child: Icon(
                  currentIcon,
                  color: Colors.red,
                )),
          ),
          Positioned(
            bottom: -2,
            child: GestureDetector(
              onTap: () {
                //add to cart
              },
              child: const Icon(
                Icons.add_circle,
                color: Color.fromARGB(255, 27, 110, 255),
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}
