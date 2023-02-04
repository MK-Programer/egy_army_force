import 'package:egy_army_force/providers/items_provider.dart';
import 'package:egy_army_force/resources/string_manager.dart';
import 'package:egy_army_force/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';
import '../resources/values_manager.dart';
import '../widgets/item_widget.dart';

class AllItemsScreen extends StatelessWidget {
  const AllItemsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final itemProvider = Provider.of<ItemsProvider>(context);
    final itemsList = itemProvider.getItems.reversed.toList();
    return Scaffold(
      body: itemsList.isEmpty
          ? const Center(
              child: LocaleText(
                AppString.empty,
              ),
            )
          : GridView.builder(
              itemCount: itemsList.length,
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
    );
  }
}
