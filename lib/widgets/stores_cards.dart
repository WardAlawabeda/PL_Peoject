import 'package:flutter/material.dart';

class StoresCards extends StatelessWidget {
  final String storeName;
  final VoidCallback onTap;
  final String storeImage;
  const StoresCards({
    super.key,
    required this.storeName,
    required this.onTap,
    required this.storeImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:  Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            width: double.infinity,
            height: 150,
            child: Card(
              color: const Color.fromRGBO(251, 188, 30, 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18, left: 18),
                    child: Text(
                      storeName,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 7, left: 18, right: 10),
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
                  const Padding(
                    padding: EdgeInsets.only(top: 7, left: 18, right: 10),
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
              right: 10,
              top: -50,
              child: Image.network(
                storeImage,
                height: 150,
              )),
        ],
      ),
    );
  }
}