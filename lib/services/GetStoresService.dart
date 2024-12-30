import 'package:pl_project/helper/api.dart';
import 'package:pl_project/models/StoreModel.dart';

class GetStoresService {

Future<List<StoreModel>> getStores({required int categoryId})async {

 try {
      final response = await Api.get(endPoint: '/categories/$categoryId/stores');

      if (response.containsKey('data')) {
        List<dynamic> data = response['data'];

        return data.map((json) => StoreModel.fromJson(json)).toList();
      } else {
        throw Exception("No data found");
      }
    } catch (e) {
      throw Exception("Failed to fetch stores: $e");
    }
}

}