import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  static const clientId = 'YOUR_CLIENT_ID.apps.googleusercontent.com';
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _handleGoogleSignIn() async {
    try {
      await _googleSignIn.signIn();
      Navigator.of(context).pop(); // Close the popup after successful login
    } catch (error) {
      if (kDebugMode) {
        print(error);
      } // Handle login error if any
    }
  }

  _showLoginPopup() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Googleにログイン', style: TextStyle(fontSize: 24.0)),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: const Icon(
                      Icons.login), // Google logo or any other icon you prefer
                  label: const Text('Googleでサインイン'),
                  onPressed: _handleGoogleSignIn,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.orange[100],
      child: GestureDetector(
        onTap: _showLoginPopup, // ← テキストをタップ時に_showLoginPopupを呼び出し
        child: const Center(child: Text('マイページ')),
      ),
    ));
  }
}
