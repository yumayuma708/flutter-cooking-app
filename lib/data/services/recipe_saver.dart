import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeSaver {
  final FirebaseFirestore firestore;

  RecipeSaver(this.firestore);

  Future<void> saveRecipe(Map<String, dynamic> recipeData) async {
    await firestore.collection('recipes').add(recipeData);
  }
}
