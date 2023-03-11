import '../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';
import '../providers/activities_provider.dart';
import '../resources/string_manager.dart';
import '../resources/values_manager.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/item_widget.dart';

class AllActivitiesScreen extends StatelessWidget {
  const AllActivitiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final activitiesProvider = Provider.of<ActivitiesProvider>(context);
    final activitiesList = activitiesProvider.getItems;
    return AppBarWidget(
      title: AppString.allActivities,
      body: activitiesList.isEmpty
          ? const Center(
              child: LocaleText(
                AppString.empty,
              ),
            )
          : GridView.builder(
              itemCount: activitiesList.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                  value: activitiesList[index],
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
    );
  }
}
