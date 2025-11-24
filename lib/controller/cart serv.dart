import 'package:dio/dio.dart';
import '../model/addcart model.dart';
import '../token_storage.dart';

class CartService {
  final Dio _dio = Dio();
  final String baseUrl = '${ApiConfig.baseUrl}/cart/add';

  Future<AddToCartResponse> addToCart({
    required String token,
    required int productId,
    required int quantity,
  }) async {
    try {
      final response = await _dio.post(
        baseUrl,
        queryParameters: {
          'product_id': productId,
          'quantity': quantity,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // تأكد من أن البيانات عبارة عن Map
        if (response.data is Map<String, dynamic>) {
          return AddToCartResponse.fromJson(response.data);
        } else if (response.data is String) {
          return AddToCartResponse.fromRawJson(response.data);
        } else {
          throw Exception('صيغة غير متوقعة للاستجابة');
        }
      } else {
        throw Exception('فشل في الإضافة: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred: $e');
      throw Exception('فشل في الإضافة بسبب خطأ في الاتصال أو السيرفر');
    }
  }
}

