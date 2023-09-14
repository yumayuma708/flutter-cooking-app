import 'package:caul/providers/chat_gpt_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:caul/ui/screens/loading_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CookingSituation extends ConsumerWidget {
  CookingSituation({Key? key}) : super(key: key);

// 配列１: 時間に関する要素
  final List<String> timeOptions = ['30分以内', '1時間以内', '1.5時間以内', '指定しない'];

// 配列２: 人数に関する要素
  final List<String> servingSize = ['1人分', '2人分', '3人分', '4人分'];

// 配列３: 料理のジャンルに関する要素
  final List<String> cuisineType = ['和食', '洋食', '中華', 'イタリアン', '指定しない'];

// 配列４: 量に関する要素
  final List<String> mealSize = ['軽め', 'がっつり', '指定しない'];

// 配列５: その他の要素
  final List<String> preferences = [
    '短い時間で',
    '洗い物少なく',
    'お弁当用',
    'ヘルシー',
    '筋トレ食',
    '完全食',
    '指定しない'
  ];

// 配列６: 確認に関する要素
  final List<String> confirmation = ['はい', 'いいえ'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      child: _CookingSituationInternal(
        timeOptions: timeOptions,
        servingSize: servingSize,
        cuisineType: cuisineType,
        mealSize: mealSize,
        preferences: preferences,
        confirmation: confirmation,
      ),
    );
  }
}

class _CookingSituationInternal extends StatefulWidget {
  final List<String> timeOptions;
  final List<String> servingSize;
  final List<String> cuisineType;
  final List<String> mealSize;
  final List<String> preferences;
  final List<String> confirmation;

  _CookingSituationInternal({
    required this.timeOptions,
    required this.servingSize,
    required this.cuisineType,
    required this.mealSize,
    required this.preferences,
    required this.confirmation,
  });

  @override
  _CookingSituationInternalState createState() =>
      _CookingSituationInternalState();
}

class _CookingSituationInternalState extends State<_CookingSituationInternal> {
  Set<String> selectedButtons = {};
  List<String> selectedVegetables = [];
  List<String> headers = [
    "調理時間",
    "人数",
    "タイプ",
    "量",
    "その他の条件",
    "選んだ食材以外を材料に含めてもよい"
  ];
  late List<List<String>> buttonGroups;

  @override
  void initState() {
    super.initState();
    buttonGroups = [
      widget.timeOptions,
      widget.servingSize,
      widget.cuisineType,
      widget.mealSize,
      widget.preferences,
      widget.confirmation
    ];
  }

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
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: headers.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
                      child: Text(
                        headers[index],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.zenKakuGothicNew()
                              .fontFamily, // フォントを追加
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // この行を追加
                      children: buttonGroups[index].map((button) {
                        bool isSelected = selectedButtons.contains(button);
                        return Align(
                            alignment: Alignment.centerLeft, // この行を追加
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (isSelected) {
                                    selectedButtons.remove(button);
                                  } else {
                                    selectedButtons.add(button);
                                  }
                                });
                              },
                              child: Card(
                                color: Colors.transparent,
                                elevation: 0.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side: const BorderSide(
                                      color: Colors.orangeAccent),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          button,
                                          style: GoogleFonts.zenKakuGothicNew(
                                              color: Colors.black),
                                        ),
                                        Icon(
                                          FontAwesomeIcons
                                              .circleCheck, // FontAwesomeのアイコンを追加
                                          color: isSelected
                                              ? Colors.black
                                              : Colors.transparent,
                                        ),
                                      ]),
                                ),
                              ),
                            ));
                      }).toList(),
                    ),
                  ],
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
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        elevation: MaterialStateProperty.resolveWith<double>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed))
                              return 0.0;
                            return 0.0;
                          },
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: const BorderSide(color: Colors.orangeAccent),
                          ),
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
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        elevation: MaterialStateProperty.resolveWith<double>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed))
                              return 0.0;
                            return 0.0;
                          },
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: const BorderSide(color: Colors.orangeAccent),
                          ),
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
