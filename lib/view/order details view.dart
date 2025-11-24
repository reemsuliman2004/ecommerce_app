import 'package:flutter/material.dart';
import '../controller/order edit serv.dart';
import '../model/orders model.dart';
import '../l10n/homelan.dart'; // ✅ ملف الترجمة

class OrderDetailsScreen extends StatefulWidget {
  final OrderModel order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late OrderModel order;

  @override
  void initState() {
    super.initState();
    order = widget.order;
  }

  Future<void> _showEditDialog(int productId, int currentQuantity) async {
    final controller = TextEditingController(text: currentQuantity.toString());

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(AppStrings.t('edit_quantity'), style: const TextStyle(fontSize: 20)),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: AppStrings.t('new_quantity'),
            labelStyle: const TextStyle(fontSize: 18),
          ),
          style: const TextStyle(fontSize: 18),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppStrings.t('cancel'), style: const TextStyle(fontSize: 16)),
          ),
          ElevatedButton(
            onPressed: () async {
              final newQuantity =
                  int.tryParse(controller.text) ?? currentQuantity;

              final result = await OrderEditService().updateOrderItem(
                orderId: order.orderId,
                productId: productId,
                quantity: newQuantity,
              );

              Navigator.of(context).pop();

              if (result != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(result.message, style: const TextStyle(fontSize: 16))),
                );

                setState(() {
                  final itemIndex = order.items
                      .indexWhere((item) => item.productId == productId);
                  if (itemIndex != -1) {
                    order.items[itemIndex].quantity = newQuantity;
                  }
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1EC78C),
              foregroundColor: Colors.white,
            ),
            child: Text(AppStrings.t('save'), style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final latitude = order.shippingAddress?.latitude ?? "N/A";
    final longitude = order.shippingAddress?.longitude ?? "N/A";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${AppStrings.t('order_details')} #${order.orderId}",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1EC78C),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildOrderInfoRow(AppStrings.t('order_id'), order.orderId.toString()),
                _buildOrderInfoRow(AppStrings.t('status_label'), order.orderStatus),
                _buildOrderInfoRow(AppStrings.t('total_label'), "\$${order.total}"),
                _buildOrderInfoRow(AppStrings.t('rating'),
                    order.rating?.toString() ?? AppStrings.t('no_rating')),
                _buildOrderInfoRow(AppStrings.t('shipping_cost'), "\$${order.shippingCost}"),
                _buildOrderInfoRow(AppStrings.t('latitude'), latitude),
                _buildOrderInfoRow(AppStrings.t('longitude'), longitude),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            AppStrings.t('products_label'),
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...order.items.map(
                (item) => Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                title: Text(
                  item.productName ?? AppStrings.t('no_name'),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Text(
                  "${AppStrings.t('quantity_label')}: ${item.quantity}",
                  style: const TextStyle(fontSize: 16),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.edit, color: Color(0xFF1EC78C)),
                  onPressed: () {
                    _showEditDialog(item.productId, item.quantity);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
