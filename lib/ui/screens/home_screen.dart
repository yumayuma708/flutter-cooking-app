import 'package:caul/ui/screens/cooking_screen.dart';
import 'package:caul/ui/screens/favorite_screen.dart';
import 'package:caul/ui/screens/my_page_screen.dart';
import 'package:caul/ui/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black, // 選択されているアイテムの色を黒に設定
        unselectedItemColor: Colors.black, // 選択されていないアイテムの色も黒に設定
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.utensils),
            label: '料理',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '検索',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.star), // FontAwesomeのアイコンを使用
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
        },
      ),
    );
  }
}
