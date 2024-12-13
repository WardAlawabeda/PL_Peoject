// ignore_for_file: file_names

class ProductModel {
  final String name;
  final int count;
  final String description;
  final double price;
  final String image;

  ProductModel(
      {required this.name,
      required this.count,
      required this.description,
      required this.price,
      required this.image});

  factory ProductModel.fromJson(jsonData) {
    return ProductModel(
        name: jsonData['name'],
        count: jsonData['count'],
        description: jsonData['description'],
        price: jsonData['price'],
        image: jsonData['image']);
  }
}
