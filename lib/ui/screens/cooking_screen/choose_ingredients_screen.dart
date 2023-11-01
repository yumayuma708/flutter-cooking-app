import 'package:caul/ui/screens/cooking_screen/cooking_situation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:caul/status/popup.state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final pageControllerProvider = Provider((ref) => PageController());

class ChooseIngredients extends ConsumerWidget {
  const ChooseIngredients({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      appBar: AppBar(
        backgroundColor: Colors.orange[500],
        title: const Text(
          '食材を選びます',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w800),
        ),
      ),
      body: const VegetablesGridView(),
    );
  }
}

class VegetablesGridView extends StatefulWidget {
  const VegetablesGridView({super.key});

  @override
  VegetablesGridViewState createState() => VegetablesGridViewState();
}

class VegetablesGridViewState extends State<VegetablesGridView> {
  late Map<String, List<String>> categorizedIngredients;

  List<String> get categories => categorizedIngredients.keys.toList();

  @override
  void initState() {
    super.initState();
    categorizedIngredients = {
      '野菜': vegetables,
      '肉類': meats,
      '魚類': fish,
      'フルーツ': fruits,
      'スパイス': spices,
      '乳製品': dairys,
      '調味料': seasonings,
      '穀物': beans,
      'アルコール': alcohols,
      'その他': [],
    };
  }

  final List<String> vegetables = [
    'トマト',
    'にんにく',
    '玉ねぎ',
    'にんじん',
    'ピーマン',
    'じゃがいも',
    'しめじ',
    'ほうれん草',
    'マイタケ',
    'れんこん',
    'エリンギ',
    'ブロッコリー',
    '小松菜',
    'キャベツ',
    'さつまいも',
    'きゅうり',
    'パプリカ',
    'なす',
    'ズッキーニ',
    'えのき',
    'マッシュルーム',
    'コーン',
    '枝豆',
    'カリフラワー',
    'アスパラガス',
    'カボチャ',
    '大根',
    'ネギ',
    'みょうが'
  ];
  final List<String> meats = [
    '豚肉',
    '鶏むね肉',
    '鶏もも肉',
    '牛肉',
    'ウィンナー',
    'ベーコン',
    'ハム',
    '卵',
  ];
  final List<String> fish = [
    '魚',
    'エビ',
    'イカ',
    'タコ',
    'カニ',
    '牡蠣',
  ];
  final List<String> fruits = [
    'レモン',
    'ライム',
    'ブルーベリー',
    'ストロベリー',
    'バナナ',
    'メロン',
    'キウイ',
    'もも',
    'プラム',
    'マンゴー',
    'ぶどう',
    'リンゴ',
    'オレンジ',
    '柿',
    'ゆず',
    '梅',
  ];
  final List<String> spices = [
    'バジル',
    'パセリ',
    'ローズマリー',
    'タイム',
    'ハーブ',
    'オレガノ',
    'クミン',
    'カレー粉',
    '生姜',
    '山椒',
    'わさび',
    'しょうが',
    '塩',
    'こしょう',
    '乾燥わかめ',
    'ゴマ',
    'チリペッパー',
    'カレーのルー',
    'ハヤシライスのルー',
    'シチューのルー',
  ];
  final List<String> dairys = [
    'ヨーグルト',
    'クリームチーズ',
    'モッツァレラチーズ',
    'チェダーチーズ',
    '牛乳',
  ];
  final List<String> seasonings = [
    'おまかせ',
    'オリーブオイル',
    '砂糖',
    'みそ',
    '酢',
    'しょうゆ',
    'みりん',
    'だし',
    'ごま油',
    'マヨネーズ',
    'サラダ油',
    'バター',
    'チリソース',
    'ケチャップ',
  ];
  final List<String> beans = [
    '納豆',
    '豆腐',
    'おから',
    'レンズ豆',
    '栗',
    'くるみ',
  ];
  final List<String> alcohols = [
    'ワイン',
    '白ワイン',
    '赤ワイン',
    'ビール',
  ];
  final TextEditingController _otherController = TextEditingController();

  List<String> selectedIngredients = [];
  List<String> selectedSeasonings = [];

  void toggleSeasoning(String seasoning) {
    setState(() {
      // 「おまかせ」が押された場合の処理
      if (seasoning == 'おまかせ') {
        if (selectedSeasonings.contains(seasoning)) {
          // 「おまかせ」が既に選択されていれば、選択を解除
          selectedSeasonings.remove(seasoning);
        } else {
          // 他の調味料の選択を全て解除し、おまかせだけを選択状態にする
          selectedSeasonings.clear();
          selectedSeasonings.add(seasoning);
        }
      } else {
        // 「おまかせ」が選択されていれば解除
        selectedSeasonings.remove('おまかせ');

        // 押された調味料がすでに選択されていれば、選択を解除。そうでなければ、選択を追加
        if (selectedSeasonings.contains(seasoning)) {
          selectedSeasonings.remove(seasoning);
        } else {
          selectedSeasonings.add(seasoning);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 20.0), // 追加: AppBarとVegetablesGridViewの間の隙間
      Expanded(
          child: ListView.builder(
              itemCount: categories.length + 1,
              itemBuilder: (context, index) {
                // 最後のアイテムの場合、ボタンを返す
                if (index == categories.length) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(1.0, 10.0, 0.0, 10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      height: (MediaQuery.of(context).size.height / 10) * 0.4,
                      child: ElevatedButton(
                        onPressed: () {
                          if (selectedIngredients.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  // ポップアップの角を丸くする
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  backgroundColor: Colors.orange[200],
                                  // タイトルをアイコンに変更
                                  title: const Icon(
                                    FontAwesomeIcons.circleExclamation,
                                    color: Colors.black,
                                    size: 32,
                                  ),
                                  content: const Text('食材を最低１つは追加してください'),
                                  actions: [
                                    // OKボタンを中央揃えにするためのExpandedとColumnを使用
                                    Expanded(
                                      child: ButtonBar(
                                        alignment: MainAxisAlignment
                                            .center, // ボタンを中央に配置
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.transparent),
                                              elevation: MaterialStateProperty
                                                  .resolveWith<double>(
                                                (Set<MaterialState> states) {
                                                  if (states.contains(
                                                      MaterialState.pressed)) {
                                                    return 0.0;
                                                  }
                                                  return 0.0;
                                                },
                                              ),
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  side: const BorderSide(
                                                      color:
                                                          Colors.orangeAccent),
                                                ),
                                              ),
                                            ),
                                            child: const Text(
                                              'OK',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            debugPrint(
                                '選択された食材: ${selectedIngredients.join(' , ')}\n'
                                '選択された調味料: ${selectedSeasonings.join(' , ')}');
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (context, animation,
                                        secondaryAnimation) =>
                                    CookingSituation(
                                        selectedVegetables: selectedIngredients,
                                        selectedSeasonings: selectedSeasonings),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeInOut;
                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));
                                  var offsetAnimation = animation.drive(tween);
                                  return SlideTransition(
                                      position: offsetAnimation, child: child);
                                },
                              ),
                            );
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          elevation: MaterialStateProperty.all<double>(0.0),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side:
                                  const BorderSide(color: Colors.orangeAccent),
                            ),
                          ),
                        ),
                        child: const Text(
                          "条件選択へ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  );
                }

                // それ以外の場合、カテゴリーの食材を表示
                String category = categories[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: [
                          _getIconOrImageForCategory(
                              category), // この関数でカテゴリーに応じたアイコンまたは画像を取得します
                          const SizedBox(width: 8.0), // アイコンとheaderの間の隙間
                          Text(
                            category,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    if (category == '調味料')
                      const Padding(
                        padding:
                            EdgeInsets.only(left: 20.0, top: 5.0, bottom: 10.0),
                        child: Text("指定しない場合は'おまかせ'を選べます",
                            style: TextStyle(
                              fontSize: 16.0,
                            )),
                      ),
                    if (category == 'その他') // 新しい部分の追加
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _otherController,
                                cursorColor: Colors.black, // カーソルの色をオレンジに変更
                                decoration: const InputDecoration(
                                  labelText: '食材を追加',
                                  labelStyle: TextStyle(
                                      color: Colors.black), // ラベルの色をオレンジに変更
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.orange),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 1.0),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  String newIngredient = _otherController.text;
                                  if (newIngredient.isNotEmpty &&
                                      !categorizedIngredients['その他']!
                                          .contains(newIngredient)) {
                                    categorizedIngredients['その他']!
                                        .add(newIngredient);
                                    selectedIngredients
                                        .add(newIngredient); // この部分を変更
                                  }
                                  _otherController.clear(); // テキストフィールドの内容をクリア
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                        childAspectRatio: 3.0,
                      ),
                      itemCount: categorizedIngredients[category]!.length,
                      itemBuilder: (context, idx) {
                        String ingredient =
                            categorizedIngredients[category]![idx];
                        return InkWell(
                          onTap: () {
                            setState(() {
                              if (category == '調味料') {
                                if (ingredient == 'おまかせ') {
                                  selectedSeasonings.clear();
                                  selectedSeasonings.add('おまかせ');
                                } else {
                                  selectedSeasonings.remove('おまかせ');
                                  if (selectedSeasonings.contains(ingredient)) {
                                    selectedSeasonings.remove(ingredient);
                                  } else {
                                    selectedSeasonings.add(ingredient);
                                  }
                                }
                              } else {
                                if (selectedIngredients.contains(ingredient)) {
                                  selectedIngredients.remove(ingredient);
                                } else {
                                  selectedIngredients.add(ingredient);
                                }
                              }
                            });
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Card(
                            color: category == '調味料'
                                ? selectedSeasonings.contains(ingredient)
                                    ? Colors.orange[200]
                                    : Colors.transparent
                                : selectedIngredients.contains(ingredient)
                                    ? Colors.orange[200]
                                    : Colors.transparent,
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side:
                                  const BorderSide(color: Colors.orangeAccent),
                            ),
                            child: Center(
                              child: Text(
                                ingredient,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: ingredient == 'モッツァレラチーズ'
                                      ? 13.0
                                      : ingredient == 'ハヤシライスのルー'
                                          ? 13.0
                                          : 14.0,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              }))
    ]);
  }
}

class PopupNotifier extends StateNotifier<PopupState> {
  PageController pageController = PageController();

  PopupNotifier() : super(PopupState(currentPage: 1));

  void updateCurrentPage(int page) {
    state = PopupState(currentPage: page);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

Widget _getIconOrImageForCategory(String category) {
  switch (category) {
    case '野菜':
      return const Icon(FontAwesomeIcons.carrot, size: 20.0);
    case '肉類':
      return Image.asset('assets/images/meat.png', width: 20.0, height: 20.0);
    case '魚類':
      return const Icon(FontAwesomeIcons.fish, size: 20.0);
    case 'フルーツ':
      return Image.asset('assets/images/fruit.png', width: 20.0, height: 20.0);
    case 'スパイス':
      return const Icon(FontAwesomeIcons.pepperHot, size: 20.0);
    case '乳製品':
      return const Icon(FontAwesomeIcons.cheese, size: 20.0);
    case '穀物':
      return Image.asset('assets/images/rice.png', width: 20.0, height: 20.0);
    case 'アルコール':
      return const Icon(FontAwesomeIcons.martiniGlass, size: 20.0);
    case '調味料':
      return Image.asset('assets/images/salt.png', width: 20.0, height: 20.0);
    case 'その他':
      return const Icon(FontAwesomeIcons.comment, size: 20.0);
    default:
      return const Icon(FontAwesomeIcons.circleQuestion,
          size: 20.0); // 予期しないカテゴリーの場合のデフォルトのアイコン
  }
}
