import 'package:flutter/material.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/values_manager.dart';

class ThemeManager {
  static ThemeData themeData() {
    return ThemeData(
      scaffoldBackgroundColor: ColorManager.scaffoldColor,
      appBarTheme: AppBarTheme(
        backgroundColor: ColorManager.white,
        titleTextStyle: TextStyle(
          color: ColorManager.black,
          fontSize: FontSize.s24,
          fontWeight: FontWeightManager.bold,
        ),
        elevation: AppSize.s0,
      ),
      cardColor: ColorManager.white,
      textTheme: TextTheme(
        titleMedium: TextStyle(
          color: ColorManager.black,
          fontWeight: FontWeightManager.semiBold,
          fontSize: FontSize.s18,
        ),
        labelSmall: TextStyle(
          color: ColorManager.black,
          fontWeight: FontWeightManager.bold,
          fontSize: FontSize.s20,
        ),
        headlineMedium: TextStyle(
          color: ColorManager.black,
          fontWeight: FontWeightManager.bold,
          fontSize: FontSize.s20,
        ),
        bodyMedium: TextStyle(
          color: ColorManager.black,
          fontWeight: FontWeightManager.normal,
          fontSize: FontSize.s18,
        ),
      ),
    );
  }
}
