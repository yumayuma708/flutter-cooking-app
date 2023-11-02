import 'package:caul/ui/components/alert_popup.dart';
import 'package:caul/ui/components/caul_ingredients.dart';
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
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          '食材を選びます',
          style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 25,
              fontWeight: FontWeight.w600),
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

  final TextEditingController _otherController = TextEditingController();

  List<String> selectedIngredients = [];
  List<String> selectedSeasonings = [];

  void toggleSeasoning(String seasoning) {
    setState(() {
      if (seasoning == 'おまかせ') {
        if (selectedSeasonings.contains(seasoning)) {
          selectedSeasonings.remove(seasoning);
        } else {
          selectedSeasonings.clear();
          selectedSeasonings.add(seasoning);
        }
      } else {
        selectedSeasonings.remove('おまかせ');
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
      const SizedBox(height: 20.0),
      Expanded(
          child: ListView.builder(
              itemCount: categories.length + 1,
              itemBuilder: (context, index) {
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
                                return const AlertPopup(
                                    contentText: '食材を最低１つは追加してください');
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
                              side: BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground
                                      .withOpacity(0.3)),
                            ),
                          ),
                        ),
                        child: Text(
                          "条件選択へ",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  );
                }
                String category = categories[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: [
                          _getIconOrImageForCategory(context, category),
                          const SizedBox(width: 8.0),
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
                                decoration: InputDecoration(
                                  labelText: '食材を追加',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground
                                          .withOpacity(0.3),
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground
                                          .withOpacity(0.3),
                                      width: 2.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground
                                          .withOpacity(0.3),
                                      width: 1.0,
                                    ),
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
                                    if (selectedSeasonings
                                        .contains(ingredient)) {
                                      selectedSeasonings.remove(ingredient);
                                    } else {
                                      selectedSeasonings.add(ingredient);
                                    }
                                  }
                                } else {
                                  if (selectedIngredients
                                      .contains(ingredient)) {
                                    selectedIngredients.remove(ingredient);
                                  } else {
                                    selectedIngredients.add(ingredient);
                                  }
                                }
                              });
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Container(
                              decoration: BoxDecoration(
                                color: (category == '調味料' &&
                                            selectedSeasonings
                                                .contains(ingredient)) ||
                                        selectedIngredients.contains(ingredient)
                                    ? Theme.of(context)
                                        .colorScheme
                                        .tertiary
                                        .withOpacity(0.8)
                                    : Colors.transparent,
                                border: Border.all(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground
                                      .withOpacity(0.3), // 枠線の色
                                ),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Card(
                                color: Colors
                                    .transparent, // Containerが背景色を持っているのでCardの色は透明にする
                                elevation: 0.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Center(
                                  child: Text(
                                    ingredient,
                                    style: TextStyle(
                                      color: selectedIngredients
                                                  .contains(ingredient) ||
                                              selectedSeasonings
                                                  .contains(ingredient)
                                          ? Theme.of(context)
                                              .colorScheme
                                              .onTertiary // ボタンが押されている時
                                          : Theme.of(context)
                                              .colorScheme
                                              .onBackground, // ボタンが押されていない時
                                      fontSize: ingredient == 'モッツァレラチーズ'
                                          ? 13.0
                                          : ingredient == 'ハヤシライスのルー'
                                              ? 13.0
                                              : 14.0,
                                    ),
                                  ),
                                ),
                              ),
                            ));
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

Widget _getIconOrImageForCategory(BuildContext context, String category) {
  switch (category) {
    case '野菜':
      return const Icon(FontAwesomeIcons.carrot, size: 20.0);
    case '肉類':
      return Image.asset('assets/images/meat.png',
          width: 20.0,
          height: 20.0,
          color: Theme.of(context).colorScheme.onBackground);
    case '魚類':
      return const Icon(FontAwesomeIcons.fish, size: 20.0);
    case 'フルーツ':
      return Image.asset('assets/images/fruit.png',
          width: 20.0,
          height: 20.0,
          color: Theme.of(context).colorScheme.onBackground);
    case 'スパイス':
      return const Icon(FontAwesomeIcons.pepperHot, size: 20.0);
    case '乳製品':
      return const Icon(FontAwesomeIcons.cheese, size: 20.0);
    case '穀物':
      return Image.asset('assets/images/rice.png',
          width: 20.0,
          height: 20.0,
          color: Theme.of(context).colorScheme.onBackground);
    case 'アルコール':
      return const Icon(FontAwesomeIcons.martiniGlass, size: 20.0);
    case '調味料':
      return Image.asset('assets/images/salt.png',
          width: 20.0,
          height: 20.0,
          color: Theme.of(context).colorScheme.onBackground);
    case 'その他':
      return const Icon(FontAwesomeIcons.comment, size: 20.0);
    default:
      return const Icon(FontAwesomeIcons.circleQuestion, size: 20.0);
  }
}
