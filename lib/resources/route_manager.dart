import 'package:egy_army_force/screens/add_item_screen.dart';
import 'package:egy_army_force/screens/all_items_screen.dart';
import 'package:egy_army_force/screens/fetch_data_screen.dart';
import 'package:egy_army_force/screens/menu_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import '../screens/item_details_screen.dart';
import 'string_manager.dart';

class Routes {
  static const String fetchDataRoute = '/FetchData';
  static const String menubarRoute = '/MenuBar';
  static const String addItemRoute = '/AddItem';
  static const String allItemsRoute = '/AllItems';
  static const String itemDetailsRoute = '/ItemDetails';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.fetchDataRoute:
        return MaterialPageRoute(
          builder: (_) => const FetchDataScreen(),
        );
      case Routes.menubarRoute:
        return MaterialPageRoute(
          builder: (_) => const MenuBarScreen(),
        );
      case Routes.addItemRoute:
        return MaterialPageRoute(
          builder: (_) => const AddItemScreen(),
        );
      case Routes.allItemsRoute:
        return MaterialPageRoute(
          builder: (_) => const AllItemsScreen(),
        );
      case Routes.itemDetailsRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ItemDetailsScreen(),
        );

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: LocaleText(
            AppString.noRouteFound,
          ),
        ),
      ),
    );
  }
}
