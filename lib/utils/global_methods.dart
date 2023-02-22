import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../resources/font_manager.dart';
import '../resources/img_manager.dart';
import '../resources/string_manager.dart';
import '../resources/values_manager.dart';

class GlobalMethods {
  static Future<void> errorDialog({
    required String subTitle,
    required BuildContext context,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Image.asset(
                ImgManager.warningImg,
                height: AppMargin.m20,
                width: AppMargin.m20,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                width: AppMargin.m10,
              ),
              const LocaleText(AppString.anErrorOccured),
            ],
          ),
          content: Text(subTitle),
          actions: [
            TextButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: const LocaleText(
                AppString.ok,
                style: TextStyle(
                  color: Colors.cyan,
                  fontSize: FontSize.s18,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
