import 'package:flutter/material.dart';
import '../controller/category serv.dart';
import '../model/category model.dart';
import '../l10n/homelan.dart';   // ✅ استدعاء ملف الترجمة
import 'ProductListPage.dart';

class CategoryListPage extends StatefulWidget {
  final int warehouseId;

  const CategoryListPage({super.key, required this.warehouseId});

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  final CategoryController _controller = CategoryController();
  late Future<List<CategoryModel>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = _controller.getCategoriesByWarehouse(widget.warehouseId);
  }

  @override
  Widget build(BuildContext context) {
    const bluePrimary = Color(0xFF1EC78C);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bluePrimary,
        title: Text(
          AppStrings.t('categories_title'), // ✅ من ملف الترجمة
          style: const TextStyle(
            fontSize: 22,  // نفس حجم العناوين في شاشة تسجيل الدخول
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder<List<CategoryModel>>(
        future: _categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "${AppStrings.t('error')}: ${snapshot.error}",
                style: const TextStyle(fontSize: 16), // نفس حجم النصوص
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                AppStrings.t('no_categories'),
                style: const TextStyle(fontSize: 16), // نفس حجم النصوص
              ),
            );
          }

          final categories = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: bluePrimary.withOpacity(0.3),
                      offset: const Offset(0, 8),
                      blurRadius: 5,
                    ),
                  ],
                  border: Border.all(
                      color: bluePrimary.withOpacity(0.4),
                      width: 1),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(24),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductsScreen(
                            warehouseId: widget.warehouseId,
                            initialCategoryId: category.id,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: bluePrimary,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.all(14),
                            child: const Icon(Icons.category,
                                size: 28, color: Colors.white),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              "${category.categoryName} (WH: ${category.pivot.warehouseId})",
                              style: const TextStyle(
                                fontSize: 16,  // نفس حجم النصوص في شاشة تسجيل الدخول
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios,
                              size: 16, color: Colors.grey), // أصغر قليلاً لتناسب النص
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
