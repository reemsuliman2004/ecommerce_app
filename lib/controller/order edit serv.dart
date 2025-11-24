import 'package:dio/dio.dart';

import '../model/order edit model.dart';
import '../token_storage.dart';

class OrderEditService {
  final Dio _dio = Dio();

  Future<UpdateOrderResponse?> updateOrderItem({
    required int orderId,
    required int productId,
    required int quantity,
  }) async {
    try {
      final token = globalToken;

      final url =
          "${ApiConfig.baseUrl}/orders/$orderId/update-item?product_id=$productId&quantity=$quantity";

      final response = await _dio.post(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      print("✅ Update Order Response: ${response.data}");

      return UpdateOrderResponse.fromJson(response.data);
    } catch (e) {
      print("❌ Error updating order item: $e");
      return null;
    }
  }
}
