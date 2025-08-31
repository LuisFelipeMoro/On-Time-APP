import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color.fromRGBO(6, 147, 227, 1); // HSL(200, 95%, 45%)
  static const primaryGlow = Color.fromRGBO(38, 169, 224, 1); // HSL(200, 95%, 55%)
  static const success = Color.fromRGBO(34, 139, 69, 1); // HSL(142, 76%, 36%)
  static const warning = Color.fromRGBO(245, 158, 11, 1); // HSL(38, 92%, 50%)
  static const background = Color.fromRGBO(241, 245, 249, 1); // HSL(220, 14%, 96%)
  static const cardBackground = Colors.white;
  static const textPrimary = Color.fromRGBO(51, 65, 85, 1); // HSL(215, 25%, 27%)
  static const textSecondary = Color.fromRGBO(100, 116, 139, 1);
  
  static const primaryGradient = LinearGradient(
    colors: [primary, primaryGlow],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}