import 'package:pl_project/helper/api.dart';
import 'package:pl_project/models/ProductModel.dart';

class ProductDetailsService {
  Future<ProductModel> getDetails({
    required int storeId,
    required int productId,
  }) async {
    try {
      final response = await Api.get(endPoint: '/stores/$storeId/products/$productId');

      // Check if response contains valid data
      return ProductModel.fromJson(response);
        } catch (e) {
      throw Exception('Failed to fetch product details: $e');
    }
  }
}
