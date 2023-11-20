import 'package:caul/providers/chat_gpt_provider.dart';
import 'package:caul/ui/screens/cooking_screen/cooking_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SaveScreen extends StatelessWidget {
  final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
  static const routeName = '/save';

  SaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (currentUserId == null) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text(
            '保存したレシピ',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground),
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.faceSadTear,
                      size: 40,
                      color: Theme.of(context).colorScheme.onBackground),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '保存したレシピを見るにはログインしてください',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          '保存したレシピ',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('recipes')
            .doc('users')
            .collection(currentUserId!)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading');
          }

          return ListView(
            children: snapshot.data!.docs.map(
              (DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['dishName']),
                  onTap: () {
                    // debugPrint(data['selectedVegetables'].toString());
                    // debugPrint(data['selectedSeasonings'].toString());
                    // debugPrint(data['timeConditions'].toString());
                    // debugPrint(data['servingConditions'].toString());
                    // debugPrint(data['cuisineType'].toString());
                    // debugPrint(data['sizeConditions'].toString());
                    // debugPrint(data['preferenceConditions'].toString());
                    // debugPrint(data['confirmationConditions'].toString());
                    // debugPrint(data['instruction'].toString());
                    // debugPrint(data['selectedHeaders'].toString());
                    CookingData finalData = CookingData(
                      selectedVegetables:
                          (data['selectedVegetables'] as List? ?? [])
                              .cast<String>(),
                      selectedSeasonings:
                          (data['selectedSeasonings'] as List? ?? [])
                              .cast<String>(),
                      timeConditions: (data['timeConditions'] as List? ?? [])
                          .cast<String>(),
                      servingConditions:
                          (data['servingConditions'] as List? ?? [])
                              .cast<String>(),
                      cuisineType:
                          (data['cuisineType'] as List? ?? []).cast<String>(),
                      sizeConditions: (data['sizeConditions'] as List? ?? [])
                          .cast<String>(),
                      preferenceConditions:
                          (data['preferenceConditions'] as List? ?? [])
                              .cast<String>(),
                      confirmationConditions:
                          (data['confirmationConditions'] as List? ?? [])
                              .cast<String>(),
                      instruction: (data['instruction'] ?? ''),
                      // selectedHeaders: (data['selectedHeaders'] ?? '{}'),
                      selectedHeaders: <String, Set<String>>{},
                    );
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CookingResultPage(
                          data: finalData,
                          selectedHeaders:
                              finalData.selectedHeaders, // Add this line
                          selectedVegetables: finalData.selectedVegetables,
                        ),
                      ),
                    );
                  },
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
