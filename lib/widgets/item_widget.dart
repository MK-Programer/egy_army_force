import '../../models/items_model.dart';
import '../../resources/route_manager.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../resources/color_manager.dart';
import '../resources/icon_manager.dart';
import '../resources/language_manager.dart';
import '../resources/values_manager.dart';
import '../utils/utils.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final itemModel = Provider.of<ItemModel>(context);
    String currentLang = Utils(context).getCurrentLocale;
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSize.s12),
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.itemDetailsRoute,
            arguments: itemModel.id,
          );
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s12),
              child: FancyShimmerImage(
                height: size.width * AppSize.s0_45,
                width: size.width * AppSize.s0_45,
                imageUrl: itemModel.imageUrl,
                errorWidget: Icon(
                  IconManager.iconDanger,
                  color: ColorManager.red,
                  size: AppSize.s20,
                ),
                boxFit: BoxFit.cover,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s12),
              child: Container(
                height: size.width * AppSize.s0_45,
                width: size.width * AppSize.s0_45,
                color: Colors.black38,
              ),
            ),
            Center(
              child: Text(
                currentLang == LanguageType.ENGLISH.getValue().toUpperCase()
                    ? itemModel.itemNameEN
                    : itemModel.itemNameAR,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: ColorManager.white,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
