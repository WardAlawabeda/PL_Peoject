import 'package:pl_project/helper/api.dart';
import 'package:pl_project/models/ProductModel.dart';

class GetSomeStoresForHome {
  Future<List<ProductModel>> getSomeProducts() async {
    try {
      final response = Api.get(endPoint: '/home/products');
      if (response.containsKey('data')) {
        List<dynamic> data = response['data'];
        return data.map((jsonData) => ProductModel.fromJson(jsonData)).toList();
      } else {
        throw Exception("No data found");
      }
    } catch (e) {
      throw Exception("Failed to fetch products $e");
    }
  }
}
