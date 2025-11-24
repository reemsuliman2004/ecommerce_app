// lib/token_storage.dart

String? globalToken;
// lib/config/api_config.dart

class ApiConfig {
  static const String ip = "10.232.60.245"; // هنا تعدل الـ IP مرة وحدة
  static const String port = "8001";

  static String get baseUrl => "http://$ip:$port/api";
}
