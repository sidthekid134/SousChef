import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:souschef/models/recipe.dart';

class Firestore {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Firestore();

  void addRecipeToFirestore(Recipe recipe) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Add the Map to Firestore
    firestore
        .collection('recipes')
        .doc(recipe.id)
        .set(recipe.toJson())
        .then((_) => print('Recipe added'))
        .catchError((error) => print('Failed to add recipe: $error'));
  }
}
