import 'package:pl_project/helper/api.dart';

class SearchService {
  Future<Map<String, List<dynamic>>> search({required String query}) async {
    try {
      // API endpoint for searching
      final response = await Api.get(endPoint: '/search?query=$query');

      // Extract products and stores from the response
      final products = response['products'] ?? [];
      final stores = response['stores'] ?? [];

      if (products is List && stores is List) {
        return {
          "products": products,
          "stores": stores,
        };
      } else {
        throw Exception("Invalid response format");
      }
    } catch (e) {
      throw Exception("Failed to fetch search results: $e");
    }
  }
}
