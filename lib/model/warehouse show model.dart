import 'package:meta/meta.dart';
import 'dart:convert';

class Warehouse {
  final int id;
  final String warehouseName;
  final String warehouseLocation;
  final String latitude;
  final String longitude;
  final DateTime createdAt;
  final DateTime updatedAt;

  Warehouse({
    required this.id,
    required this.warehouseName,
    required this.warehouseLocation,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
  });

  Warehouse copyWith({
    int? id,
    String? warehouseName,
    String? warehouseLocation,
    String? latitude,
    String? longitude,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Warehouse(
        id: id ?? this.id,
        warehouseName: warehouseName ?? this.warehouseName,
        warehouseLocation: warehouseLocation ?? this.warehouseLocation,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Warehouse.fromRawJson(String str) => Warehouse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Warehouse.fromJson(Map<String, dynamic> json) => Warehouse(
    id: json["id"],
    warehouseName: json["warehouse_name"],
    warehouseLocation: json["warehouse_location"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "warehouse_name": warehouseName,
    "warehouse_location": warehouseLocation,
    "latitude": latitude,
    "longitude": longitude,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

