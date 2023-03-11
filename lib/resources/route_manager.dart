import '../screens/add_item_screen.dart';
import '../screens/all_activities_screen.dart';
import '../screens/all_items_screen.dart';
import '../screens/fetch_data_screen.dart';
import '../screens/menu_bar_screen.dart';
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
  static const String viewAllActivitiesRoute = '/AllActivities';
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
          settings: settings,
          builder: (_) => const AllItemsScreen(),
        );
      case Routes.itemDetailsRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ItemDetailsScreen(),
        );
      case Routes.viewAllActivitiesRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const AllActivitiesScreen(),
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
