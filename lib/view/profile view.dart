import 'package:flutter/material.dart';
import '../controller/profile serv.dart';
import '../model/profile model.dart';
import 'EditProfilePage.dart';
import '../l10n/homelan.dart'; // ✅ ملف الترجمة

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late Future<Profile?> profileFuture;
  final Color bluePrimary = const Color(0xFF012134);

  @override
  void initState() {
    super.initState();
    profileFuture = ProfileController().fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          AppStrings.t('profile'), // ✅ ترجمة
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EditProfilePage()),
              ).then((_) {
                setState(() {
                  profileFuture = ProfileController().fetchProfile();
                });
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<Profile?>(
        future: profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data != null) {
            final profile = snapshot.data!;
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [bluePrimary.withOpacity(0.7), Colors.blueAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 4,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildProfileBox(
                      icon: Icons.person,
                      title: AppStrings.t('name'),
                      value: profile.name,
                    ),
                    const SizedBox(height: 15),
                    _buildProfileBox(
                      icon: Icons.email,
                      title: AppStrings.t('email'),
                      value: profile.email,
                    ),
                    const SizedBox(height: 15),
                    _buildProfileBox(
                      icon: Icons.phone,
                      title: AppStrings.t('phone'),
                      value: profile.phone,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: Text(
              AppStrings.t('failed_load_profile'),
              style: const TextStyle(fontSize: 18),
            ));
          }
        },
      ),
    );
  }

  Widget _buildProfileBox({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 30, color: bluePrimary),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black54),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
