import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';

import '../../../providers/dark_theme_provider.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/language_manager.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/values_manager.dart';
import '../../../utils/utils.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    List<String> menuItems = [
      AppString.enLang,
      AppString.arLang,
    ];

    final List<DropdownMenuItem<String>> dropDownMenuItems = menuItems
        .map(
          (value) => DropdownMenuItem(
            value: value,
            child: Text(
              value.localize(context),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        )
        .toList();
    String currentLang = Utils(context).getCurrentLocale ==
            LanguageType.ENGLISH.getValue().toUpperCase()
        ? AppString.enLang
        : AppString.arLang;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: ListView(
          children: [
            Text(
              AppString.chooseLang.localize(context),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            DropdownButton(
              dropdownColor: themeState.getDarkTheme
                  ? ColorManager.scaffoldDarkColor
                  : ColorManager.scaffoldColor,
              isExpanded: true,
              value: currentLang,
              items: dropDownMenuItems,
              onChanged: (value) {
                setState(() => currentLang = value.toString());
                if (value == menuItems[0]) {
                  LocaleNotifier.of(context)!
                      .change(LanguageType.ENGLISH.getValue());
                } else {
                  LocaleNotifier.of(context)!
                      .change(LanguageType.ARABIC.getValue());
                }
              },
            ),
            SwitchListTile(
              title: LocaleText(
                themeState.getDarkTheme
                    ? AppString.darkMode
                    : AppString.lightMode,
              ),
              secondary: Icon(
                themeState.getDarkTheme
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined,
                color: themeState.getDarkTheme
                    ? ColorManager.scaffoldColor
                    : ColorManager.black,
              ),
              onChanged: (bool value) {
                setState(
                  () {
                    themeState.setDarkTheme = value;
                  },
                );
              },
              value: themeState.getDarkTheme,
            ),
          ],
        ),
      ),
    );
  }
}
