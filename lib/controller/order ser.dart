import 'package:dio/dio.dart';

import '../model/orders model.dart';
import '../token_storage.dart';

class OrderController {
  final Dio _dio = Dio();
  final String baseUrl = "${ApiConfig.baseUrl}/orders";

  Future<List<OrderModel>> getOrders() async {
    try {
      final token = globalToken;

      final response = await _dio.get(
        baseUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      print("📦 Orders Response: ${response.data}");

      final responseData = response.data;

      if (responseData == null || responseData is! List) {
        print("❌ Orders response is not a valid list");
        return [];
      }

      return responseData.map<OrderModel>((e) => OrderModel.fromJson(e)).toList();
    } catch (e) {
      print("Error fetching orders: $e");
      return [];
    }
  }
}
