import 'package:caul/data/services/recipe_saver.dart';
import 'package:caul/ui/screens/popup_screen/login_signup_logup_popup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: Colors.orange[100],
      appBar: AppBar(
        backgroundColor: Colors.orange[500],
        title: Text(
          'マイページ',
          style: GoogleFonts.zenKakuGothicNew(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.w800),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ユーザー名の表示
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                user != null ? user.email ?? '名前なし' : 'ログインしていません',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              onPressed: () => showLoginPopup(context, emailController,
                  passwordController, handleSignInWithEmailAndPassword),
              child: const Text('ログイン'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => showSignUpPopup(context, emailController,
                  passwordController, handleSignUpWithEmailAndPassword),
              child: const Text('アカウントを作成'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () =>
                  showSignOutConfirmationPopup(context, handleSignOut),
              child: const Text('ログアウト'),
            ),
          ],
        ),
      ),
    );
  }
}
