import 'package:caul/providers/chat_gpt_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:caul/ui/screens/loading_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class CookingSituation extends ConsumerWidget {
  CookingSituation({Key? key}) : super(key: key);

  final List<String> buttons = [
    '短い時間で',
    '洗い物少なく',
    'お弁当用',
    '筋トレ食',
    '完全食',
    'カロリー少なめ',
    '軽め',
    'がっつり'
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      // Riverpodのスコープを提供
      child: _CookingSituationInternal(buttons: buttons),
    );
  }
}

class _CookingSituationInternal extends StatefulWidget {
  final List<String> buttons;
  _CookingSituationInternal({required this.buttons});

  @override
  _CookingSituationInternalState createState() =>
      _CookingSituationInternalState();
}

class _CookingSituationInternalState extends State<_CookingSituationInternal> {
  Set<String> selectedButtons = {}; // 選択されたボタンの名前を保存するSet
  List<String> selectedVegetables = []; // ここでselectedVegetablesを追加します

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      appBar: AppBar(
        backgroundColor: Colors.orange[500],
        title: Text(
          '条件を選びます',
          style: GoogleFonts.zenKakuGothicNew(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 3.0,
              ),
              itemCount: widget.buttons.length,
              itemBuilder: (context, index) {
                bool isSelected =
                    selectedButtons.contains(widget.buttons[index]);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedButtons.remove(widget.buttons[index]);
                      } else {
                        selectedButtons.add(widget.buttons[index]);
                      }
                    });
                  },
                  child: Card(
                    color: isSelected ? Colors.blueGrey[300] : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Center(
                      child: Text(
                        widget.buttons[index],
                        style:
                            GoogleFonts.zenKakuGothicNew(color: Colors.black),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: (MediaQuery.of(context).size.height / 10) * 0.7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, 'choose_ingredients');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        "戻る",
                        style: GoogleFonts.zenKakuGothicNew(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),

                    const SizedBox(width: 20.0),

                    // 料理を作る！ボタン
                    ElevatedButton(
                      onPressed: () {
                        CookingData data = CookingData(
                          selectedIngredients: selectedVegetables,
                          selectedSituations: selectedButtons.toList(),
                          instruction: "",
                        );
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoadingScreen(data: data),
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        "料理を作る！",
                        style: GoogleFonts.zenKakuGothicNew(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
