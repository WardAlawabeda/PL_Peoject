// ignore_for_file: file_names, non_constant_identifier_names

class ProductModel {
  final int id;
  final String name;
  final double price;
  final int store_id;
  final String description;
  final int stock;
  final String image_url;
  final String created_at;
  final String updated_at;

  ProductModel({
    required this.store_id,
    required this.stock,
    required this.image_url,
    required this.created_at,
    required this.updated_at,
    required this.name,
    required this.id,
    required this.description,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> jsonData) {
    return ProductModel(
      name: jsonData['name'],
      stock: jsonData['stock'],
      description: jsonData['description'],
      price: jsonData['price'].toDouble(),
      image_url: jsonData['image_url'],
      id: jsonData['id'],
      store_id: jsonData['store_id'],
      created_at: jsonData['created_at'],
      updated_at: jsonData['updated_at'],
    );
  }
}
