class UpdateOrderResponse {
  final String message;
  final UpdatedOrder order;

  UpdateOrderResponse({required this.message, required this.order});

  factory UpdateOrderResponse.fromJson(Map<String, dynamic> json) {
    return UpdateOrderResponse(
      message: json['message'],
      order: UpdatedOrder.fromJson(json['order']),
    );
  }
}

class UpdatedOrder {
  final int id;
  final int userId;
  final double total;
  final String status;
  final double? rating;
  final int saleInvoiceId;
  final double shippingCost;
  final ShippingAddress shippingAddress;
  final String createdAt;
  final String updatedAt;

  UpdatedOrder({
    required this.id,
    required this.userId,
    required this.total,
    required this.status,
    this.rating,
    required this.saleInvoiceId,
    required this.shippingCost,
    required this.shippingAddress,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UpdatedOrder.fromJson(Map<String, dynamic> json) {
    return UpdatedOrder(
      id: json['id'],
      userId: json['user_id'],
      total: double.parse(json['total'].toString()),
      status: json['status'],
      rating: json['rating'] != null
          ? double.tryParse(json['rating'].toString())
          : null,
      saleInvoiceId: json['sale_invoice_id'],
      shippingCost: double.parse(json['shipping_cost'].toString()),
      shippingAddress: ShippingAddress.fromJson(json['shipping_address']),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
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
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
