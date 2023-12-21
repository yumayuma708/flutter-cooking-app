import 'package:caul/data/services/recipe_saver.dart';
import 'package:caul/providers/chat_gpt_devider.dart';
import 'package:caul/ui/components/alert_popup.dart';
import 'package:caul/ui/screens/loading_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:caul/providers/chat_gpt_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:caul/ui/screens/popup_screen/popup_page.dart';

class CookingResultPage extends StatefulWidget {
  static const routeName = '/cooking-result';
  final CookingData data;
  final ChatGPTDividedData dividedData;
  final Map<String, Set<String>> selectedHeaders;
  final List<String> selectedVegetables;
  final bool fromLoadingScreen;

  CookingResultPage({
    Key? key,
    required this.data,
    this.selectedHeaders = const {},
    required this.selectedVegetables,
    this.fromLoadingScreen = true,
  })  : dividedData = ChatGPTDividedData.parseFromInstruction(data.instruction),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    if (FirebaseAuth.instance.currentUser != null) {
      return CookingResultPageState(
        selectedHeaders: selectedHeaders,
        selectedVegetables: selectedVegetables,
        fromLoadingScreen: fromLoadingScreen,
      );
    }
    return CookingResultPageState(
      selectedHeaders: selectedHeaders,
      selectedVegetables: selectedVegetables,
      fromLoadingScreen: fromLoadingScreen,
    );
  }
}

class CookingResultPageState extends State<CookingResultPage> {
  bool isBookmarkPressed = false;
  final recipeSaver =
      RecipeSaver(FirebaseFirestore.instance, FirebaseAuth.instance);
  final Map<String, Set<String>> selectedHeaders;
  final List<String> selectedVegetables;
  final bool fromLoadingScreen;

  CookingResultPageState({
    Key? key,
    required this.selectedHeaders,
    required this.selectedVegetables,
    required this.fromLoadingScreen,
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
                    const SizedBox(height: 15.0),
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
                    const SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 20.0),
                        const Icon(FontAwesomeIcons.carrot, size: 20),
                        const SizedBox(width: 8.0),
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
                          Image.asset('assets/images/knife.png',
                              color: Theme.of(context).colorScheme.onBackground,
                              width: 20,
                              height: 20),
                          const SizedBox(width: 8.0),
                          Text(
                            '作り方',
                            style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.onBackground,
                              fontWeight: FontWeight.bold,
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
                          const Icon(Icons.star, size: 20),
                          const SizedBox(width: 8.0),
                          Text(
                            'ポイント',
                            style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.onBackground,
                              fontWeight: FontWeight.bold,
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
                              .trim(),
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
            if (fromLoadingScreen)
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
                          cuisineType: cuisineConditions,
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
                      child: Row(
                        children: [
                          Text(
                            'もう一度',
                            style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Image(
                            image: const AssetImage('assets/images/renew.png'),
                            width: 30,
                            height: 30,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (FirebaseAuth.instance.currentUser != null) {
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
                              'recipe': widget.dividedData.recipe,
                              'estimatedTime': widget.dividedData.estimatedTime,
                              'appealPoint': widget.dividedData.appealPoint,
                              'numberOfPeople':
                                  widget.dividedData.numberOfPeople,
                            });
                            if (!mounted) return;
                            savedPopup(context);
                          }
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AlertPopup(
                                  contentText: '保存するにはログインしてください');
                            },
                          );
                        }
                      },
                      child: Row(
                        children: [
                          Text(
                            'レシピを保存',
                            style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Icon(
                            isBookmarkPressed
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ));
  }
}
