import 'package:pl_project/helper/api.dart';
import 'package:pl_project/models/ProductModel.dart';

class GetSomeStoresForHome {
  Future<List<ProductModel>> getSomeProducts() async {
    try {
      // Await the API call to ensure it completes before proceeding
      final response = await Api.get(endPoint: '/home/products');

      // Check if the response contains the expected 'data' key
      if (response.isNotEmpty && response.containsKey('data')) {
        List<dynamic> data = response['data'];

        // Map the data into a list of ProductModel objects
        return data.map((jsonData) => ProductModel.fromJson(jsonData)).toList();
      } else {
        throw Exception("No data found in response");
      }
    } catch (e) {
      // Handle and throw more detailed exceptions
      throw Exception("Failed to fetch products: $e");
    }
  }
}
