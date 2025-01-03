class StoreModel {
  final int id;
  final String name;
  final int categoryId;
  final String createdAt;
  final String updatedAt;

  StoreModel({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to parse JSON
  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'],
      name: json['name'],
      categoryId: json['category_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
