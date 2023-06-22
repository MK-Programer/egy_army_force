import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import '../../../models/items_model.dart';
import '../../../providers/activities_provider.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/icon_manager.dart';
import '../../../resources/language_manager.dart';
import '../../../resources/route_manager.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/values_manager.dart';
import '../../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

import '../../../providers/items_provider.dart';
import '../../../widgets/item_widget.dart';
import '../../../widgets/swiper_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _imgCollector(ItemModel activity) {
    return activity.imageUrl[0];
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    String currentLang = Utils(context).getCurrentLocale;
    final itemProvider = Provider.of<ItemsProvider>(context);
    final activitiesProvider = Provider.of<ActivitiesProvider>(context);
    final itemsList = itemProvider.getItems.reversed.toList();
    final activitiesList = activitiesProvider.getItems;
    final activitiesImg =
        activitiesList.map((activity) => _imgCollector(activity)).toList();
    return ListView(
      children: [
        SizedBox(
          width: double.infinity,
          height: size.height * AppSize.s0_35,
          child: SwiperWidget(
            images: activitiesImg,
            type: 0,
          ),
        ),
        const SizedBox(
          height: AppMargin.m5,
        ),
        // TextButton(
        //   onPressed: () {
        //     Navigator.of(context).pushNamed(Routes.viewAllActivitiesRoute);
        //   },
        //   child: LocaleText(
        //     AppString.viewAll,
        //     style: Theme.of(context).textTheme.headlineMedium!.copyWith(
        //           fontWeight: FontWeightManager.normal,
        //         ),
        //   ),
        // ),
        Padding(
          padding:
              const EdgeInsets.only(left: AppPadding.p8, right: AppPadding.p8),
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
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const LocaleText(
                        AppString.all,
                      ),
                      Text("(${itemsList.length.toString()})"),
                    ],
                  ),
                ),
                // Container(
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     color: ColorManager.white,
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.all(AppPadding.p8),
                //     child: Icon(
                //       currentLang ==
                //               LanguageType.ENGLISH.getValue().toUpperCase()
                //           ? IconManager.arrowRight2Bold
                //           : IconManager.arrowLeft2Bold,
                //       color: Theme.of(context).iconTheme.color,
                //     ),
                //   ),
                // ),
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
        )
      ],
    );
  }
}
