import 'package:caul/ui/screens/cooking_screen/choose_ingredients.dart';
import 'package:caul/ui/screens/favorite_screen.dart';
import 'package:caul/ui/screens/my_page_screen.dart';
import 'package:caul/ui/screens/popup_dialog.dart';
import 'package:caul/ui/screens/save_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // 追加
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title})
      : super(key: key); // keyがsuper.keyからKey? keyに変更されました

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  // 各ページのルートのキーを格納するためのリスト
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return const SearchScreen();
                      case 2:
                        return const FavoriteScreen();
                      case 3:
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
      bottomNavigationBar: Consumer(builder: (context, ref, child) {
        return BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 4, 7, 47),
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.utensils,
                color: _currentIndex == 0 ? Colors.white : Colors.white70,
              ),
              label: '料理',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.bookmark,
                color: _currentIndex == 1 ? Colors.white : Colors.white70,
              ),
              label: '保存',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.star,
                color: _currentIndex == 2 ? Colors.white : Colors.white70,
              ),
              label: 'お気に入り',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: _currentIndex == 3 ? Colors.white : Colors.white70,
              ),
              label: 'マイページ',
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });

            String tabType;
            switch (index) {
              case 0:
                tabType = 'cook';
                break;
              case 1:
                tabType = 'save';
                break;
              case 2:
                tabType = 'favorite';
                break;
              case 3:
                tabType = 'mypage';
                break;
              default:
                throw Exception("Invalid tab index");
            }

            PopupDialog(
              context: context,
              ref: ref,
              tabType: tabType,
            ).show();
          },
        );
      }),
    );
  }
}
