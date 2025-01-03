import 'package:flutter/material.dart';

class StoresCards extends StatelessWidget {
  final String storeName; // Dynamic store name
  final VoidCallback onTap; // Navigation or action on tap

  const StoresCards({
    super.key,
    required this.storeName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Execute the callback on tap
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            storeName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:pl_project/pages/StoreProducts.dart';
// // بطاقة المتجر

// class StoresCards extends StatelessWidget {
//   final String storeName;
//   final String StoreImage;
//   final VoidCallback onTap;
//   const StoresCards({
//     super.key,
//     required this.storeName,
//     required this.StoreImage,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => const StoreProducts(storeName: 'Store')));
//       },
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           const SizedBox(
//             width: double.infinity,
//             height: 150,
//             child: Card(
//               color: Color.fromRGBO(251, 188, 30, 1),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(top: 18, left: 18),
//                     child: Text(
//                       'McDonalds',
//                       style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontStyle: FontStyle.italic,
//                       ),
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.only(top: 7, left: 18, right: 10),
//                         child: Text(
//                           '20min',
//                           style: TextStyle(
//                             fontSize: 15,
//                             color: Colors.white,
//                             fontStyle: FontStyle.italic,
//                           ),
//                         ),
//                       ),
//                       Icon(Icons.delivery_dining_sharp, color: Colors.white),
//                     ],
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 7, left: 18, right: 10),
//                     child: Text(
//                       'delivery fee:5000s.p',
//                       style: TextStyle(
//                         fontSize: 15,
//                         color: Colors.white,
//                         fontStyle: FontStyle.italic,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//               right: 10,
//               top: -50,
//               child: Image.asset(
//                 'assets/images/mcdonalds.png',
//                 height: 150,
//               )),
//         ],
//       ),
//     );
//   }
// }
