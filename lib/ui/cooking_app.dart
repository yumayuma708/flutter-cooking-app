import 'package:caul/ui/screens/cooking_screen/choose_ingredients_screen.dart';
import 'package:caul/ui/screens/document_screen/about_app_screen.dart';
import 'package:caul/ui/screens/document_screen/privacy_policy_screen.dart';
import 'package:caul/ui/screens/document_screen/share_app_screen.dart';
import 'package:caul/ui/screens/document_screen/terms_of_service_screen.dart';
import 'package:caul/ui/screens/home_screen.dart';
import 'package:caul/ui/screens/my_page_screen.dart';
import 'package:caul/ui/screens/save_screen.dart';
import 'package:caul/ui/screens/setting_screen.dart';
import 'package:caul/ui/screens/start_screen.dart';
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:caul/providers/theme_provider.dart';

class CookingApp extends ConsumerWidget {
  const CookingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    const seedColor = Colors.pink;
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FirebaseUILocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja', 'JP'),
      ],
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/start':
            return MaterialPageRoute(
              builder: (context) => const StartScreen(),
            );

          case '/ingredients':
            return MaterialPageRoute(
              builder: (context) => const ChooseIngredients(),
            );

          case '/save':
            return MaterialPageRoute(
              builder: (context) => SaveScreen(),
            );

          case '/myPage':
            return MaterialPageRoute(
              builder: (context) => const MyPageScreen(),
            );

          case '/setting':
            return MaterialPageRoute(
              builder: (context) => const SettingScreen(),
            );

          case '/appInfo':
            return MaterialPageRoute(
              builder: (context) => const AboutAppScreen(),
            );

          case '/shareApp':
            return MaterialPageRoute(
              builder: (context) => const ShareAppScreen(),
            );

          case '/termsOfService':
            return MaterialPageRoute(
              builder: (context) => const TermsOfServiceScreen(),
            );

          case '/privacyPolicy':
            return MaterialPageRoute(
              builder: (context) => const PrivacyPolicyScreen(),
            );
        }
      },
      title: 'おたすけCook！',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: seedColor,
        brightness: Brightness.light,
        fontFamily: kIsWeb ? 'ZenKakuGothicNew' : null,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: seedColor,
        brightness: Brightness.dark,
        fontFamily: kIsWeb ? 'ZenKakuGothicNew' : null,
      ),
      themeMode: theme.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}
