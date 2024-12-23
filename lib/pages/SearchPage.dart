import 'package:flutter/material.dart';

// TODO : make the search page
// TODO : make the search service

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 20.0,
          ),
          TextField(
            decoration: InputDecoration(
                label: Text('Search'),
                hintText: 'enter a product name',
                suffix: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)))),
          ),
          //the search result goes here
          SingleChildScrollView()
        ],
      ),
    );
  }
}
