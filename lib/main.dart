import 'package:flutter/material.dart';
import 'package:untitled27/view/IntroScreen.dart';
import 'package:untitled27/view/log-in view.dart';
import 'l10n/homelan.dart';
// استورد شاشة الانترو

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // هذه الدالة لإعادة بناء التطبيق عند تغيير اللغة
  void changeLanguage(String lang) {
    setState(() {
      AppStrings.currentLang = lang;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      // ✅ أول صفحة رح تكون الانترو
      home: const IntroScreen(),
    );
  }
}
