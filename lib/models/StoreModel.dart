class StoreModel {
  final int id;
  final String name;
  final String imageUrl;

  StoreModel({required this.id, required this.name, required this.imageUrl});

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
    );
  }
}