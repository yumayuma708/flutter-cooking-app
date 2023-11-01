import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SaveScreen extends StatelessWidget {
  final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

  SaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (currentUserId == null) {
      return Scaffold(
        backgroundColor: Colors.orange[100],
        appBar: AppBar(
          title: const Text(
            '保存したレシピ',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          backgroundColor: Colors.orange[500],
          centerTitle: true,
        ),
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.center, // 縦方向に中央に配置
          crossAxisAlignment: CrossAxisAlignment.center, // 横方向に中央に配置
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // 縦方向に中央に配置
                crossAxisAlignment: CrossAxisAlignment.center, // 横方向に中央に配置
                children: [
                  Icon(
                    FontAwesomeIcons.faceSadTear,
                    size: 40,
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '保存したレシピを見るにはログインしてください',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
      backgroundColor: Colors.orange[100],
      appBar: AppBar(
        backgroundColor: Colors.orange[500],
        title: const Text(
          '保存したレシピ',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
        ),
      ),
      body: StreamBuilder(
        // Fetch recipes saved by the current user from the users sub-collection
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
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['dishName']),
                subtitle: Text(data['ingredients']),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
