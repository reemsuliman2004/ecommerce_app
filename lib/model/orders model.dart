class OrderModel {
  final int orderId;
  final double total;
  final String orderStatus;
  final String invoiceStatus;
  final String deliveryStatus;
  final double shippingCost;
  final ShippingAddress shippingAddress;
  final String createdAt;
  final List<OrderItem> items;
  final double? rating;

  OrderModel({
    required this.orderId,
    required this.total,
    required this.orderStatus,
    required this.invoiceStatus,
    required this.deliveryStatus,
    required this.shippingCost,
    required this.shippingAddress,
    required this.createdAt,
    required this.items,
    this.rating,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['order_id'] is int
          ? json['order_id']
          : int.parse(json['order_id'].toString()),
      total: json['total'] is double
          ? json['total']
          : double.parse(json['total'].toString()),
      orderStatus: json['order_status'].toString(),
      invoiceStatus: json['invoice_status'].toString(),
      deliveryStatus: json['delivery_status'].toString(),
      shippingCost: json['shipping_cost'] is double
          ? json['shipping_cost']
          : double.parse(json['shipping_cost'].toString()),
      shippingAddress: ShippingAddress.fromJson(json['shipping_address']),
      createdAt: json['created_at'].toString(),
      items: (json['items'] as List)
          .map((e) => OrderItem.fromJson(e))
          .toList(),
      rating: json['rating'] != null
          ? double.tryParse(json['rating'].toString())
          : null,
    );
  }
}

class ShippingAddress {
  final String latitude;
  final String longitude;

  ShippingAddress({
    required this.latitude,
    required this.longitude,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      latitude: json['latitude'].toString(),
      longitude: json['longitude'].toString(),
    );
  }
}

class OrderItem {
  final int productId;
  final String? productName;
  int quantity;
  final double price;
  final double total;

  OrderItem({
    required this.productId,
    this.productName,
    required this.quantity,
    required this.price,
    required this.total,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['product_id'] is int
          ? json['product_id']
          : int.parse(json['product_id'].toString()),
      productName: json['product_name']?.toString(),
      quantity: json['quantity'] is int
          ? json['quantity']
          : int.parse(json['quantity'].toString()),
      price: json['price'] is double
          ? json['price']
          : double.parse(json['price'].toString()),
      total: json['total'] is double
          ? json['total']
          : double.parse(json['total'].toString()),
    );
  }
}
