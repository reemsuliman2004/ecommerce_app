import 'package:dio/dio.dart';


import '../model/viewcart.dart';
import '../token_storage.dart';

class ViewCartService {
  final Dio _dio = Dio();
  final String baseUrl = "${ApiConfig.baseUrl}/cart"; // غيّر localhost إذا احتجت

  Future<List<Viewcart>> getCartItems() async {
    try {
      final token = globalToken;
      print("🔑 التوكن: $token");

      if (token == null || token.isEmpty) {
        print("❌ لا يوجد توكين");
        return [];
      }

      final response = await _dio.get(
        baseUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      final responseData = response.data;
      print("📥 الاستجابة: $responseData");

      // ✅ تحقق إن كانت الاستجابة عبارة عن List
      if (responseData is List) {
        return responseData
            .map((item) => Viewcart.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        print("⚠️ الاستجابة ليست قائمة.");
        return [];
      }

    } catch (e) {
      if (e is DioException) {
        print("❌ استجابة السيرفر: ${e.response?.data}");
        print("📦 كود الحالة: ${e.response?.statusCode}");
        print("🌐 الرابط: ${e.requestOptions.uri}");
        print("📬 الهيدر: ${e.requestOptions.headers}");
      } else {
        print("❌ خطأ غير متوقع: $e");
      }
      rethrow;
    }
  }




}
