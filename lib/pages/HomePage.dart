// ignore: file_names

import 'package:flutter/material.dart';
import 'package:pl_project/models/btn.dart' as btn;
import 'package:pl_project/pages/OrdersPage.dart';
import 'package:pl_project/pages/ProfilePage.dart';
import 'package:pl_project/pages/SearchPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePageContent(),
    const SearchPage(),
    const ProfilePage(),
    const OrdersPage(),
  ];
  void _onTaped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery App'),
        centerTitle: true,
        leadingWidth: 95.0,
        leading: Builder(builder: (BuildContext context) {
          return const Row(
            children: [
              Icon(
                Icons.location_on,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Location :',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    'Damascus',
                  )
                ],
              )
            ],
          );
        }),
        backgroundColor: Colors.amber[600],
        toolbarHeight: 80.0,
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.yellowAccent,
                ),
                iconSize: 18.0,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                iconSize: 18.0,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart),
                iconSize: 18.0,
              ),
            ],
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: btn.CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTaped,
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 25.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Column(
                children: [
                  Container(
                    height: 40.0,
                    color: Colors.amber[300],
                    child: const Center(
                      child: Text(
                        'Categories',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 70.0,
                    color: Colors.amber[900],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.home,
                            size: 30,
                          ),
                        )),
                        Expanded(
                            child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.home,
                            size: 30,
                          ),
                        )),
                        Expanded(
                            child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.home,
                            size: 30,
                          ),
                        )),
                        Expanded(
                            child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.home,
                            size: 30,
                          ),
                        )),
                        Expanded(
                            child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.home,
                            size: 30,
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: const Column(
                children: [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
