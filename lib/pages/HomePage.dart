// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:pl_project/helper/api.dart';
import 'package:pl_project/models/ProductModel.dart';
import 'package:pl_project/pages/CartPage.dart';
import 'package:pl_project/pages/FavoritesPage.dart';
import 'package:pl_project/services/ProfileService.dart';
import 'package:pl_project/services/SomeProductsForHome.dart';
import 'package:pl_project/services/UserService.dart';
import 'package:pl_project/widgets/CustomButtonNavigationBar.dart' as btn;
import 'package:pl_project/pages/OrdersPage.dart';
import 'package:pl_project/pages/ProfilePage.dart';
import 'package:pl_project/pages/SearchPage.dart';
import 'package:pl_project/widgets/CategoriesWidget.dart' as cw;
import 'package:pl_project/pages/product_details.dart';
import 'package:pl_project/services/CartService.dart';
import 'package:pl_project/services/OrdersService.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late String? _token;

@override
void initState() {
  super.initState();
  _loadToken();
}

// Load the token from SharedPreferences
  Future<void> _loadToken() async {
    final userService = UserService(api: Api());
    await userService.loadToken(); // Load the token into UserService
    setState(() {
      _token = userService.token; // Set token state to be used in the widget
    });
  }

  final List<Widget> _pages = [
    const HomePageContent(),
    const SearchPage(),
    OrdersPage(orderService: OrderService(api: Api(),token: _HomePageState()._token) ,),
    ProfilePage(profileService: ProfileService(api: Api(), token: _HomePageState()._token),),
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
                    'Damascus'
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
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FavoritesPage()));
                },
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                iconSize: 18.0,
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CartPage(cartService: CartService(api: Api(),token: _token),)));
                },
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

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  late Future<List<ProductModel>> products;

  @override
  void initState() {
    super.initState();
    products = SomeProductsForHome().getSomeProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          const SizedBox(height: 25.0),
          const cw.CategoriesWidget(),
          const SizedBox(height: 50.0),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(child: Icon(Icons.storefront_sharp)),
              SizedBox(
                width: 8.0,
              ),
              Text(
                'Trending Products..',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(),
          Expanded(
            child: FutureBuilder<List<ProductModel>>(
                future: products,
                builder: (context, snapShot) {
                  if (snapShot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapShot.hasError) {
                    return Center(
                      child: Text('Error : ${snapShot.error}'),
                    );
                  } else if (!snapShot.hasData || snapShot.data!.isEmpty) {
                    return const Center(
                      child: Text('No products found'),
                    );
                  } else {
                    final products = snapShot.data!;
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.8,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ProductInHome(product: product);
                      },
                    );
                  }
                }),
          )
        ]));
  }
}

class ProductInHome extends StatelessWidget {
  const ProductInHome({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetails(product: product)));
      },
      child: Card(
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.image_url,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Text(
                '\$ ${product.price.toString()}',
                style: const TextStyle(color: Colors.green),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text(
                product.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
