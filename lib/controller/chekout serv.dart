import 'package:dio/dio.dart';
import '../token_storage.dart';

class CheckoutService {
  final Dio _dio = Dio();
  final String baseUrl = "${ApiConfig.baseUrl}/checkout";

  Future<Map<String, dynamic>> checkout({
    required double lat,
    required double lng,
  }) async {
    try {
      final token = globalToken;

      final response = await _dio.post(
        baseUrl,
        data: {
          "shipping_latitude": lat,
          "shipping_longitude": lng,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
          validateStatus: (status) => true, // لقبول أي status code
        ),
      );

      print("✅ CheckoutService response status: ${response.statusCode}");
      print("✅ CheckoutService response data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {"success": true, "data": response.data};
      } else {
        return {
          "success": false,
          "message": "❌ خطأ من السيرفر: ${response.data}"
        };
      }
    } catch (e, stackTrace) {
      print("❌ CheckoutService error: $e");
      print(stackTrace);
      return {"success": false, "message": "❌ خطأ أثناء التنفيذ: $e"};
    }
  }
}
