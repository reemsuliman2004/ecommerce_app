import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled27/view/log-in view.dart'; // مكان صفحة AuthPage

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    // مدة الحركة
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // شفافية (Fade)
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    // تكبير (Scale)
    _scale = Tween<double>(begin: 0.7, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // بعد ما تخلص الأنيميشن → يروح عاللوجين
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => AuthPage(
              onLanguageChanged: (lang) {}, // مرر دالة فارغة مبدئياً
            ),
          ),
        );
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // خلفية بيضاء تناسب اللوجو
      body: Center(
        child: FadeTransition(
          opacity: _fade,
          child: ScaleTransition(
            scale: _scale,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // اللوجو
                Image.asset(
                  'assets/logo .png', // تأكد أنه بدون مسافة بالاسم
                  width: 180,
                  height: 180,
                ),
                const SizedBox(height: 20),
                // اسم التطبيق مع Gradient
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.green, Colors.blue],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ).createShader(bounds),
                  child: Text(
                    "WareShop",
                    style: const TextStyle(
                      fontFamily: 'JosefinSans', // اسم الخط اللي ضفته بال pubspec.yaml
                      fontSize: 50,              // كبرته أكتر
                      fontWeight: FontWeight.w900, // أثخن وزن (Black)
                      color: Colors.white,
                      letterSpacing: 3,          // زيادة المسافة بين الأحرف
                    ),
                  ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
