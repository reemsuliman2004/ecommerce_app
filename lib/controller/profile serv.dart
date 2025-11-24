import 'package:dio/dio.dart';
import '../model/profile model.dart';
import '../token_storage.dart';

class ProfileController {
  final Dio dio = Dio();
  final String baseUrl = "${ApiConfig.baseUrl}/auth/profile";

  // 🔄 جلب البروفايل
  Future<Profile?> fetchProfile() async {
    try {
      print("🚀 بدء تنفيذ الطلب...");

      final token = globalToken;
      if (token == null || token.isEmpty) {
        print("❌ لا يوجد توكين");
        return null;
      }

      final response = await dio.get(
        baseUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${token}',
            'Accept': 'application/json',
          },
        ),
      );

      print("✅ حالة الاستجابة: ${response.statusCode}");
      print("📦 البيانات المستلمة: ${response.data}");

      if (response.statusCode == 200) {
        return Profile.fromJson(response.data);
      } else {
        print("⚠️ حالة الاستجابة غير متوقعة: ${response.statusCode}");
        return null;
      }

    } catch (e) {
      print("❌ خطأ في الطلب: $e");
      return null;
    }
  }

  // ✏️ تعديل البروفايل
  Future<bool> updateProfile({
    String? name,
    String? phone,
    String? password,
  }) async {
    try {
      print("🚀 بدء تعديل البروفايل...");

      final token = globalToken;
      if (token == null || token.isEmpty) {
        print("❌ لا يوجد توكين");
        return false;
      }

      // تجهيز البيانات
      final Map<String, dynamic> data = {};

      if (name != null && name.isNotEmpty) data['name'] = name;
      if (phone != null && phone.isNotEmpty) data['phone'] = phone;
      if (password != null && password.isNotEmpty) data['password'] = password;

      // تنفيذ الطلب PUT
      final response = await dio.put(
        "http://192.168.178.245:8001/api/profile",  // ✅ تأكد من تعديل IP حسب الجهاز الفعلي
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

      print("✅ حالة الاستجابة: ${response.statusCode}");
      print("📦 البيانات المستلمة بعد التعديل: ${response.data}");

      return response.statusCode == 200;

    } catch (e) {
      print("❌ خطأ أثناء تعديل البروفايل: $e");
      return false;
    }
  }

}
