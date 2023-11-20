import 'package:caul/ui/screens/home_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  StartScreenState createState() => StartScreenState();
}

class StartScreenState extends State<StartScreen> {
  bool _isFirstTime = true;

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  Future<void> _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    setState(() {
      _isFirstTime = isFirstTime;
    });

    if (isFirstTime) {
      await prefs.setBool('isFirstTime', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isFirstTime) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/home');
      });
      return Container();
    }

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'おたすけCook！にログイン',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 64),
            const Text('おたすけCook！にログインすると、お気に入りのレシピを保存することができます。',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                )),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(
                      actions: [
                        AuthStateChangeAction<SignedIn>((context, state) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('ログインしました'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const MyHomePage(
                                title: '',
                              ),
                            ),
                          );
                        }),
                        AuthStateChangeAction<UserCreated>((context, state) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('ログインしました'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const MyHomePage(
                                title: '',
                              ),
                            ),
                          );
                        }),
                      ],
                      providers: [
                        EmailAuthProvider(),
                      ],
                    ),
                  ),
                );
              },
              child: const Text('ログインまたは登録'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.person_off_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '登録せず利用する',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(fontSize: 16.0, color: Colors.black),
                children: <TextSpan>[
                  const TextSpan(
                    text: 'このアプリの利用を開始することで、',
                  ),
                  TextSpan(
                    text: '利用規約',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      decoration: TextDecoration.none,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(context, '/termsOfService');
                      },
                  ),
                  const TextSpan(
                    text: '及び',
                  ),
                  TextSpan(
                    text: 'プライバシーポリシー',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      decoration: TextDecoration.none,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(context, '/privacyPolicy');
                      },
                  ),
                  const TextSpan(
                    text: 'に同意したものとみなします。',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
