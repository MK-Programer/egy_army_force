import 'package:egy_army_force/resources/icon_manager.dart';
import 'package:egy_army_force/resources/string_manager.dart';
import 'package:egy_army_force/screens/about_us_screen.dart';
import 'package:egy_army_force/screens/home_screen.dart';
import 'package:egy_army_force/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'add_item_screen.dart';
import 'all_items_screen.dart';

class MenuBarScreen extends StatefulWidget {
  const MenuBarScreen({Key? key}) : super(key: key);

  @override
  State<MenuBarScreen> createState() => _MenuBarScreenState();
}

class _MenuBarScreenState extends State<MenuBarScreen> {
  final List<Map<String, dynamic>> _pages = [
    {
      'title': AppString.home,
      'body': const HomeScreen(),
    },
    // {
    //   'title': AppString.addPlane,
    //   'body': const AddItemScreen(),
    // },
    {
      'title': AppString.settings,
      'body': const SettingsScreen(),
    },
    {
      'title': AppString.aboutUs,
      'body': const AboutUsScreen(),
    },
  ];

  int _selectedIndex = 0;

  void _selectedPage(int index) {
    setState(
      () {
        _selectedIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: LocaleText(
          _pages[_selectedIndex]['title'],
        ),
      ),
      body: _pages[_selectedIndex]['body'],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: _selectedPage,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(IconManager.home),
            label: AppString.allPlanes.localize(context),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(IconManager.plane),
          //   label: AppString.addPlane.localize(context),
          // ),
          BottomNavigationBarItem(
            icon: Icon(IconManager.settings),
            label: AppString.settings.localize(context),
          ),
          BottomNavigationBarItem(
            icon: Icon(IconManager.aboutUs),
            label: AppString.aboutUs.localize(context),
          ),
        ],
      ),
    );
  }
}
