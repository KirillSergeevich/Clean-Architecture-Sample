import 'package:flutter/material.dart';
import 'package:todo/presentation/theme/app_theme.dart';
import 'package:todo/presentation/utils/app_colors.dart';
import 'package:todo/presentation/utils/app_text_styles.dart';

final darkTheme = AppTheme(
  primaryBackgroundColor: AppColors.black,
  primaryTextColor: AppColors.white,
  primaryIconColor: AppColors.white,
  blurColor: AppColors.white.withOpacity(0.6),
  darkIconColor: AppColors.black,
  darkTextColor: AppColors.black,
  dividerColor: AppColors.grey,
  listTileColor: AppColors.blue,
  bottomSheetColor: AppColors.lightGrey,
  materialTheme: ThemeData(
    textTheme: const TextTheme(
      headline1: TextStyle(color: AppColors.white),
    ),
  ),
  primaryTextStyle: AppTextStyles.primary,
  darkTextStyle: AppTextStyles.dark,
);

final lightTheme = AppTheme(
  primaryBackgroundColor: AppColors.white,
  primaryTextColor: AppColors.white,
  primaryIconColor: AppColors.white,
  blurColor: AppColors.white.withOpacity(0.6),
  darkIconColor: AppColors.black,
  darkTextColor: AppColors.black,
  dividerColor: AppColors.grey,
  listTileColor: AppColors.blue,
  bottomSheetColor: AppColors.lightGrey,
  materialTheme: ThemeData(
    textTheme: const TextTheme(
      headline1: TextStyle(color: AppColors.white),
    ),
  ),
  primaryTextStyle: AppTextStyles.primary,
  darkTextStyle: AppTextStyles.dark,
);
