import 'package:flutter/material.dart';
import 'package:pl_project/helper/TokenStorage.dart';
import 'package:pl_project/helper/api.dart';
import 'package:pl_project/models/ProductModel.dart';
import 'package:pl_project/services/CartService.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel product;

  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int quantity = 0;
  String? _token;

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  Future<void> loadToken() async {
    _token = await TokenStorage.getToken();
  }

  void addToCart() {
    CartService CS = CartService(api: Api(), token: _token);
    CS.addProductToCart(widget.product.id, quantity);
  }

  void decrementQuantity() {
    if (quantity > 0) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber[600],
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //top rounded container
              Container(
                decoration: BoxDecoration(
                  color: Colors.amber[600],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(400),
                    bottomRight: Radius.circular(400),
                  ),
                ),
                width: double.infinity,
                height: 400,
              ),
              //product name and price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 50),
                    child: Text(
                      widget.product.name,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, top: 50),
                    child: Text(
                      '${widget.product.price} \$',
                      style: TextStyle(
                        color: Colors.amber[600],
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              //details button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.amber[600],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        'Details',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              //product description
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 40),
                child: Text(
                  widget.product.description,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
              //quantity selector and add to cart button
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      color: Colors.amber[600],
                      iconSize: 40,
                      onPressed: decrementQuantity,
                      icon: const Icon(Icons.remove_circle),
                    ),
                    //quantity display
                    Text(
                      '$quantity',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    IconButton(
                      color: Colors.amber[600],
                      iconSize: 40,
                      onPressed: incrementQuantity,
                      icon: const Icon(Icons.add_circle),
                    ),
                    //add to cart button
                    Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.amber[600],
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            addToCart();
                          },
                          child: const Text(
                            'Add to cart',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          //product image
          Positioned(
            top: 150,
            right: 35,
            child: Image.network(
              widget.product.image_url,
              height: 250,
            ),
          ),
        ],
      ),
    );
  }
}
