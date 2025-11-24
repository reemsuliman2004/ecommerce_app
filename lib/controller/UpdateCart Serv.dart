import 'package:dio/dio.dart';
import '../token_storage.dart';

class UpdateCartService {
  final Dio _dio = Dio();
  final String baseUrl = "${ApiConfig.baseUrl}/cart/update";

  Future<String> updateCartItem({required int productId, required int quantity}) async {
    try {
      final token = globalToken;

      final response = await _dio.post(
        "$baseUrl?product_id=$productId&quantity=$quantity",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return "✅ تم تعديل السلة بنجاح";
      } else {
        return "⚠️ فشل في تعديل السلة: ${response.statusCode}";
      }
    } catch (e) {
      return "❌ خطأ أثناء تعديل السلة: $e";
    }
  }
}
