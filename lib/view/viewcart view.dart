import 'package:flutter/material.dart';
import '../controller/UpdateCart Serv.dart';
import '../controller/chekout serv.dart';
import '../controller/viewcart.dart';
import '../model/viewcart.dart';
import '../l10n/homelan.dart'; // ملف الترجمة

class ViewCartPage extends StatefulWidget {
  const ViewCartPage({super.key});

  @override
  State<ViewCartPage> createState() => _ViewCartPageState();
}

class _ViewCartPageState extends State<ViewCartPage> {
  List<Viewcart> cartItems = [];
  bool isLoading = true;
  Map<String, dynamic>? checkoutResult;

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    try {
      final items = await ViewCartService().getCartItems();
      setState(() {
        cartItems = items;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("❌ Error loading cart: $e");
    }
  }

  Future<void> _performCheckout() async {
    Map<String, Map<String, double>> syrianGovernorates = {
      'دمشق': {'lat': 33.5138, 'lng': 36.2765},
      'ريف دمشق': {'lat': 33.4897, 'lng': 36.3036},
      'حلب': {'lat': 36.2021, 'lng': 37.1343},
      'حماة': {'lat': 35.1318, 'lng': 36.7578},
      'اللاذقية': {'lat': 35.5316, 'lng': 35.7831},
      'حمص': {'lat': 34.7315, 'lng': 36.7137},
    };

    String? selectedGovernorate;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'اختر المحافظة',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: syrianGovernorates.keys.map((governorate) {
              return ListTile(
                title: Text(
                  governorate,
                  style: const TextStyle(fontSize: 18),
                ),
                onTap: () {
                  selectedGovernorate = governorate;
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        ),
      ),
    );

    if (selectedGovernorate == null) return;

    final lat = syrianGovernorates[selectedGovernorate]!['lat']!;
    final lng = syrianGovernorates[selectedGovernorate]!['lng']!;

    try {
      final response = await CheckoutService().checkout(lat: lat, lng: lng);

      if (response['success'] == true) {
        setState(() {
          checkoutResult = response['data'];
          cartItems = [];
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppStrings.t('checkout_success'))),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response['message'] ?? AppStrings.t('checkout_fail')),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${AppStrings.t('checkout_error')}: $e')),
      );
    }
  }

  void _showEditQuantitySheet(Viewcart item) {
    final TextEditingController quantityController =
    TextEditingController(text: item.quantity.toString());

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${AppStrings.t('edit_quantity_for')} ${item.product.productName}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 18),
              decoration: InputDecoration(
                labelText: AppStrings.t('new_quantity'),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1EC78C),
              ),
              onPressed: () async {
                int newQuantity =
                    int.tryParse(quantityController.text) ?? item.quantity;

                final result = await UpdateCartService().updateCartItem(
                  productId: item.product.id,
                  quantity: newQuantity,
                );

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(result)),
                );

                await _loadCartItems();
              },
              child: Text(
                AppStrings.t('update'),
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double get totalPrice {
    double total = 0;
    for (var item in cartItems) {
      total += item.quantity * double.parse(item.product.price);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          AppStrings.t('cart_title'),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF333333)),
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(color: Color(0xFF1EC78C)),
      )
          : cartItems.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_cart_outlined,
                size: 64, color: Colors.grey),
            const SizedBox(height: 12),
            Text(
              AppStrings.t('cart_empty'),
              style:
              const TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: cartItems.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final item = cartItems[index];
                final product = item.product;

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: product.imgUrl != null
                            ? Image.network(
                          product.imgUrl!,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        )
                            : Container(
                          width: 60,
                          height: 60,
                          color: const Color(0xFF1EC78C),
                          child: const Icon(
                            Icons.image_not_supported,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.productName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${AppStrings.t('quantity_label')}: ${item.quantity}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              '${AppStrings.t('price_label')}: ${product.price} ل.س',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit,
                            color: Colors.orange),
                        onPressed: () => _showEditQuantitySheet(item),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.t('total_label'),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${totalPrice.toStringAsFixed(2)} ل.س',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _performCheckout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1EC78C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      AppStrings.t('checkout'),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
