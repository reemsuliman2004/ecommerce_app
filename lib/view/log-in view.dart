import 'package:flutter/material.dart';
import 'package:untitled27/view/register%20view.dart';
import '../controller/log-in serv.dart';
import '../l10n/homelan.dart';
import '../model/log-in model.dart';
import 'home-page.dart';

class AuthPage extends StatefulWidget {
  final void Function(String lang)? onLanguageChanged;

  const AuthPage({super.key, this.onLanguageChanged});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = AuthController();

  bool isPasswordVisible = false;
  bool isLoading = false;
  String? errorMessage;

  // تسجيل الدخول
  void _handleLogin() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    User user = User(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    try {
      String? token = await authController.login(user);

      if (token != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppStrings.t('login_success')),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      } else {
        setState(() {
          errorMessage = AppStrings.t('login_fail');
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = AppStrings.t('login_error');
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // تغيير اللغة
  void _changeLanguage(String lang) {
    setState(() {
      AppStrings.currentLang = lang;
    });
    if (widget.onLanguageChanged != null) {
      widget.onLanguageChanged!(lang);
    }
  }

  @override
  Widget build(BuildContext context) {
    const bluePrimary = Color(0xFF1EC78C);

    return Scaffold(
      backgroundColor: bluePrimary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورة الشعار أعلى الشاشة
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 15),
            child: Center(
              child: Image.asset(
                "assets/img.png",
                height: 220,
                width: 1200,
              ),
            ),
          ),

          // الحاوية البيضاء
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // زر تغيير اللغة
                    Align(
                      alignment: Alignment.centerRight,
                      child: PopupMenuButton<String>(
                        icon: const Icon(Icons.language, color: bluePrimary),
                        onSelected: _changeLanguage,
                        itemBuilder: (context) => [
                          const PopupMenuItem(value: 'en', child: Text('English')),
                          const PopupMenuItem(value: 'ar', child: Text('العربية')),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        AppStrings.t('welcome'),
                        style: TextStyle(
                          color: bluePrimary,
                          fontSize: 22, // مناسب لشاشات الهواتف
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // حقل البريد الإلكتروني
                    _buildInputField(
                      controller: emailController,
                      label: AppStrings.t('email'),
                      icon: Icons.email,
                      isPassword: false,
                      bluePrimary: bluePrimary,
                    ),
                    const SizedBox(height: 20),

                    // حقل كلمة المرور
                    _buildInputField(
                      controller: passwordController,
                      label: AppStrings.t('password'),
                      icon: Icons.lock,
                      isPassword: true,
                      bluePrimary: bluePrimary,
                    ),
                    const SizedBox(height: 10),

                    // رابط نسيت كلمة المرور
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          AppStrings.t('forgot'),
                          style: TextStyle(
                            color: bluePrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: 16, // مناسب
                          ),
                        ),
                      ),
                    ),

                    // رسالة الخطأ
                    if (errorMessage != null)
                      Container(
                        margin: const EdgeInsets.only(top: 8, bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.red.shade200),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.error_outline, color: Colors.red),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                errorMessage!,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 10),

                    // زر تسجيل الدخول
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: bluePrimary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: isLoading
                            ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                            : Text(
                          AppStrings.t('login'),
                          style: const TextStyle(
                            fontSize: 18, // مناسب للشاشة
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // رابط التسجيل
                    Text(
                      AppStrings.t('dont_have_account'),
                      style: TextStyle(
                        fontSize: 16, // مناسب
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => RegisterView()),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: BorderSide(color: bluePrimary, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          AppStrings.t('signup'),
                          style: TextStyle(
                            fontSize: 18, // مناسب
                            fontWeight: FontWeight.bold,
                            color: bluePrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // دالة إنشاء الحقول
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
        Text(label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16, // مناسب
              color: Colors.grey.shade800,
            )),
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
            style: const TextStyle(fontSize: 16), // مناسب
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
      ],
    );
  }
}
