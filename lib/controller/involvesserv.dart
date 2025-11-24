import 'dart:convert';
import 'package:dio/dio.dart';
import '../token_storage.dart';
import '../model/orders model.dart';

class OrderService {
  final Dio _dio = Dio();
  final String baseUrl = "${ApiConfig.baseUrl}/invoices";

  Future<List<OrderModel>> fetchInvoices() async {
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

      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((e) => OrderModel.fromJson(e)).toList();
      } else {
        throw Exception("فشل جلب البيانات (${response.statusCode})");
      }
    } catch (e) {
      throw Exception("❌ خطأ أثناء جلب الفواتير: $e");
    }
  }
}
