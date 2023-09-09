import 'package:caul/providers/popup_provider.dart';
import 'package:caul/ui/screens/cooking_screen.dart';
import 'package:caul/ui/screens/favorite_screen.dart';
import 'package:caul/ui/screens/my_page_screen.dart';
import 'package:caul/ui/screens/rankings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // 追加
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _showPopup(
    BuildContext context, WidgetRef ref, PageController pageController) async {
  final prefs = await SharedPreferences.getInstance();

  final hasShownPopup = prefs.getBool('hasShownPopup') ?? false;

  if (!hasShownPopup) {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return PageView.builder(
          controller: pageController,
          itemCount: 3,
          onPageChanged: (index) {
            ref.read(popupProvider.notifier).updateCurrentPage(index + 1);
          },
          itemBuilder: (context, index) {
            String description;
            String buttonLabel;
            VoidCallback onPressed;

            switch (index) {
              case 0:
                description = "これはページ1です。";
                buttonLabel = "次へ";
                onPressed = () => pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
                break;
              case 1:
                description = "これはページ2です。";
                buttonLabel = "次へ";
                onPressed = () => pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
                break;
              case 2:
                description = "これはページ3です。";
                buttonLabel = "料理を作る！";
                onPressed = () => Navigator.of(context).pop();
                break;
              default:
                throw Exception("Invalid page index");
            }

            return _PopupPage(
              description: description,
              buttonLabel: buttonLabel,
              onPressed: onPressed,
            );
          },
        );
      },
    );
    await prefs.setBool('hasShownPopup', true);
  }

  WidgetsBinding.instance?.addPostFrameCallback((_) {
    _showPopup(context, ref, pageController);
  });
}

class _PopupPage extends StatelessWidget {
  final String description;
  final String buttonLabel;
  final VoidCallback onPressed;

  const _PopupPage({
    Key? key,
    required this.description,
    required this.buttonLabel,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(description),
          ElevatedButton(onPressed: onPressed, child: Text(buttonLabel)),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title})
      : super(key: key); // keyがsuper.keyからKey? keyに変更されました

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    const CookingScreen(),
    const SearchScreen(),
    const FavoriteScreen(),
    const MyPageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: Container(
        color: Colors.orange,
        child: Consumer(builder: (context, ref, child) {
          return BottomNavigationBar(
            backgroundColor: Colors.orange,
            currentIndex: _currentIndex,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.utensils),
                label: '料理',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.crown),
                label: 'ランキング',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.star),
                label: 'お気に入り',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'マイページ',
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });

              if (index == 0) {
                // 「料理」のタブをタップしたときの処理
                final popupNotifier = ref.watch(popupProvider.notifier);
                final pageController = popupNotifier.pageController;
                _showPopup(context, ref, pageController);
              }
            },
          );
        }),
      ),
    );
  }
}
