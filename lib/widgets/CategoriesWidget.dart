import 'package:flutter/material.dart';
import 'package:pl_project/pages/StoresPage.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

Map<int, dynamic> icons = {
  0: Icons.restaurant_menu,
  1: Icons.mobile_friendly_rounded,
  2: Icons.girl_outlined,
  3: Icons.menu_book_rounded,
  4: Icons.home_work,
  5: Icons.cable,
  6: Icons.sports_basketball_rounded,
  7: Icons.toys_outlined,
};
Map<int, String?> catName = {
  0: 'Food',
  1: 'Electronics',
  2: 'Fashion',
  3: 'Books',
  4: 'Home Applies',
  5: 'Furniture',
  6: 'Sports',
  7: 'Toys',
};
class _CategoriesWidgetState extends State<CategoriesWidget> {
  PageController pageController = PageController(viewportFraction: 0.27);

  IconData currIcon = Icons.card_travel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Categories',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        SizedBox(
          height: 80.0,
          child: SizedBox(
            child: PageView.builder(
              padEnds: false,
              controller: pageController,
              itemCount: 8,
              itemBuilder: (context, position) {
                return buildPageItem(position);
              },
            ),
          ),
        ),
      ],
    );
  }

  Container buildPageItem(int position) {
    return Container(
        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.amber),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StoresPage(categoryId:position , categoryName: catName[position])),
              );
            },
            icon: Icon(icons[position]),
          ),
          Text(
            '${catName[position]}',
            style: const TextStyle(fontSize: 11.0, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 4.0,
          )
        ]));
  }
}
