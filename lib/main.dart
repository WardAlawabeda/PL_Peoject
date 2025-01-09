import 'package:flutter/material.dart';
import 'package:pl_project/pages/LogInPage.dart';

void main() {
  runApp(const DeliveryApp());
}

class DeliveryApp extends StatelessWidget {
  const DeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.amber,
        useMaterial3: true,
      ),
      home:  const LogInPage(),
    );
  }
}
