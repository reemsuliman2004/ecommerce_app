import 'package:flutter/material.dart';
import '../controller/order ser.dart';
import '../model/orders model.dart';
import 'InvoiceDetailsScreen.dart';
import 'order details view.dart';
import '../l10n/homelan.dart'; // ✅ ملف الترجمة

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late Future<List<OrderModel>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = OrderController().getOrders();
  }

  Future<void> _refreshOrders() async {
    setState(() {
      _ordersFuture = OrderController().getOrders();
    });
  }

  void _cancelOrderLocally(int orderId) {
    setState(() {
      _ordersFuture = _ordersFuture.then(
              (orders) => orders.where((order) => order.orderId != orderId).toList());
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppStrings.t('order_cancelled'), style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  Widget _buildOrderCard(OrderModel order, int index) {
    Color statusColor;
    switch (order.orderStatus) {
      case "مكتمل":
        statusColor = Colors.green;
        break;
      case "قيد التنفيذ":
        statusColor = Colors.orange;
        break;
      case "ملغي":
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 500 + index * 100),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.only(bottom: 16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [Colors.white, Colors.grey.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // العنوان
                Text(
                  "${AppStrings.t('order_number')}: ${order.orderId}",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1EC78C),
                  ),
                ),
                const SizedBox(height: 12),

                // التفاصيل مع أيقونات
                Row(
                  children: [
                    const Icon(Icons.info_outline, color: Colors.grey, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      "${AppStrings.t('status_label')}: ${order.orderStatus}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.attach_money, color: Colors.grey, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      "${AppStrings.t('total_label')}: ${order.total.toStringAsFixed(2)} ل.س",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.local_shipping, color: Colors.grey, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      "${AppStrings.t('shipping_cost_label')}: ${order.shippingCost.toStringAsFixed(2)} ل.س",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                Divider(color: Colors.grey.shade300, thickness: 1),
                const SizedBox(height: 10),

                // الأزرار
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                InvoiceDetailsScreen(invoice: order),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1EC78C),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                      ),
                      icon: const Icon(Icons.receipt_long, size: 18),
                      label: Text(AppStrings.t('invoice'), style: const TextStyle(fontSize: 16)),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OrderDetailsScreen(order: order),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF1EC78C),
                        side: const BorderSide(color: Color(0xFF1EC78C)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                      ),
                      icon: const Icon(Icons.arrow_forward_ios, size: 16),
                      label: Text(AppStrings.t('details'), style: const TextStyle(fontSize: 16)),
                    ),
                    const SizedBox(width: 10),
                    TextButton.icon(
                      onPressed: () {
                        _cancelOrderLocally(order.orderId);
                      },
                      icon: const Icon(Icons.cancel, color: Colors.red, size: 16),
                      label: Text(
                        AppStrings.t('cancel'),
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.t('my_orders'),
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1EC78C),
        foregroundColor: Colors.white,
        elevation: 3,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: FutureBuilder<List<OrderModel>>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                AppStrings.t('error_loading_orders'),
                style: const TextStyle(fontSize: 16),
              ),
            );
          }

          final orders = snapshot.data ?? [];

          if (orders.isEmpty) {
            return Center(
              child: Text(
                AppStrings.t('no_orders'),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _refreshOrders,
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return _buildOrderCard(orders[index], index);
              },
            ),
          );
        },
      ),
    );
  }
}
