import 'package:flutter/cupertino.dart';

class AppVersionModel with ChangeNotifier {
  final String version;
  final String appUrl;

  AppVersionModel({
    required this.version,
    required this.appUrl,
  });
}
