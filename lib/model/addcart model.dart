import 'package:meta/meta.dart';
import 'dart:convert';

class AddToCartResponse {
  final String message;

  AddToCartResponse({
    required this.message,
  });

  AddToCartResponse copyWith({
    String? message,
  }) =>
      AddToCartResponse(
        message: message ?? this.message,
      );

  factory AddToCartResponse.fromRawJson(String str) => AddToCartResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddToCartResponse.fromJson(Map<String, dynamic> json) => AddToCartResponse(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}