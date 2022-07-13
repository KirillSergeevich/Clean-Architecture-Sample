import 'package:flutter/material.dart';
import 'package:todo/presentation/utils/app_colors.dart';
import 'package:todo/presentation/utils/app_fonts.dart';

class AppTextStyles {
  static const TextStyle primary = TextStyle(
    color: AppColors.white,
    fontFamily: AppFonts.mainFontFamily,
    fontSize: AppFonts.sizeM,
  );
  static const TextStyle dark = TextStyle(
    color: AppColors.black,
    fontFamily: AppFonts.mainFontFamily,
    fontSize: AppFonts.sizeM,
  );
}
