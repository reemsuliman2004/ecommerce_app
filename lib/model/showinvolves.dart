class OrderModel {
  final int orderId;
  final int userId;
  final String total;
  final String status;
  final String shippingLatitude;
  final String shippingLongitude;
  final String shippingCost;
  final String createdAt;
  final String updatedAt;
  final List<OrderItemModel> items;

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.total,
    required this.status,
    required this.shippingLatitude,
    required this.shippingLongitude,
    required this.shippingCost,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['id'],
      userId: json['user_id'],
      total: json['total'],
      status: json['status'],
      shippingLatitude: json['shipping_latitude'],
      shippingLongitude: json['shipping_longitude'],
      shippingCost: json['shipping_cost'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      items: (json['items'] as List)
          .map((e) => OrderItemModel.fromJson(e))
          .toList(),
    );
  }
}

class OrderItemModel {
  final int id;
  final int saleInvoiceId;
  final int productId;
  int quantity;
  final String price;
  final String total;
  final String createdAt;
  final String updatedAt;
  final ProductModel product;

  OrderItemModel({
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

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'],
      saleInvoiceId: json['sale_invoice_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      price: json['price'],
      total: json['total'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      product: ProductModel.fromJson(json['product']),
    );
  }
}

class ProductModel {
  final int id;
  final String productName;
  final String unit;
  final String price;
  final String cost;
  final String batchNo;
  final String stock;
  final String serialNo;
  final String expiryDate;
  final String barcode;
  final String? imgUrl;
  final int categoryId;
  final int purchased;
  final String createdAt;
  final String updatedAt;

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
    this.imgUrl,
    required this.categoryId,
    required this.purchased,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      productName: json['product_name'],
      unit: json['unit'],
      price: json['price'],
      cost: json['cost'],
      batchNo: json['batch_no'],
      stock: json['stock'],
      serialNo: json['serial_no'],
      expiryDate: json['expiry_date'],
      barcode: json['barcode'],
      imgUrl: json['img_url'],
      categoryId: json['category_id'],
      purchased: json['purchased'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
