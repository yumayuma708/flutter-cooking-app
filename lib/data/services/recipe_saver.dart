import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecipeSaver {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  RecipeSaver(this.firestore, this.auth);

  Future<void> addRecipe(Map<String, dynamic> recipeData) async {
    final user = auth.currentUser;
    if (user != null) {
      await firestore
          .collection('users')
          .doc(user.uid)
          .collection('recipes')
          .add(recipeData);
    }
  }

  Future<QuerySnapshot> getUserRecipes() async {
    final user = auth.currentUser;
    if (user != null) {
      return await firestore
          .collection('users')
          .doc(user.uid)
          .collection('recipes')
          .get();
    }
    throw Exception('User not logged in');
  }
}
