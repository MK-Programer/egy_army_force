import 'package:card_swiper/card_swiper.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/icon_manager.dart';
import '../resources/img_manager.dart';
import '../resources/language_manager.dart';
import '../resources/route_manager.dart';
import '../resources/string_manager.dart';
import '../resources/values_manager.dart';
import '../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

import '../providers/items_provider.dart';
import '../widgets/item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _landingImages = [
    ImgManager.landing1,
    ImgManager.landing2,
    ImgManager.landing3,
    ImgManager.landing4,
  ];
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    String currentLang = Utils(context).getCurrentLocale;
    final itemProvider = Provider.of<ItemsProvider>(context);
    final itemsList = itemProvider.getItems.reversed.toList();
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: size.height * AppSize.s0_35,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Image.asset(
                _landingImages[index],
                fit: BoxFit.fill,
              );
            },
            autoplay: true,
            duration: AppSize.s800.toInt(),
            autoplayDelay: AppSize.s8000.toInt(),
            itemCount: _landingImages.length,
            pagination: SwiperPagination(
              alignment: Alignment.bottomCenter,
              builder: DotSwiperPaginationBuilder(
                color: ColorManager.white,
                activeColor: ColorManager.red,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: AppMargin.m5,
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.viewAllActivitiesRoute);
          },
          child: LocaleText(
            AppString.viewAll,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeightManager.normal,
                ),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p8, right: AppPadding.p8),
                child: Row(
                  children: [
                    LocaleText(
                      AppString.explore,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(fontWeight: FontWeightManager.normal),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(Routes.allItemsRoute);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorManager.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(AppPadding.p8),
                          child: Icon(
                            currentLang ==
                                    LanguageType.ENGLISH
                                        .getValue()
                                        .toUpperCase()
                                ? IconManager.arrowRight2Bold
                                : IconManager.arrowLeft2Bold,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: AppMargin.m5,
              ),
              GridView.builder(
                itemCount: itemsList.length > 4 ? 4 : itemsList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                    value: itemsList[index],
                    child: const ItemWidget(),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: AppSize.s2.toInt(),
                  crossAxisSpacing: AppMargin.m0,
                  mainAxisSpacing: AppMargin.m0,
                  childAspectRatio: size.width / (size.width * AppSize.s0_8),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
