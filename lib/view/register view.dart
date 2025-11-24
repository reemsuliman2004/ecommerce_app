import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controller/register serv.dart';
import '../l10n/homelan.dart'; // ✅ ملف الترجمة

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterController controller = RegisterController();
  bool isPasswordVisible = false;
  bool isCPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    const bluePrimary = Color(0xFF1EC78C);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  "assets/img_2.png",
                  height: 120,
                  width: 120,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                AppStrings.t('create_account'), // ✅ ترجمة
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: bluePrimary,
                ),
              ),
              const SizedBox(height: 15),

              _buildInputField(
                controller: controller.nameController,
                label: AppStrings.t('name'),
                icon: Icons.person,
                isPassword: false,
                bluePrimary: bluePrimary,
              ),

              _buildInputField(
                controller: controller.emailController,
                label: AppStrings.t('email'),
                icon: Icons.email,
                isPassword: false,
                bluePrimary: bluePrimary,
              ),

              _buildInputField(
                controller: controller.phoneController,
                label: AppStrings.t('phone'),
                icon: Icons.phone,
                isPassword: false,
                bluePrimary: bluePrimary,
              ),

              _buildInputField(
                controller: controller.passwordController,
                label: AppStrings.t('password'),
                icon: Icons.lock,
                isPassword: true,
                bluePrimary: bluePrimary,
              ),

              _buildInputField(
                controller: controller.cPasswordController,
                label: AppStrings.t('confirm_password'),
                icon: Icons.lock_outline,
                isPassword: true,
                bluePrimary: bluePrimary,
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.registerUser(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: bluePrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 3,
                  ),
                  child: Text(
                    AppStrings.t('register'),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    AppStrings.t('already_have_account'),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: bluePrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool isPassword,
    required Color bluePrimary,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword && !isPasswordVisible,
            cursorColor: bluePrimary,
            style: const TextStyle(fontSize: 18),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              prefixIcon: Icon(icon, color: bluePrimary),
              suffixIcon: isPassword
                  ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: bluePrimary,
                ),
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
              )
                  : null,
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
