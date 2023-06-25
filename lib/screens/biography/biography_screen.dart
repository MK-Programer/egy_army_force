import 'package:flutter_locales/flutter_locales.dart';

import '../../../resources/string_manager.dart';
import '../../../resources/values_manager.dart';
import '../../../utils/utils.dart';
import 'package:flutter/material.dart';

import '../../resources/img_manager.dart';

class BiographyScreen extends StatelessWidget {
  const BiographyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return ListView(
      children: [
        Container(
          width: double.infinity,
          height: size.height * AppSize.s0_35,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                ImgManager.history,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: AppMargin.m8,
        ),
        const Padding(
          padding: EdgeInsets.all(AppPadding.p12),
          child: LocaleText(
            AppString.historyDescription,
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
