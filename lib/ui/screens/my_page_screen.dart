import 'package:caul/data/services/recipe_saver.dart';
import 'package:caul/ui/screens/popup_screen/login_signup_logout_popup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyPageScreen extends StatefulWidget {
  @override
  MyPageScreenState createState() => MyPageScreenState();
}

class MyPageScreenState extends State<MyPageScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late RecipeSaver recipeSaver; // 遅延初期化
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // サインイン（既存ユーザーのログイン）用のメソッド
  Future<void> handleSignInWithEmailAndPassword(
      BuildContext dialogContext) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      recipeSaver = RecipeSaver(FirebaseFirestore.instance, auth);
      Navigator.of(dialogContext).pop(); // Using the dialog's context to pop
    } catch (e) {
      print(e);
    }
  }

// サインアップ（新規登録）用のメソッド
  Future<void> handleSignUpWithEmailAndPassword(
      BuildContext dialogContext) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      recipeSaver = RecipeSaver(FirebaseFirestore.instance, auth);
      Navigator.of(dialogContext).pop(); // Using the dialog's context to pop
    } catch (e) {
      print(e);
    }
  }

// サインアウト用のメソッド
  Future<void> handleSignOut(BuildContext dialogContext) async {
    try {
      await auth.signOut();
      Navigator.of(dialogContext)
          .pop(); // Use dialogContext to pop the confirmation popup
    } catch (e) {
      print(e);
    }
  }

//UIとして表示される部分
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser; // 現在のユーザーを取得

    return Scaffold(
      // backgroundColor: Colors.orange[100],
      appBar: AppBar(
        // backgroundColor: Colors.orange[500],
        title: const Text(
          'マイページ',
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.w800),
        ),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // ユーザー名の表示
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              user != null ? user.email ?? '名前なし' : 'ログインするか、アカウントを作ります',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          if (user == null) ...[
            ElevatedButton(
              onPressed: () => showLoginPopup(context, emailController,
                  passwordController, handleSignInWithEmailAndPassword),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                elevation: MaterialStateProperty.all<double>(0.0),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: const BorderSide(color: Colors.orangeAccent),
                  ),
                ),
              ),
              child: const Text(
                'ログイン',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => showSignUpPopup(context, emailController,
                  passwordController, handleSignUpWithEmailAndPassword),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                elevation: MaterialStateProperty.all<double>(0.0),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: const BorderSide(color: Colors.orangeAccent),
                  ),
                ),
              ),
              child: const Text(
                'アカウントを作成',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
            const SizedBox(height: 20),
          ] else ...[
            ElevatedButton(
              onPressed: () =>
                  showSignOutConfirmationPopup(context, handleSignOut),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                elevation: MaterialStateProperty.all<double>(0.0),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: const BorderSide(color: Colors.orangeAccent),
                  ),
                ),
              ),
              child: const Text(
                'ログアウト',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
          ],
        ]),
      ),
    );
  }
}
