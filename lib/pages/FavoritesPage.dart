import 'package:flutter/material.dart';

// TODO : make the favorite page

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
          backgroundColor: Colors.amber[600],
          title: const Text(
            "Favorites",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
    ));
  }
}