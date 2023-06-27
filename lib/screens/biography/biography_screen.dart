import 'package:flutter_locales/flutter_locales.dart';

import '../../../resources/string_manager.dart';
import '../../../resources/values_manager.dart';
import '../../../utils/utils.dart';
import 'package:flutter/material.dart';

import '../../resources/img_manager.dart';
import 'biography_widget.dart';

class BiographyScreen extends StatelessWidget {
  const BiographyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final List<String> pointsTitle1 = [
      'point1x1',
      'point1x2',
      'point1x3',
      'point1x4',
      'point1x5'
    ];

    final List<String> pointsTitle2 = [
      'point2x1',
      'point2x2',
      'point2x3',
      'point2x4',
      'point2x5',
      'point2x6',
      'point2x7',
    ];

    final List<String> pointsTitle3 = [
      'point3x1',
      'point3x2',
      'point3x3',
      'point3x4',
      'point3x5',
      'point3x6',
      'point3x7',
      'point3x8',
      'point3x9',
      'point3x10',
      'point3x11',
    ];

    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: ListView(
        children: [
          Container(
            width: double.infinity,
            height: size.height * AppSize.s0_35,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  ImgManager.biography,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: AppMargin.m8,
          ),
          LocaleText(
            AppString.title1,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          for (int i = 0; i < pointsTitle1.length; i++)
            Padding(
              padding: const EdgeInsets.only(left: AppPadding.p8),
              child: BiographyWidget(
                  pointNumber: i + 1, pointText: pointsTitle1[i]),
            ),
          const SizedBox(
            height: AppMargin.m8,
          ),
          LocaleText(
            AppString.title2,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          for (int i = 0; i < pointsTitle2.length; i++)
            Padding(
              padding: const EdgeInsets.only(left: AppPadding.p8),
              child: BiographyWidget(
                  pointNumber: i + 1, pointText: pointsTitle2[i]),
            ),
          const SizedBox(
            height: AppMargin.m8,
          ),
          LocaleText(
            AppString.title3,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          for (int i = 0; i < pointsTitle3.length; i++)
            Padding(
              padding: const EdgeInsets.only(left: AppPadding.p8),
              child: BiographyWidget(
                  pointNumber: i + 1, pointText: pointsTitle3[i]),
            ),
        ],
      ),
    );
  }
}
