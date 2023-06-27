import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

import '../../resources/values_manager.dart';

class BiographyWidget extends StatelessWidget {
  final int pointNumber;
  final String pointText;
  const BiographyWidget(
      {Key? key, required this.pointNumber, required this.pointText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$pointNumber - ',
        ),
        const SizedBox(
          width: AppMargin.m8,
        ),
        Expanded(
          child: LocaleText(
            pointText,
          ),
        ),
      ],
    );
  }
}
