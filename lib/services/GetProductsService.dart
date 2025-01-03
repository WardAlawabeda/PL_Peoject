import 'package:pl_project/helper/api.dart';
import 'package:pl_project/models/ProductModel.dart';

class GetProductsService {
  Future<List<ProductModel>> getProducts({storeId}) async {
    try {
      final response = await Api.getList(endPoint: '/stores/$storeId/products');

      return response.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch data $e');
    }
  }
}
