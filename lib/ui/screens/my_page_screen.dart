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

  // サインアップ（新規登録）用のメソッド
  Future<void> _handleSignUpWithEmailAndPassword() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      recipeSaver =
          RecipeSaver(FirebaseFirestore.instance, _auth); // _auth を渡します。
      Navigator.of(context).pop(); // Close the popup after successful login
    } catch (e) {
      print(e);
    }
  }

// サインイン（既存ユーザーのログイン）用のメソッド
  Future<void> _handleSignInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      recipeSaver = RecipeSaver(FirebaseFirestore.instance, _auth);
      if (mounted) {
        // このウィジェットがまだマウントされているかチェック
        Navigator.of(context).pop(); // Close the popup after successful login
      }
    } catch (e) {
      print(e);
    }
  }

  _showLoginPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sign in or Sign up'),
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
                onPressed: _handleSignInWithEmailAndPassword,
                child: const Text('Sign in'),
              ),
              ElevatedButton(
                onPressed: _handleSignUpWithEmailAndPassword,
                child: const Text('Sign up'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _showLoginPopup,
        child: const Center(
          child: Text(
            'Googleにログイン',
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
    );
  }
}
