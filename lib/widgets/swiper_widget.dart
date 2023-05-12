import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/icon_manager.dart';
import '../resources/values_manager.dart';

class SwiperWidget extends StatelessWidget {
  List<dynamic> images;
  int type;
  SwiperWidget({Key? key, required this.images, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          fit: StackFit.expand,
          children: [
            FancyShimmerImage(
              imageUrl: images[index],
              errorWidget: Icon(
                IconManager.iconDanger,
                color: ColorManager.red,
                size: AppSize.s20,
              ),
              boxFit: BoxFit.cover,
            ),
          ],
        );
      },
      autoplay: true,
      duration: AppSize.s800.toInt(),
      autoplayDelay: AppSize.s8000.toInt(),
      itemCount:
          type == 0 ? (images.length > 4 ? 4 : images.length) : images.length,
      pagination: SwiperPagination(
        alignment: Alignment.bottomCenter,
        builder: DotSwiperPaginationBuilder(
          color: ColorManager.white,
          activeColor: ColorManager.red,
        ),
      ),
    );
  }
}
