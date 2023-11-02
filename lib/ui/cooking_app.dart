import 'package:caul/ui/screens/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:caul/providers/theme_provider.dart'; // 必要に応じて適切なパスに変更してください

class CookingApp extends ConsumerWidget {
  const CookingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider); // ThemeProviderの状態を取得

    const seedColor = Colors.orange;
    return MaterialApp(
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
      themeMode: theme.isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light, // ここでテーマモードを切り替える
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}
