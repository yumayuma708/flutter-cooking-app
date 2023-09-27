import 'package:flutter/material.dart';

// ログイン用のポップアップ
showLoginPopup(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
    Function handleSignInWithEmailAndPassword) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text('ログイン'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () => handleSignInWithEmailAndPassword(dialogContext),
              child: const Text('ログイン'),
            ),
          ],
        ),
      );
    },
  );
}

// サインアップ用のポップアップ
showSignUpPopup(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
    Function handleSignUpWithEmailAndPassword) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text('アカウントを作成'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () => handleSignUpWithEmailAndPassword(dialogContext),
              child: const Text('アカウントを作成'),
            ),
          ],
        ),
      );
    },
  );
}

//サインアウト確認用のポップアップ
showSignOutConfirmationPopup(BuildContext context, Function handleSignOut) {
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
            onPressed: () => handleSignOut(dialogContext),
            child: const Text('ログアウト'),
          ),
        ],
      );
    },
  );
}
