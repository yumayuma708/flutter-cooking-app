import 'package:caul/data/services/recipe_saver.dart';
import 'package:caul/providers/chat_gpt_devider.dart';
import 'package:caul/ui/screens/loading_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:caul/providers/chat_gpt_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:caul/ui/screens/popup_screen/popup_page.dart';

class CookingResultPage extends StatefulWidget {
  final CookingData data;
  final ChatGPTDividedData dividedData;
  final Map<String, Set<String>> selectedHeaders;
  final List<String> selectedVegetables;

  CookingResultPage({
    Key? key,
    required this.data,
    this.selectedHeaders = const {},
    required this.selectedVegetables,
  })  : dividedData = ChatGPTDividedData.parseFromInstruction(data.instruction),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CookingResultPageState(
      selectedHeaders: selectedHeaders,
      selectedVegetables: selectedVegetables,
    );
  }
}

class CookingResultPageState extends State<CookingResultPage> {
  bool isBookmarkPressed = false;
  final recipeSaver =
      RecipeSaver(FirebaseFirestore.instance, FirebaseAuth.instance);
  final Map<String, Set<String>> selectedHeaders;
  final List<String> selectedVegetables;

  CookingResultPageState({
    Key? key,
    required this.selectedHeaders,
    required this.selectedVegetables,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.restaurant_menu,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              const SizedBox(width: 8.0),
              Text(
                'AIの考えたレシピ',
                style: TextStyle(
                    fontSize: 25,
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(width: 8.0),
              Icon(
                Icons.restaurant_menu,
                color: Theme.of(context).colorScheme.onBackground,
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
                    const SizedBox(height: 20.0),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          "【${widget.dividedData.dishName}】",
                          style: TextStyle(
                            fontSize: 25,
                            color: Theme.of(context).colorScheme.onBackground,
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
                          "目安時間：${widget.dividedData.estimatedTime}",
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.onBackground,
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
                          "材料(${widget.dividedData.numberOfPeople})",
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.onBackground,
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
                          widget.dividedData.ingredients
                              .split('\n')
                              .map((line) => '・$line')
                              .join('\n'),
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.onBackground,
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
                            style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.onBackground,
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
                          widget.dividedData.recipe,
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.onBackground,
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
                            style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.onBackground,
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
                          (widget.dividedData.appealPoint.startsWith('：') ||
                                      widget.dividedData.appealPoint
                                          .startsWith(':')
                                  ? widget.dividedData.appealPoint.substring(1)
                                  : widget.dividedData.appealPoint)
                              .trim(), // trimの適用を最後に移動
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.onBackground,
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
                  GestureDetector(
                    onTap: () {
                      List<String> timeConditions =
                          selectedHeaders["調理時間"]!.toList();
                      List<String> servingConditions =
                          selectedHeaders["人数"]!.toList();
                      List<String> cuisineConditions =
                          selectedHeaders["タイプ"]!.toList();
                      List<String> selectedSeasonings =
                          selectedHeaders["タイプ"]!.toList();
                      List<String> sizeConditions =
                          selectedHeaders["量"]!.toList();
                      List<String> preferenceConditions =
                          selectedHeaders["その他の条件"]!.toList();
                      List<String> confirmationConditions =
                          selectedHeaders["選んだ食材以外を材料に含めてもよい"]!.toList();

                      CookingData data = CookingData(
                        selectedVegetables: widget.selectedVegetables,
                        timeConditions: timeConditions,
                        servingConditions: servingConditions,
                        selectedSeasonings: selectedSeasonings,
                        cuisineConditions: cuisineConditions,
                        sizeConditions: sizeConditions,
                        preferenceConditions: preferenceConditions,
                        confirmationConditions: confirmationConditions,
                        selectedHeaders: selectedHeaders,
                        instruction: "",
                      );

                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LoadingScreen(data: data),
                      ));
                    },
                    child: const Image(
                      image: AssetImage('assets/images/renew.png'),
                      width: 30,
                      height: 30,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (FirebaseAuth.instance.currentUser != null) {
                        // ユーザーがログインしているか確認
                        setState(() {
                          isBookmarkPressed = !isBookmarkPressed;
                        });
                        if (isBookmarkPressed) {
                          await FirebaseFirestore.instance
                              .collection('recipes')
                              .doc('users')
                              .collection(
                                  FirebaseAuth.instance.currentUser!.uid)
                              .add({
                            'dishName': widget.dividedData.dishName,
                            'ingredients': widget.dividedData.ingredients,
                            // 他のデータ
                          });
                          savedPopup(context);
                        }
                      } else {
                        // ユーザーがログインしていない場合の処理
                      }
                    },
                    child: Icon(
                      isBookmarkPressed
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
