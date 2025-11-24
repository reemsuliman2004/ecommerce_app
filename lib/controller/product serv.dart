import 'package:dio/dio.dart';

import '../model/product model.dart';
import '../token_storage.dart';

class ProductController {
  final Dio _dio = Dio();
  final String baseUrl = "${ApiConfig.baseUrl}/product";

  Future<List<ProductModel>> getProducts(int categoryId, int warehouseId) async {
    try {
      final token = globalToken;

      final response = await _dio.get(
        "${ApiConfig.baseUrl}/product",
        queryParameters: {
          'category_id': categoryId,
          'warehouse_id': warehouseId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      print("📦 Product Response: ${response.data}");

      final responseData = response.data;

      if (responseData == null || responseData is! List) {
        print("❌ Product response is not a valid list");
        return [];
      }

      List products = responseData;

      return products.map((e) => ProductModel.fromJson(e)).toList();

    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }

}





