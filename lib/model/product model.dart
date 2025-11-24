import 'package:meta/meta.dart';
import 'dart:convert';

class ProductModel {
  final int id;
  final String productName;
  final String unit;
  final String price;
  final String cost;
  final String batchNo;
  final String stock;
  final String serialNo;
  final DateTime expiryDate;
  final String barcode;
  final dynamic imgUrl;
  final int categoryId;
  final int purchased;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Category category;
  final List<Warehouse> warehouses;

  ProductModel({
    required this.id,
    required this.productName,
    required this.unit,
    required this.price,
    required this.cost,
    required this.batchNo,
    required this.stock,
    required this.serialNo,
    required this.expiryDate,
    required this.barcode,
    required this.imgUrl,
    required this.categoryId,
    required this.purchased,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.warehouses,
  });

  ProductModel copyWith({
    int? id,
    String? productName,
    String? unit,
    String? price,
    String? cost,
    String? batchNo,
    String? stock,
    String? serialNo,
    DateTime? expiryDate,
    String? barcode,
    dynamic imgUrl,
    int? categoryId,
    int? purchased,
    DateTime? createdAt,
    DateTime? updatedAt,
    Category? category,
    List<Warehouse>? warehouses,
  }) =>
      ProductModel(
        id: id ?? this.id,
        productName: productName ?? this.productName,
        unit: unit ?? this.unit,
        price: price ?? this.price,
        cost: cost ?? this.cost,
        batchNo: batchNo ?? this.batchNo,
        stock: stock ?? this.stock,
        serialNo: serialNo ?? this.serialNo,
        expiryDate: expiryDate ?? this.expiryDate,
        barcode: barcode ?? this.barcode,
        imgUrl: imgUrl ?? this.imgUrl,
        categoryId: categoryId ?? this.categoryId,
        purchased: purchased ?? this.purchased,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        category: category ?? this.category,
        warehouses: warehouses ?? this.warehouses,
      );

  factory ProductModel.fromRawJson(String str) => ProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    productName: json["product_name"],
    unit: json["unit"],
    price: json["price"],
    cost: json["cost"],
    batchNo: json["batch_no"],
    stock: json["stock"],
    serialNo: json["serial_no"],
    expiryDate: DateTime.parse(json["expiry_date"]),
    barcode: json["barcode"],
    imgUrl: json["img_url"],
    categoryId: json["category_id"],
    purchased: json["purchased"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    category: Category.fromJson(json["category"]),
    warehouses: List<Warehouse>.from(json["warehouses"].map((x) => Warehouse.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_name": productName,
    "unit": unit,
    "price": price,
    "cost": cost,
    "batch_no": batchNo,
    "stock": stock,
    "serial_no": serialNo,
    "expiry_date": "${expiryDate.year.toString().padLeft(4, '0')}-${expiryDate.month.toString().padLeft(2, '0')}-${expiryDate.day.toString().padLeft(2, '0')}",
    "barcode": barcode,
    "img_url": imgUrl,
    "category_id": categoryId,
    "purchased": purchased,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "category": category.toJson(),
    "warehouses": List<dynamic>.from(warehouses.map((x) => x.toJson())),
  };
}

class Category {
  final int id;
  final String categoryName;
  final dynamic categoryPhoto;
  final DateTime createdAt;
  final DateTime updatedAt;

  Category({
    required this.id,
    required this.categoryName,
    required this.categoryPhoto,
    required this.createdAt,
    required this.updatedAt,
  });

  Category copyWith({
    int? id,
    String? categoryName,
    dynamic categoryPhoto,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Category(
        id: id ?? this.id,
        categoryName: categoryName ?? this.categoryName,
        categoryPhoto: categoryPhoto ?? this.categoryPhoto,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Category.fromRawJson(String str) => Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    categoryName: json["category_name"],
    categoryPhoto: json["category_photo"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": categoryName,
    "category_photo": categoryPhoto,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Warehouse {
  final int id;
  final String warehouseName;
  final String warehouseLocation;
  final String latitude;
  final String longitude;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Pivot pivot;

  Warehouse({
    required this.id,
    required this.warehouseName,
    required this.warehouseLocation,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  Warehouse copyWith({
    int? id,
    String? warehouseName,
    String? warehouseLocation,
    String? latitude,
    String? longitude,
    DateTime? createdAt,
    DateTime? updatedAt,
    Pivot? pivot,
  }) =>
      Warehouse(
        id: id ?? this.id,
        warehouseName: warehouseName ?? this.warehouseName,
        warehouseLocation: warehouseLocation ?? this.warehouseLocation,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        pivot: pivot ?? this.pivot,
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
    pivot: Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "warehouse_name": warehouseName,
    "warehouse_location": warehouseLocation,
    "latitude": latitude,
    "longitude": longitude,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "pivot": pivot.toJson(),
  };
}

class Pivot {
  final int productId;
  final int warehouseId;

  Pivot({
    required this.productId,
    required this.warehouseId,
  });

  Pivot copyWith({
    int? productId,
    int? warehouseId,
  }) =>
      Pivot(
        productId: productId ?? this.productId,
        warehouseId: warehouseId ?? this.warehouseId,
      );

  factory Pivot.fromRawJson(String str) => Pivot.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    productId: json["product_id"],
    warehouseId: json["warehouse_id"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "warehouse_id": warehouseId,
  };
}



