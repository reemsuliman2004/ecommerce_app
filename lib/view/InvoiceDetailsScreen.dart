import 'package:flutter/material.dart';
import '../model/orders model.dart';
import '../l10n/homelan.dart'; // ✅ ملف الترجمة

class InvoiceDetailsScreen extends StatelessWidget {
  final OrderModel invoice;

  const InvoiceDetailsScreen({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${AppStrings.t('invoice')} #${invoice.orderId}", // ✅ ترجمة
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1EC78C),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- معلومات أساسية عن الفاتورة ---
            Text(
              "${AppStrings.t('status_label')}: ${invoice.orderStatus}",
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              "${AppStrings.t('total_label')}: ${invoice.total}",
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              "${AppStrings.t('shipping_cost')}: ${invoice.shippingCost}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),

            Text(
              AppStrings.t('items'),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // --- عرض العناصر ---
            Expanded(
              child: ListView.builder(
                itemCount: invoice.items.length,
                itemBuilder: (context, index) {
                  final item = invoice.items[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: const Icon(Icons.shopping_cart, color: Color(0xFF1EC78C)),
                      title: Text(
                        item.productName ?? AppStrings.t('no_name'), // ✅ ترجمة
                        style: const TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(
                        "${AppStrings.t('quantity_label')}: ${item.quantity} • ${AppStrings.t('price')}: ${item.price}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      trailing: Text(
                        "${AppStrings.t('total_label')}: ${item.total}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
