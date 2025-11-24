
// token_storage.dart
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view/home-page.dart';
import '../token_storage.dart';



class RegisterController {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final cPasswordController = TextEditingController();

  final Dio _dio = Dio();

  Future<void> registerUser(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    final data = {
      'name': nameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'password': passwordController.text,
      'password_confirmation': cPasswordController.text,
    };

    try {
      final response = await _dio.post(
        "${ApiConfig.baseUrl}/auth/register",
        data: data,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration Successful")),
        );

        final token = response.data['access_token'];
        globalToken = token; // ✅ تخزين التوكين في المتغير العام

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else {
        debugPrint("Error Response: ${response.data}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration Failed: ${response.data}")),
        );
      }
    } on DioException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.response?.data['message'] ?? e.message}")),
      );
    }
  }
}

