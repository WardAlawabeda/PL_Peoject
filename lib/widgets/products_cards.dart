import 'package:flutter/material.dart';
import 'package:pl_project/models/ProductModel.dart';
import 'package:pl_project/pages/product_details.dart';

class ProductsCards extends StatefulWidget {
  final ProductModel product;

  const ProductsCards({super.key, required this.product});
  @override
  State<ProductsCards> createState() => _ProductsCardsState();
}

class _ProductsCardsState extends State<ProductsCards> {
  IconData currentIcon = Icons.favorite_border; //initial icon.

  void changeIcon() {
    setState(() {
      currentIcon = currentIcon == Icons.favorite_border
      ? Icons.favorite
      : Icons.favorite_border;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProductDetails(product: widget.product,)));
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
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
                      widget.product.name, //product name
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${widget.product.price} \$',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                            onTap: changeIcon,
                            child: Icon(
                              currentIcon,
                              color: Colors.red,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          //Product Image
          Positioned(
            right: 5,
            bottom: 65,
            child: Image.network(
              widget.product.image_url,
              fit: BoxFit.cover,
              height: 100,
              width: double.infinity,
            ),
          ),
          //Add Button
          Positioned(
            left: -5,
            top: -5,
            child: GestureDetector(
                child: const Icon(
                  Icons.add_circle,
                  color: Color.fromARGB(255, 27, 110, 255),
                ),
                onTap: () {}),
          ),
        ],
      ),
    );
  }
}
