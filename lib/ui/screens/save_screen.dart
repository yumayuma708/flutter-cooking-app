import 'package:caul/providers/chat_gpt_devider.dart';
import 'package:caul/ui/components/constants.dart';
import 'package:caul/ui/screens/cooking_screen/saved_cooking_result.dart';
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
      return Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width > maxScreenWidth
              ? maxScreenWidth
              : MediaQuery.of(context).size.width,
          child: Scaffold(
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
          ),
        ),
      );
    }

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width > maxScreenWidth
            ? maxScreenWidth
            : MediaQuery.of(context).size.width,
        child: Scaffold(
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
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('エラーが発生しました: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;

                  // Firestoreから取得したデータを使用してChatGPTDividedDataオブジェクトを作成
                  ChatGPTDividedData dividedData = ChatGPTDividedData(
                    dishName: data['dishName'] ?? '',
                    estimatedTime: data['estimatedTime'] ?? '',
                    numberOfPeople: data['numberOfPeople'] ?? '',
                    ingredients: data['ingredients'] ?? '',
                    recipe: data['recipe'] ?? '',
                    appealPoint: data['appealPoint'] ?? '',
                  );

                  return ListTile(
                    title: Text(dividedData.dishName),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            SavedCookingResult(dividedData: dividedData),
                      ));
                    },
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
