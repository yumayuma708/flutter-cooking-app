import 'package:caul/ui/screens/cooking_screen/choose_ingredients_screen.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded),
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
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  SizedBox(
                    height: 70,
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                      child: Text(
                        'おたすけCook！',
                        style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.restaurant_menu_rounded),
                    title: const Text('料理を作る'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.bookmark_rounded),
                    title: const Text('保存したレシピ'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        '/save',
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person_rounded),
                    title: const Text('マイページ'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        '/myPage',
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings_rounded),
                    title: const Text('設定'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        '/setting',
                      );
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.description_rounded),
              title: const Text('おたすけCook！について'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/appInfo');
              },
            ),
            ListTile(
              leading: const Icon(Icons.share_rounded),
              title: const Text('アプリを共有'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/shareApp');
              },
            ),
            ListTile(
              leading: const Icon(Icons.gavel_rounded),
              title: const Text('利用規約'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/termsOfService');
              },
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip_rounded),
              title: const Text('プライバシーポリシー'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/privacyPolicy');
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
