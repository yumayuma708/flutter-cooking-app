import 'package:caul/ui/screens/cooking_screen/choose_ingredients_screen.dart';
import 'package:caul/ui/screens/home_screen.dart';
import 'package:caul/ui/screens/my_page_screen.dart';
import 'package:caul/ui/screens/save_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:caul/providers/theme_provider.dart';

class CookingApp extends ConsumerWidget {
  const CookingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    const seedColor = Colors.pink;
    return MaterialApp(
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
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
        }
      },
      title: 'Cooking As You Like',
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
