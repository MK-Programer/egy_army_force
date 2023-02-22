import 'package:flutter/material.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/values_manager.dart';

class ThemeManager {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: isDarkTheme
          ? ColorManager.scaffoldDarkColor
          : ColorManager.scaffoldColor,
      appBarTheme: AppBarTheme(
        backgroundColor: isDarkTheme
            ? ColorManager.scaffoldDarkColor
            : ColorManager.scaffoldColor,
        titleTextStyle: TextStyle(
          color: isDarkTheme ? ColorManager.white : ColorManager.black,
          fontSize: FontSize.s24,
          fontWeight: FontWeightManager.bold,
        ),
        elevation: AppSize.s0,
      ),
      cardColor: isDarkTheme ? ColorManager.white : ColorManager.black,
      textTheme: TextTheme(
        titleMedium: TextStyle(
          color: isDarkTheme ? ColorManager.white : ColorManager.black,
          fontWeight: FontWeightManager.semiBold,
          fontSize: FontSize.s18,
        ),
        labelSmall: TextStyle(
          color: isDarkTheme ? ColorManager.white : ColorManager.black,
          fontWeight: FontWeightManager.bold,
          fontSize: FontSize.s20,
        ),
        headlineMedium: TextStyle(
          color: isDarkTheme ? ColorManager.white : ColorManager.black,
          fontWeight: FontWeightManager.bold,
          fontSize: FontSize.s20,
        ),
        bodyMedium: TextStyle(
          color: isDarkTheme ? ColorManager.white : ColorManager.black,
          fontWeight: FontWeightManager.normal,
          fontSize: FontSize.s18,
        ),
      ),
    );
  }
}
