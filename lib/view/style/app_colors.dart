import 'package:flutter/material.dart';

class AppColors {
  // الألوان الأساسية
  static const Color primary = Color(0xFF088395); // الأخضر الأساسي
  // static const Color primaryDark = Color(0xFF388E3C);
  // static const Color primaryLight = Color(0xFFC8E6C9);

  // ألوان النص
  static const Color title = Color(0xFFEDECEC);
  static const Color textPrimary = Color(0xFF373737);
  static const Color textSecondary = Color(0xFF8F8D7D);
  static const Color orange = Color(0xFFF4862C);
  static const Color green = Color(0xFFF61933E);
  // static const Color textOnPrimary = Color(0xFFFFFFFF);

  // ألوان الخلفية
  static const Color background = Color(0xFFF3ECF2);
  // static const Color surface = Color(0xFFFFFFFF);
  // static const Color error = Color(0xFFD32F2F);

  static const Color containerPrimary = Color(0xFF9FCAD7);
  static const Color containerSecondary = Color(0xFFFFFFFF);

  // // ألوان إضافية من التصميم
  // static const Color accent = Color(0xFF607D8B); // أزرق رمادي
  // static const Color divider = Color(0xFFBDBDBD);
  //
  // // ألوان خاصة بالتطبيق
  // static const Color recitation = Color(0xFF2196F3); // أزرق للتسميع
  // static const Color memorization = Color(0xFF673AB7); // بنفسجي للحفظ
  // static const Color review = Color(0xFFFF9800); // برتقالي للمراجعة

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color(0xFFFFFFFF), // أبيض
      Color(0xFFE2E2E2), // رمادي فاتح
      Color(0xFFFFFFFF), // أبيض
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
