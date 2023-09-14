import 'package:flutter/material.dart';
import 'package:caul/providers/chat_gpt_provider.dart';
import 'package:caul/ui/screens/cooking_screen/cooking_result.dart';

class LoadingScreen extends StatefulWidget {
  final CookingData data;

  LoadingScreen({required this.data});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    try {
      await ChatGPTProvider().getCookingInstruction(widget.data);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => CookingResultPage(data: widget.data),
      ));
    } catch (e) {
      print('Error: $e');
      Navigator.of(context).pop(); // エラーの場合、前の画面に戻る
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 20.0),
            Text(
              'レシピを作っています...',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
