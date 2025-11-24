import 'package:meta/meta.dart';
import 'dart:convert';

class ChekOut {
  final int userId;
  final String status;
  final String shippingLatitude;
  final String shippingLongitude;
  final double shippingCost;
  final double total;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;
  final List<Item> items;

  ChekOut({
    required this.userId,
    required this.status,
    required this.shippingLatitude,
    required this.shippingLongitude,
    required this.shippingCost,
    required this.total,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.items,
  });

  ChekOut copyWith({
    int? userId,
    String? status,
    String? shippingLatitude,
    String? shippingLongitude,
    double? shippingCost,
    double? total,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? id,
    List<Item>? items,
  }) =>
      ChekOut(
        userId: userId ?? this.userId,
        status: status ?? this.status,
        shippingLatitude: shippingLatitude ?? this.shippingLatitude,
        shippingLongitude: shippingLongitude ?? this.shippingLongitude,
        shippingCost: shippingCost ?? this.shippingCost,
        total: total ?? this.total,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        items: items ?? this.items,
      );

  factory ChekOut.fromRawJson(String str) => ChekOut.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChekOut.fromJson(Map<String, dynamic> json) => ChekOut(
    userId: json["user_id"],
    status: json["status"],
    shippingLatitude: json["shipping_latitude"],
    shippingLongitude: json["shipping_longitude"],
    shippingCost: json["shipping_cost"]?.toDouble(),
    total: json["total"]?.toDouble(),
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "status": status,
    "shipping_latitude": shippingLatitude,
    "shipping_longitude": shippingLongitude,
    "shipping_cost": shippingCost,
    "total": total,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  final int id;
  final int saleInvoiceId;
  final int productId;
  final int quantity;
  final String price;
  final String total;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Product product;

  Item({
    required this.id,
    required this.saleInvoiceId,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  Item copyWith({
    int? id,
    int? saleInvoiceId,
    int? productId,
    int? quantity,
    String? price,
    String? total,
    DateTime? createdAt,
    DateTime? updatedAt,
    Product? product,
  }) =>
      Item(
        id: id ?? this.id,
        saleInvoiceId: saleInvoiceId ?? this.saleInvoiceId,
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
        total: total ?? this.total,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        product: product ?? this.product,
      );

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    saleInvoiceId: json["sale_invoice_id"],
    productId: json["product_id"],
    quantity: json["quantity"],
    price: json["price"],
    total: json["total"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    product: Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sale_invoice_id": saleInvoiceId,
    "product_id": productId,
    "quantity": quantity,
    "price": price,
    "total": total,
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
