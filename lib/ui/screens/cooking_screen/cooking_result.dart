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
                          "〜${dividedData.dishName}〜", // 料理名を"〜"で囲む
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
                        Text(
                          "材料(${dividedData.numberOfPeople})", // 材料と人数を表示
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
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '作り方：',
                          style: GoogleFonts.zenKakuGothicNew(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight:
                                FontWeight.bold, // この行でフォントの太さを変更して「作り方」を強調
                          ),
                          textAlign: TextAlign.left,
                        ),
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
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'ポイント',
                          style: GoogleFonts.zenKakuGothicNew(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight:
                                FontWeight.bold, // この行でフォントの太さを変更して「作り方」を強調
                          ),
                          textAlign: TextAlign.left,
                        ),
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
              // 画面下部のバーを追加
              height: 80.0,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyFloatingActionButton(
                    backgroundColor: Colors.orange[200]!,
                    onPressed: () {
                      // ボタンの処理を記述
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(28.0), // 丸みをつけるための半径
                        side: const BorderSide(
                            color: Colors.orangeAccent, width: 2.0) // 枠の色と太さを設定
                        ),
                    child: const Icon(
                      FontAwesomeIcons.bookmark,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 20.0),
                ],
              ),
            ),
          ],
        ));
  }
}

class MyFloatingActionButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final ShapeBorder shape;
  final Color backgroundColor;

  MyFloatingActionButton({
    required this.onPressed,
    required this.child,
    required this.shape,
    required this.backgroundColor,
  });

  @override
  _MyFloatingActionButtonState createState() => _MyFloatingActionButtonState();
}

class _MyFloatingActionButtonState extends State<MyFloatingActionButton> {
  bool isPressed = false; // 追加：ボタンが押された状態を保持

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      color: Colors.transparent, // Materialの背景色を透明に
      elevation: isPressed ? 0.0 : 0.0, // 押されたときの影の高さを設定
      shadowColor: isPressed ? Colors.transparent : null, // 押されたときの影の色を白に設定
      child: FloatingActionButton(
        backgroundColor: widget.backgroundColor,
        splashColor: Colors.transparent, // 押された時の水滴エフェクトの色を透明に設定
        elevation: 0.0, // 通常時の影を削除
        focusElevation: 0.0, // フォーカス時の影を削除
        hoverElevation: 0.0, // ホバー時の影を削除
        highlightElevation: 0.0, // 押下時の影を削除
        disabledElevation: 0.0,
        shape: widget.shape,
        onPressed: () {
          widget.onPressed();
          setState(() {
            isPressed = !isPressed;
          });
        }, // 無効時の影を削除
        child: Icon(
            isPressed
                ? FontAwesomeIcons.solidBookmark
                : FontAwesomeIcons.bookmark,
            color: Colors.black),
      ),
    );
  }
}
