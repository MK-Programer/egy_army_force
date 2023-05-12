import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';

import '../providers/activities_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/app_version_provider.dart';
import 'providers/dark_theme_provider.dart';
import 'providers/items_provider.dart';
import 'resources/language_manager.dart';
import 'resources/route_manager.dart';
import 'resources/theme_manager.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Locales.init([
    LanguageType.ENGLISH.getValue(),
    LanguageType.ARABIC.getValue(),
  ]);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    log('Got a message whilst in the foreground!');
    log('Message data: ${message.data}');
    if (message.notification != null) {
      log('Message also contained a notification: ${message.notification}');
    }
  });
  // log('User granted permission: ${settings.authorizationStatus}');

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
    (_) => runApp(
      const MyApp(),
    ),
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
              // home: BackgroundAudioWidget(),
            );
          },
        ),
      ),
    );
  }
}
