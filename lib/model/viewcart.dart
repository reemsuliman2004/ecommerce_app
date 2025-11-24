import 'package:meta/meta.dart';
import 'dart:convert';

class Viewcart {
  final int id;
  final int userId;
  final int productId;
   int quantity;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Product product;

  Viewcart({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  Viewcart copyWith({
    int? id,
    int? userId,
    int? productId,
    int? quantity,
    DateTime? createdAt,
    DateTime? updatedAt,
    Product? product,
  }) =>
      Viewcart(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        product: product ?? this.product,
      );

  factory Viewcart.fromRawJson(String str) => Viewcart.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Viewcart.fromJson(Map<String, dynamic> json) => Viewcart(
    id: json["id"],
    userId: json["user_id"],
    productId: json["product_id"],
    quantity: json["quantity"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    product: Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "product_id": productId,
    "quantity": quantity,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "product": product.toJson(),
  };
}

class Product {
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

  Product({
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
  });

  Product copyWith({
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
  }) =>
      Product(
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
      );

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
  };
}
