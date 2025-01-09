import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final ontap;
  final String buttonname;
  const CustomButton({
    super.key,
    required this.ontap,
    required this.buttonname,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        onPressed: ontap,
        padding: const EdgeInsets.all(15),
        color: Colors.deepOrange[600],
        textColor: Colors.white,
        child: Text(
          buttonname,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}