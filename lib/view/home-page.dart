import 'package:flutter/material.dart';
import 'package:untitled27/view/profile%20view.dart';
import 'package:untitled27/view/viewcart%20view.dart';
import '../controller/profile serv.dart';
import '../controller/warehouse show.dart';
import '../l10n/homelan.dart';
import '../model/profile model.dart';
import '../model/warehouse show model.dart';
import '../token_storage.dart';
import 'category view.dart';
import 'log-in view.dart';
import 'package:badges/badges.dart' as badges;
import 'orders view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Profile? userProfile;
  bool isLoading = true;
  bool isWarehouseLoading = true;
  List<Warehouse> warehouses = [];

  final Color bluePrimary = const Color(0xFF1EC78C);
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadProfile();
    _loadWarehouses();
  }

  Future<void> _loadProfile() async {
    final profile = await ProfileController().fetchProfile();
    setState(() {
      userProfile = profile;
      isLoading = false;
    });
  }

  Future<void> _loadWarehouses() async {
    try {
      warehouses = await WarehouseController().getWarehouses();
    } catch (e) {
      print("خطأ في جلب المستودعات: $e");
    } finally {
      setState(() {
        isWarehouseLoading = false;
      });
    }
  }

  void _logout(BuildContext context) {
    globalToken = null;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const AuthPage()),
          (route) => false,
    );
  }

  void _changeLanguage(String lang) {
    setState(() {
      AppStrings.currentLang = lang;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 6,
        shadowColor: Colors.black26,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1EC78C), Color(0xFF18B88B)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          children: [
            const Icon(Icons.storefront, color: Colors.white, size: 26),
            const SizedBox(width: 10),
            Text(
              AppStrings.t('home'),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ViewCartPage()));
              },
              child: badges.Badge(
                position: badges.BadgePosition.topEnd(top: -6, end: -4),
                badgeContent: const Text('1', style: TextStyle(color: Colors.white, fontSize: 11)),
                badgeStyle: badges.BadgeStyle(
                  badgeColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  elevation: 4,
                ),
                child: const Icon(Icons.shopping_cart, size: 26),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            alignment: Alignment.center,
            color: Colors.white.withOpacity(0.2),
            height: 1,
          ),
        ),
      ),
      drawer: Drawer(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(userProfile?.name ?? "غير معروف", style: const TextStyle(fontSize: 20)),
              accountEmail: Text(userProfile?.email ?? "لا يوجد بريد", style: const TextStyle(fontSize: 16)),
              currentAccountPicture: const CircleAvatar(child: Icon(Icons.person, color: Colors.white)),
              decoration: BoxDecoration(color: bluePrimary),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(AppStrings.t('profile'), style: const TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileView()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(AppStrings.t('settings'), style: const TextStyle(fontSize: 20)),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(AppStrings.t('language'), style: const TextStyle(fontSize: 20)),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(AppStrings.t('language'), style: const TextStyle(fontSize: 20)),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: const Text('English', style: TextStyle(fontSize: 18)),
                            onTap: () {
                              _changeLanguage('en');
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: const Text('العربية', style: TextStyle(fontSize: 18)),
                            onTap: () {
                              _changeLanguage('ar');
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text(AppStrings.t('logout'), style: const TextStyle(fontSize: 20)),
              onTap: () => _logout(context),
            ),
          ],
        ),
      ),
      body: _getSelectedBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const ViewCartPage()));
          } else {
            setState(() {
              selectedIndex = index;
            });
          }
        },
        selectedItemColor: bluePrimary,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontSize: 20),
        unselectedLabelStyle: const TextStyle(fontSize: 20),
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home), label: AppStrings.t('home')),
          BottomNavigationBarItem(icon: const Icon(Icons.person), label: AppStrings.t('profile')),
          BottomNavigationBarItem(icon: const Icon(Icons.shopping_cart), label: AppStrings.t('cart')),
          BottomNavigationBarItem(icon: const Icon(Icons.receipt_long), label: AppStrings.t('orders')),
        ],
      ),
    );
  }

  Widget _getSelectedBody() {
    if (selectedIndex == 0) {
      return isWarehouseLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        itemCount: warehouses.length,
        itemBuilder: (context, index) {
          final w = warehouses[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: bluePrimary.withOpacity(0.25),
                  offset: const Offset(0, 8),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
              ],
              border: Border.all(color: bluePrimary.withOpacity(0.4), width: 1),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CategoryListPage(warehouseId: w.id)),
                  );
                },
                splashColor: bluePrimary.withOpacity(0.2),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: bluePrimary,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 28),
                      child: const Icon(Icons.warehouse, size: 60, color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      child: Column(
                        children: [
                          Text(
                            w.warehouseName,
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "📍 ${w.warehouseLocation}",
                            style: TextStyle(fontSize: 17, color: Colors.grey.shade700),
                            textAlign: TextAlign.center,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              margin: const EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                color: bluePrimary.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Icon(Icons.arrow_forward_ios,
                                  size: 20, color: bluePrimary.withOpacity(0.9)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else if (selectedIndex == 1) {
      return const ProfileView();
    } else if (selectedIndex == 3) {
      return const OrdersScreen();
    } else {
      return const SizedBox();
    }
  }
}
