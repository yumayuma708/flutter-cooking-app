import 'package:flutter/material.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _showLoginPopup();
    });
  }

  _showLoginPopup() {
    showDialog(
      context: context,
      barrierDismissible: false, // ユーザーがダイアログの外部をタップしたときにダイアログが閉じないようにする
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Googleにログイン'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'メールアドレス',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20), // 余白を追加
              ElevatedButton(
                child: Text('次へ'),
                onPressed: () {
                  Navigator.of(context).pop(); // ポップアップを閉じる
                },
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('マイページ'));
  }
}
