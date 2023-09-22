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
            mainAxisSize: MainAxisSize.min, // この行を追加
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                    fontWeight: FontWeight.w800),
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
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          "【${dividedData.dishName}】", // 料理名を"〜"で囲む
                          style: GoogleFonts.zenKakuGothicNew(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15.0), // タイトルとの間にスペースを追加
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(FontAwesomeIcons.stopwatch),
                        const SizedBox(width: 8.0),
                        Text(
                          "目安時間：${dividedData.estimatedTime}",
                          style: GoogleFonts.zenKakuGothicNew(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        )
                      ],
                    ),
                    const SizedBox(height: 15.0), // 目安時間と材料の間にスペースを追加
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 20.0),
                        const Icon(FontAwesomeIcons.carrot,
                            size: 20), // carrot icon added
                        const SizedBox(width: 8.0), // spacing
                        Text(
                          "材料(${dividedData.numberOfPeople})",
                          style: GoogleFonts.zenKakuGothicNew(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          dividedData.ingredients
                              .split('\n')
                              .map((line) => '・$line')
                              .join('\n'),
                          style: GoogleFonts.zenKakuGothicNew(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.left, // この行を追加
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Image.asset('assets/images/knife.png',
                              width: 20, height: 20), // knife image added
                          const SizedBox(width: 8.0), // spacing
                          Text(
                            '作り方',
                            style: GoogleFonts.zenKakuGothicNew(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight:
                                  FontWeight.bold, // この行でフォントの太さを変更して「作り方」を強調
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          dividedData.recipe,
                          style: GoogleFonts.zenKakuGothicNew(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          const Icon(Icons.star, size: 20), // star icon added
                          const SizedBox(width: 8.0), // spacing
                          Text(
                            'ポイント',
                            style: GoogleFonts.zenKakuGothicNew(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight:
                                  FontWeight.bold, // この行でフォントの太さを変更して「作り方」を強調
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          (dividedData.appealPoint.startsWith('：') ||
                                      dividedData.appealPoint.startsWith(':')
                                  ? dividedData.appealPoint.substring(1)
                                  : dividedData.appealPoint)
                              .trim(), // trimの適用を最後に移動
                          style: GoogleFonts.zenKakuGothicNew(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 80.0,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.favorite_border, size: 40),
                  const Icon(Icons.favorite_border, size: 40),
                ],
              ),
            )
          ],
        ));
  }
}
