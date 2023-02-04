import 'package:egy_army_force/providers/items_provider.dart';
import 'package:egy_army_force/resources/language_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ItemsProvider(),
        ),
      ],
      child: LocaleBuilder(
        builder: (locale) => MaterialApp(
          localizationsDelegates: Locales.delegates,
          supportedLocales: Locales.supportedLocales,
          locale: locale,
          debugShowCheckedModeBanner: false,
          title: 'EGYPT ARMY FORCE',
          theme: ThemeManager.themeData(),
          initialRoute: Routes.fetchDataRoute,
          onGenerateRoute: RouteGenerator.getRoute,
        ),
      ),
    );
  }
}
