import 'package:flutter/material.dart';
import 'package:caul/providers/chat_gpt_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class CookingResultPage extends StatelessWidget {
  final CookingData data;

  const CookingResultPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange[100],
        appBar: AppBar(
          backgroundColor: Colors.orange[500],
          centerTitle: true, // この行を追加
          title: Row(
            children: [
              const SizedBox(width: 12.5),
              const Icon(
                Icons.restaurant_menu, // Google IconsのRestaurant Menuアイコンを追加
                color: Colors.black,
              ),
              const SizedBox(width: 8.0), // アイコンとテキストの間にスペースを追加

              Text(
                'AIの考えたレシピ',
                style: GoogleFonts.zenKakuGothicNew(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 8.0), // アイコンとテキストの間にスペースを追加
              const Icon(
                Icons.restaurant_menu, // Google IconsのRestaurant Menuアイコンを追加
                color: Colors.black,
              ),
            ],
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  data.instruction,
                  style: GoogleFonts.zenKurenaido(fontSize: 15),
                ),
              ],
            ),
          ),
        ));
  }
}
