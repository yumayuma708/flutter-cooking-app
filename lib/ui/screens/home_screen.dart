import 'package:caul/ui/screens/cooking_screen/choose_ingredients_screen.dart';
import 'package:caul/ui/screens/cooking_screen/cooking_result_screen.dart';
import 'package:caul/ui/screens/cooking_screen/cooking_situation_screen.dart';
import 'package:caul/ui/screens/my_page_screen.dart';
import 'package:caul/ui/screens/popup_screen/popup_dialog.dart';
import 'package:caul/ui/screens/save_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final _currentIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  String _getTitleForCurrentScreen(BuildContext context) {
    final route = ModalRoute.of(context)?.settings.name;

    switch (route) {
      case ChooseIngredients.routeName:
        return '食材を選びます';
      case SaveScreen.routeName:
        return '保存したレシピ';
      case CookingSituationInternal.routeName:
        return '条件を選びます';
      case CookingResultPage.routeName:
        return 'AIの作ったレシピ';
      case MyPageScreen.routeName:
        return 'マイページ';
      default:
        return 'アプリ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitleForCurrentScreen(context)),
      ),
      body: Stack(
        children: List.generate(_navigatorKeys.length, (index) {
          return Offstage(
            offstage: _currentIndex != index,
            child: Navigator(
              key: _navigatorKeys[index],
              onGenerateRoute: (routeSettings) {
                return MaterialPageRoute(
                  builder: (context) {
                    switch (index) {
                      case 0:
                        return const ChooseIngredients();
                      case 1:
                        return SaveScreen();
                      case 2:
                        return const MyPageScreen();
                      default:
                        throw Exception("Invalid index");
                    }
                  },
                );
              },
            ),
          );
        }),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.utensils),
              title: const Text('料理'),
              onTap: () {
                Navigator.pop(context); // ドロワーを閉じる
                // ChooseIngredientsScreenに遷移
                Navigator.pushNamed(
                  context,
                  ChooseIngredients.routeName,
                );
              },
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.bookmark),
              title: const Text('保存'),
              onTap: () {
                Navigator.pop(context); // ドロワーを閉じる
                // SaveScreenに遷移
                Navigator.pushNamed(
                  context,
                  SaveScreen.routeName,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('マイページ'),
              onTap: () {
                Navigator.pop(context); // ドロワーを閉じる
                // MyPageScreenに遷移
                Navigator.pushNamed(
                  context,
                  MyPageScreen.routeName,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
