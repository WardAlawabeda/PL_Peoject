// ignore_for_file: file_names

class ProductModel {
  final int id;
  final String name;
  final double price;
  final int storeId;
  final String description;
  final int count;
  final String image;

  ProductModel(
      {required this.name,
      required this.id,
      required this.storeId,
      required this.count,
      required this.description,
      required this.price,
      required this.image});

  factory ProductModel.fromJson(Map<String,dynamic> jsonData) {
    return ProductModel(
        name: jsonData['name'],
        count: jsonData['count'],
        description: jsonData['description'],
        price: jsonData['price'].toDouble(),
        image: jsonData['image'],
        id: jsonData['id'],
        storeId: jsonData['storeId']);
  }
}
