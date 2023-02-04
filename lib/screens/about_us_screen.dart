import 'package:egy_army_force/resources/img_manager.dart';
import 'package:egy_army_force/resources/string_manager.dart';
import 'package:egy_army_force/resources/values_manager.dart';
import 'package:egy_army_force/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return ListView(
      children: [
        Container(
          width: double.infinity,
          height: size.height * AppSize.s0_45,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                ImgManager.aboutUsImg,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: AppMargin.m8,
        ),
        const Padding(
          padding: EdgeInsets.all(AppPadding.p12),
          child: LocaleText(
            AppString.aboutUsDescription,
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
