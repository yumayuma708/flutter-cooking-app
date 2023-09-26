import 'package:caul/data/services/recipe_saver.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyPageScreen extends StatefulWidget {
  @override
  MyPageScreenState createState() => MyPageScreenState();
}

class MyPageScreenState extends State<MyPageScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late RecipeSaver recipeSaver; // 遅延初期化
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // サインイン（既存ユーザーのログイン）用のメソッド
  Future<void> _handleSignInWithEmailAndPassword(
      BuildContext dialogContext) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      recipeSaver = RecipeSaver(FirebaseFirestore.instance, _auth);
      Navigator.of(dialogContext).pop(); // Using the dialog's context to pop
    } catch (e) {
      print(e);
    }
  }

// サインアップ（新規登録）用のメソッド
  Future<void> _handleSignUpWithEmailAndPassword(
      BuildContext dialogContext) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      recipeSaver = RecipeSaver(FirebaseFirestore.instance, _auth);
      Navigator.of(dialogContext).pop(); // Using the dialog's context to pop
    } catch (e) {
      print(e);
    }
  }

// サインアウト用のメソッド
  Future<void> _handleSignOut(BuildContext dialogContext) async {
    try {
      await _auth.signOut();
      Navigator.of(dialogContext)
          .pop(); // Use dialogContext to pop the confirmation popup
    } catch (e) {
      print(e);
    }
  }

// ログイン用のポップアップ
  _showLoginPopup() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('ログイン'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () =>
                    _handleSignInWithEmailAndPassword(dialogContext),
                child: const Text('ログイン'),
              ),
            ],
          ),
        );
      },
    );
  }

// サインアップ用のポップアップ
  _showSignUpPopup() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('アカウントを作成'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () =>
                    _handleSignUpWithEmailAndPassword(dialogContext),
                child: const Text('アカウントを作成'),
              ),
            ],
          ),
        );
      },
    );
  }

//サインアウト確認用のポップアップ
  _showSignOutConfirmationPopup() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('ログアウトの確認'),
          content: const Text('本当にログアウトしますか？'),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.of(dialogContext).pop(), // Close the dialog
              child: const Text('キャンセル'),
            ),
            ElevatedButton(
              onPressed: () => _handleSignOut(dialogContext),
              child: const Text('ログアウト'),
            ),
          ],
        );
      },
    );
  }

//UIとして表示される部分
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _showLoginPopup,
              child: const Text('ログイン'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showSignUpPopup,
              child: const Text('アカウントを作成'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showSignOutConfirmationPopup,
              child: const Text('ログアウト'),
            ),
          ],
        ),
      ),
    );
  }
}
