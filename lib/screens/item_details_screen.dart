import 'package:egy_army_force/resources/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/activities_provider.dart';
import '../providers/items_provider.dart';
import '../resources/language_manager.dart';
import '../resources/values_manager.dart';
import '../utils/utils.dart';

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
                Container(
                  height: size.height * AppMargin.m0_4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s5),
                    image: DecorationImage(
                      image: NetworkImage(
                        itemData.imageUrl,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppPadding.p30,
                    left: AppPadding.p12,
                  ),
                  child: BackButton(
                    color: color,
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
                    textAlign: TextAlign.justify,
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
