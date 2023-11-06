import 'package:caul/ui/screens/cooking_screen/choose_ingredients_screen.dart';
import 'package:caul/ui/screens/my_page_screen.dart';
import 'package:caul/ui/screens/save_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: const Text(
          'おたすけCook！',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: const ChooseIngredients(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'おたすけCook！',
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
                Navigator.pop(context);
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
                  '/save',
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
                  '/myPage',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
