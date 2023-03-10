import '../providers/activities_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';
import 'providers/app_version_provider.dart';
import 'providers/dark_theme_provider.dart';
import 'providers/items_provider.dart';
import 'resources/language_manager.dart';
import 'resources/route_manager.dart';
import 'resources/theme_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Locales.init([
    LanguageType.ENGLISH.getValue(),
    LanguageType.ARABIC.getValue(),
  ]);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ItemsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => themeChangeProvider,
        ),
        ChangeNotifierProvider(
          create: (_) => AppVersionProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ActivitiesProvider(),
        ),
      ],
      child: LocaleBuilder(
        builder: (locale) => Consumer<DarkThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              localizationsDelegates: Locales.delegates,
              supportedLocales: Locales.supportedLocales,
              locale: locale,
              debugShowCheckedModeBanner: false,
              title: 'EGYPT ARMY FORCE',
              theme:
                  ThemeManager.themeData(themeProvider.getDarkTheme, context),
              initialRoute: Routes.fetchDataRoute,
              onGenerateRoute: RouteGenerator.getRoute,
            );
          },
        ),
      ),
    );
  }
}
