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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        backgroundColor: Colors.orange[100],
        title: const Center(child: Text('ログイン')),
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
            const SizedBox(
              height: 18,
            ),
            ElevatedButton(
              onPressed: () => handleSignInWithEmailAndPassword(dialogContext),
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
        backgroundColor: Colors.orange[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        title: const Center(
          child: Text('アカウントを作成'),
        ),
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
            const SizedBox(
              height: 18,
            ),
            ElevatedButton(
              onPressed: () => handleSignUpWithEmailAndPassword(dialogContext),
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
                  color: Colors.black,
                ),
              ),
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
          backgroundColor: Colors.orange[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: const Center(
            child: Text('ログアウトの確認'),
          ),
          content: const SizedBox(
            // この部分でコンテナの高さを指定して調整します。
            height: 50, // 適切な高さに設定してください
            width: 300,
            child: Center(
              child: Text('本当にログアウトしますか？'),
            ),
          ),
          actions: [
            Row(
              children: [
                const Spacer(
                  flex: 2,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    elevation: MaterialStateProperty.all<double>(0.0),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(color: Colors.orangeAccent),
                      ),
                    ),
                  ),
                  onPressed: () =>
                      Navigator.of(dialogContext).pop(), // Close the dialog
                  child: const Text(
                    'キャンセル',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => handleSignOut(dialogContext),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
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
                      color: Colors.black,
                    ),
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            )
          ]);
    },
  );
}
