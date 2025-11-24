import 'dart:convert';

class CategoryModel {
  final int id;
  final String categoryName;
  final dynamic categoryPhoto;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Pivot pivot;

  CategoryModel({
    required this.id,
    required this.categoryName,
    required this.categoryPhoto,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory CategoryModel.fromRawJson(String str) =>
      CategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    categoryName: json["category_name"],
    categoryPhoto: json["category_photo"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    pivot: Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": categoryName,
    "category_photo": categoryPhoto,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "pivot": pivot.toJson(),
  };
}

class Pivot {
  final int categoryId;
  final int warehouseId;

  Pivot({
    required this.categoryId,
    required this.warehouseId,
  });

  factory Pivot.fromRawJson(String str) => Pivot.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    categoryId: json["category_id"],
    warehouseId: json["warehouse_id"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "warehouse_id": warehouseId,
  };
}
