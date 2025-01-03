import 'package:pl_project/helper/api.dart';
import 'package:pl_project/models/StoreModel.dart'; // Ensure you have the StoreModel class

class GetStoresService {
  // Fetch stores for a specific category
  Future<List<StoreModel>> getStores({required int categoryId}) async {
    try {
      // Fetch the response from the API
      final response = await Api.getList(endPoint: '/categories/${categoryId+1}/stores');

      // Map the list of stores to StoreModel objects
      return response.map((json) => StoreModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception("Failed to fetch stores: $e");
    }
  }
}
