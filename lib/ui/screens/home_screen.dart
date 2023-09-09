// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:caul/providers/popup_provider.dart';
import 'package:caul/ui/screens/cooking_screen.dart';
import 'package:caul/ui/screens/favorite_screen.dart';
import 'package:caul/ui/screens/my_page_screen.dart';
import 'package:caul/ui/screens/rankings_screen.dart';
import 'package:caul/ui/screens/popup_page.dart';
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
                PopupDialog(
                        context: context,
                        ref: ref,
                        pageController: pageController)
                    .show();
              }
            },
          );
        }),
      ),
    );
  }
}
