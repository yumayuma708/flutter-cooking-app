import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecipeSaver {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth; // FirebaseAuth インスタンスを保持するフィールドを追加

  RecipeSaver(this.firestore, this.auth);

  Future<void> saveRecipe(Map<String, dynamic> recipeData) async {
    User? user = auth.currentUser; // ログイン中のユーザーを取得
    if (user != null) {
      await firestore
          .collection('recipes')
          .doc(user.uid)
          .collection('userRecipes')
          .add(recipeData);
    } else {
      print("No user is signed in.");
    }
  }
}
