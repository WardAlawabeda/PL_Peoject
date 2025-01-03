import 'package:flutter/material.dart';

// TODO : make the notification page

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
          backgroundColor: Colors.amber[600],
          title: const Text(
            "Notifications",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
    ));
  }
}