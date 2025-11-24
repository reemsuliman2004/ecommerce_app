// lib/controllers/warehouse_controller.dart

import 'package:dio/dio.dart';

import '../model/warehouse show model.dart';
import '../token_storage.dart';


class WarehouseController {
  final Dio _dio = Dio();
  final String baseUrl = "${ApiConfig.baseUrl}/warehouse"; // بدل localhost

  Future<List<Warehouse>> getWarehouses() async {
    try {
      final token = globalToken;     final response = await _dio.get(
        baseUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      List data = response.data;
      return data.map((json) => Warehouse.fromJson(json)).toList();
    } catch (e) {
      print("Error fetching warehouses: $e");
      rethrow;
    }
  }


}
