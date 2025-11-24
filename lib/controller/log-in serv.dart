// auth_controller.dart
import 'package:dio/dio.dart';
import '../model/log-in model.dart';
import '../token_storage.dart'; // المتغير globalToken موجود هنا


class AuthController {
  final Dio dio = Dio();
  final String baseUrl = "${ApiConfig.baseUrl}/auth/";

  Future<String?> login(User user) async {
    try {
      final response = await dio.post(
        '${baseUrl}login',
        data: {
          'email': user.email,
          'password': user.password,
        },
      );

      if (response.statusCode == 200 && response.data['access_token'] != null) {
        final token = response.data['access_token'];
        globalToken = token; // تخزين التوكن عالمياً
        print("✅ Login successful. Token stored.");
        return token;
      } else {
        print("⚠️ Login failed. Invalid credentials.");
        return null;
      }
    } on DioError catch (dioError) {
      // التعامل مع الأخطاء الناتجة عن Dio
      print("❌ DioError during login: ${dioError.message}");
      return null;
    } catch (e) {
      print("❌ Unexpected error during login: $e");
      return null;
    }
  }
}
