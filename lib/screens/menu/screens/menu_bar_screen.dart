import '../../../resources/audio_manager.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/icon_manager.dart';
import '../../../resources/string_manager.dart';
import '../../about_us/screens/about_us_screen.dart';
import '../../activities/screens/add_activities_screen.dart';
import '../../home/screens/home_screen.dart';
import '../../items/screens/add_item_screen.dart';
import '../../settings/screens/settings_screen.dart';
import '../../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class MenuBarScreen extends StatefulWidget {
  const MenuBarScreen({Key? key}) : super(key: key);

  @override
  State<MenuBarScreen> createState() => _MenuBarScreenState();
}

class _MenuBarScreenState extends State<MenuBarScreen> {
  final AudioPlayer? _player = AudioPlayer();
  bool _isPlayed = true;

  @override
  void initState() {
    _play();
    super.initState();
  }

  void _play() {
    _player?.play(AssetSource(AudioManager.bgAudio));
  }

  void _pause() {
    _player?.pause();
  }

  void _checkStatus() {
    if (_isPlayed) {
      _isPlayed = false;
      _pause();
    } else {
      _isPlayed = true;
      _play();
    }
    setState(() {});
  }

  final List<Map<String, dynamic>> _pages = [
    {
      'title': AppString.home,
      'body': const HomeScreen(),
    },
    // {
    //   'title': AppString.addPlane,
    //   'body': const AddItemScreen(),
    // },
    // {
    //   'title': AppString.addActivity,
    //   'body': const AddActivitiesScreen(),
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
    bool isDark = Utils(context).getTheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: LocaleText(
          _pages[_selectedIndex]['title'],
        ),
      ),
      body: _pages[_selectedIndex]['body'],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: isDark ? ColorManager.white10 : ColorManager.grey,
        selectedItemColor:
            isDark ? ColorManager.lightBlue200 : ColorManager.black87,
        backgroundColor: isDark
            ? ColorManager.scaffoldDarkColor
            : ColorManager.scaffoldColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: _selectedPage,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(IconManager.home),
            label: AppString.home.localize(context),
          ),
          // BottomNavigationBarItem(
          //   icon: const Icon(IconManager.plane),
          //   label: AppString.addPlane.localize(context),
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(IconManager.activities),
          //   label: AppString.addActivity.localize(context),
          // ),
          BottomNavigationBarItem(
            icon: const Icon(IconManager.settings),
            label: AppString.settings.localize(context),
          ),
          BottomNavigationBarItem(
            icon: const Icon(IconManager.aboutUs),
            label: AppString.aboutUs.localize(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _checkStatus,
        tooltip: AppString.playStop.localize(context),
        child: Icon(_isPlayed ? IconManager.play : IconManager.pause),
      ),
    );
  }
}
