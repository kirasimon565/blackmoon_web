import 'package:flutter/material.dart';

class AppColors {
  // خلفية أكثر عمقاً وسواداً لتشبه أسلوب إيفربايت الغامض
  static const Color background = Color(0xFF000000); 
  static const Color backgroundSecondary = Color(0xFF05080C);

  // نصوص بتباين عالٍ ووضوح ممتاز فوق الخلفية السوداء
  static const Color textPrimary = Color(0xFFFFFFFF); // أبيض نقي للعناوين
  static const Color textSecondary = Color(0xFF9AA4AF); // رمادي للنصوص الفرعية

  // اللون الأزرق السماوي المشع (Neon) الخاص بـ Moonvale Tracker
  static const Color accent = Color(0xFF50B5D8); 

  // ألوان مخصصة للتتبع (Tracker) بلمسة احترافية
  static const Color trackerBackground = Color(0xFF111418); // خلفية الأشرطة الباهتة
  static const Color trackerGlow = Color(0x6650B5D8); // لون التوهج (Glow) للشريط
}
