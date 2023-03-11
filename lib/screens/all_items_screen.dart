import '../widgets/app_bar_widget.dart';

import '../models/items_model.dart';
import '../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';
import '../providers/items_provider.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/string_manager.dart';
import '../resources/values_manager.dart';
import '../widgets/item_widget.dart';

class AllItemsScreen extends StatefulWidget {
  const AllItemsScreen({Key? key}) : super(key: key);

  @override
  State<AllItemsScreen> createState() => _AllItemsScreenState();
}

class _AllItemsScreenState extends State<AllItemsScreen> {
  final TextEditingController _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  List<ItemModel> _itemProductSearch = [];
  @override
  void dispose() {
    _searchTextController.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;

    final itemProvider = Provider.of<ItemsProvider>(context);
    final itemsList = itemProvider.getItems.reversed.toList();
    return AppBarWidget(
      title: AppString.allPlanes,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: TextField(
              focusNode: _searchTextFocusNode,
              controller: _searchTextController,
              onChanged: (value) {
                setState(
                  () {
                    _itemProductSearch =
                        itemProvider.searchQuery(value, context);
                    print(_itemProductSearch);
                  },
                );
              },
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12),
                  borderSide: const BorderSide(
                    color: Colors.greenAccent,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12),
                  borderSide: const BorderSide(
                    color: Colors.greenAccent,
                    width: 1,
                  ),
                ),
                hintText: AppString.search.localize(context),
                hintStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                      fontSize: FontSize.s20,
                      fontWeight: FontWeight.normal,
                    ),
                prefixIcon: Icon(
                  Icons.search,
                  color: color,
                ),
                suffixIcon: Visibility(
                  visible: _searchTextFocusNode.hasFocus ? true : false,
                  child: IconButton(
                    onPressed: () {
                      _searchTextController.clear();
                      _searchTextFocusNode.unfocus();
                    },
                    icon: Icon(
                      Icons.close,
                      color: _searchTextFocusNode.hasFocus
                          ? ColorManager.red
                          : color,
                    ),
                  ),
                ),
              ),
            ),
          ),
          _searchTextController.text.isNotEmpty && _itemProductSearch.isEmpty
              ? const Center(
                  child: Text(
                    'No products found, please try another keyword',
                  ),
                )
              : itemsList.isEmpty
                  ? const Center(
                      child: LocaleText(
                        AppString.empty,
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _searchTextController.text.isNotEmpty
                          ? _itemProductSearch.length
                          : itemsList.length,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                          value: _searchTextController.text.isNotEmpty
                              ? _itemProductSearch[index]
                              : itemsList[index],
                          child: const ItemWidget(),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: AppSize.s2.toInt(),
                        crossAxisSpacing: AppMargin.m0,
                        mainAxisSpacing: AppMargin.m0,
                        childAspectRatio:
                            size.width / (size.width * AppSize.s0_8),
                      ),
                    ),
        ],
      ),
    );
  }
}
