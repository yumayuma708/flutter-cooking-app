import 'package:caul/ui/screens/cooking_screen/choose_ingredients_screen.dart';
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
  int _currentIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
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
                        return SaveScreen();
                      case 2:
                        return MyPageScreen();
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
        return NavigationBar(
          selectedIndex: _currentIndex,
          // backgroundColor: const Color.fromARGB(255, 4, 7, 47),
          destinations: const [
            NavigationDestination(
              icon: Icon(
                FontAwesomeIcons.utensils,
              ),
              label: '料理',
            ),
            NavigationDestination(
              icon: Icon(
                FontAwesomeIcons.bookmark,
              ),
              label: '保存',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.person,
              ),
              label: 'マイページ',
            ),
          ],
          onDestinationSelected: (index) {
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
