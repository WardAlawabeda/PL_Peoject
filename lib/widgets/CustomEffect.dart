import 'package:flutter/material.dart';

class CustomEffect extends StatelessWidget {
  const CustomEffect(
      {super.key,
      required this.blackHint,
      required this.orangeHint,
      this.navigation});
  final String blackHint;
  final String orangeHint;
  final navigation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                blackHint,
                style: const TextStyle(fontSize: 16),
              ),
              InkWell(
                onTap: navigation,
                child: Text(
                  orangeHint,
                  style: TextStyle(
                    color: Colors.deepOrange[600],
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Stack(
            children: [
              Container(
                width: 250,
                height: 4,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)),
              ),
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.deepOrange[600],
                      borderRadius: BorderRadius.circular(20)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}