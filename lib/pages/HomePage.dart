// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:pl_project/models/btn.dart' as btn;
import 'package:pl_project/pages/OrdersPage.dart';
import 'package:pl_project/pages/ProfilePage.dart';
import 'package:pl_project/pages/SearchPage.dart';
import 'package:pl_project/pages/ShopsPage.dart';

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
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          const SizedBox(height: 25.0),       //Categories COntainer
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
          const SizedBox(height: 50.0),      //Stores Header
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children:[
              CircleAvatar(child: Icon(Icons.storefront_sharp)),
              SizedBox(width: 8.0,),
              Text(
                'Stores around you...',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  //color: Colors.blueGrey
                ),
                ),
            ],
          ),
          const SizedBox(),                 //Stores Grid View
          Flexible(
              child: GridView.count(
            padding: const EdgeInsets.all(4),
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            crossAxisCount: 2,
            children: [
              Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: const ButtonImage()),
              Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: const ButtonImage()),
              Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: const ButtonImage()),
              Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: const ButtonImage()),
            ],
          ))
        ]));
  }
}

class ButtonImage extends StatelessWidget {
  const ButtonImage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Stack(
          alignment: const Alignment(0.0, 0.8),
          children: [
            //  Image.asset('iuiapiuia')                 //the shop photo is here
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: const Text('the name of the shop'),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ShopsPage()));
        });
  }
}
