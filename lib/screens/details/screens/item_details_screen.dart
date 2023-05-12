import 'package:card_swiper/card_swiper.dart';
import 'package:egy_army_force/resources/route_manager.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
// import 'package:pinch_zoom_image_updated/pinch_zoom_image_updated.dart';
// import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import '../../../providers/activities_provider.dart';
import '../../../providers/items_provider.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/icon_manager.dart';
import '../../../resources/language_manager.dart';
import '../../../resources/values_manager.dart';
import '../../../utils/utils.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final map =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final itemId = map['itemId']!;
    final routeName = map['routeName'] ?? Routes.allItemsRoute;
    final dynamic itemProvider = routeName == Routes.allItemsRoute
        ? Provider.of<ItemsProvider>(context)
        : Provider.of<ActivitiesProvider>(context);
    final itemData = itemProvider.getItemById(id: itemId);
    String currentLang = Utils(context).getCurrentLocale;
    final Color color = Utils(context).color;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: size.height * AppMargin.m0_4,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          FancyShimmerImage(
                            imageUrl: itemData.imageUrl[index],
                            errorWidget: Icon(
                              IconManager.iconDanger,
                              color: ColorManager.red,
                              size: AppSize.s20,
                            ),
                            boxFit: BoxFit.fill,
                          ),
                        ],
                      );
                    },
                    autoplay: true,
                    duration: AppSize.s800.toInt(),
                    autoplayDelay: AppSize.s8000.toInt(),
                    itemCount: itemData.imageUrl.length,
                    pagination: SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: DotSwiperPaginationBuilder(
                        color: ColorManager.white,
                        activeColor: ColorManager.red,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppPadding.p30,
                    left: AppPadding.p12,
                  ),
                  child: BackButton(
                    color: ColorManager.red,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: AppMargin.m18,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: AppPadding.p15,
                right: AppPadding.p15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentLang == LanguageType.ENGLISH.getValue().toUpperCase()
                        ? itemData.itemNameEN
                        : itemData.itemNameAR,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: AppMargin.m10,
                  ),
                  Text(
                    currentLang == LanguageType.ENGLISH.getValue().toUpperCase()
                        ? itemData.itemDescriptionEN
                        : itemData.itemDescriptionAR,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
