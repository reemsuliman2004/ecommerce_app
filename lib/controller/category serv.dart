import 'package:dio/dio.dart';
import '../model/category model.dart';
import '../token_storage.dart';

class CategoryController {
  final Dio _dio = Dio();
  final String baseUrl = "${ApiConfig.baseUrl}/category";

  Future<List<CategoryModel>> getCategoriesByWarehouse(int warehouseId) async {
    try {
      final token = globalToken;
      if (token == null || token.isEmpty) {
        print("❌ لا يوجد توكين");
        return [];
      }

      final response = await _dio.get(
        "$baseUrl/warehouses/$warehouseId", // ✅ رابطك الصح
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      // الاستجابة: { "warehouse_id": 2, "categories": [ ... ] }
      final data = response.data['categories'] as List;

      return data.map((json) => CategoryModel.fromJson(json)).toList();
    } catch (e) {
      print("Error fetching categories: $e");
      rethrow;
    }
  }
}
