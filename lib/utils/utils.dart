import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class Utils {
  BuildContext context;
  Utils(this.context);

  Size get getScreenSize => MediaQuery.of(context).size;
  //* get the current prefLocale
  String get getCurrentLocale =>
      Locales.currentLocale(context)!.languageCode.toUpperCase();
}
