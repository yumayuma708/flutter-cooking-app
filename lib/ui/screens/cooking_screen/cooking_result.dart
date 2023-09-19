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
          title: Text(
            'AIの考えたレシピ',
            style: GoogleFonts.zenKakuGothicNew(
                fontSize: 25, color: Colors.black, fontWeight: FontWeight.w500),
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
