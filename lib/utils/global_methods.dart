import 'package:egy_army_force/resources/font_manager.dart';
import 'package:egy_army_force/resources/img_manager.dart';
import 'package:egy_army_force/resources/string_manager.dart';
import 'package:egy_army_force/resources/values_manager.dart';
import 'package:flutter/material.dart';

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
              const Text(AppString.anErrorOccured),
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
              child: const Text(
                'Ok',
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
