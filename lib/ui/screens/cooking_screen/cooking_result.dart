import 'package:caul/providers/chat_gpt_devider.dart';
import 'package:flutter/material.dart';
import 'package:caul/providers/chat_gpt_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CookingResultPage extends StatelessWidget {
  final CookingData data;
  final ChatGPTDividedData dividedData;

  CookingResultPage({super.key, required this.data})
      : dividedData = ChatGPTDividedData.parseFromInstruction(data.instruction);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange[100],
        appBar: AppBar(
          backgroundColor: Colors.orange[500],
          centerTitle: true,
          title: Row(
            children: [
              const SizedBox(width: 12.5),
              const Icon(
                Icons.restaurant_menu,
                color: Colors.black,
              ),
              const SizedBox(width: 8.0),
              Text(
                'AIの考えたレシピ',
                style: GoogleFonts.zenKakuGothicNew(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 8.0),
              const Icon(
                Icons.restaurant_menu,
                color: Colors.black,
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20.0), // AppBarとの間にスペースを追加
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            dividedData.dishName,
                            style: GoogleFonts.zenKakuGothicNew(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              // 画面下部のバーを追加
              height: 60.0,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    // 丸いボタンを追加
                    backgroundColor: Colors.orange[300],
                    child: const Icon(
                      FontAwesomeIcons.bookmark,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      // ボタンの処理を記述
                    },
                  ),
                  const SizedBox(width: 20.0), // ボタンと端の間にスペースを追加
                ],
              ),
            ),
          ],
        ));
  }
}
