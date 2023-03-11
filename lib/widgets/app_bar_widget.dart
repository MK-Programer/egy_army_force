import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../utils/utils.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  final Widget body;
  const AppBarWidget({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: color,
        ),
        title: LocaleText(
          title,
        ),
      ),
      body: body,
    );
  }
}
