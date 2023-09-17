import 'package:caul/ui/screens/cooking_screen/cooking_situation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:caul/status/popup.state.dart';
import 'package:google_fonts/google_fonts.dart';

final pageControllerProvider = Provider((ref) => PageController());

class ChooseIngredients extends ConsumerWidget {
  const ChooseIngredients({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      appBar: AppBar(
        backgroundColor: Colors.orange[500],
        title: Text(
          '食材を選びます',
          style: GoogleFonts.zenKakuGothicNew(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w500),
        ),
      ),
      body: VegetablesGridView(),
    );
  }
}

class VegetablesGridView extends StatefulWidget {
  @override
  _VegetablesGridViewState createState() => _VegetablesGridViewState();
}

class _VegetablesGridViewState extends State<VegetablesGridView> {
  late Map<String, List<String>> categorizedIngredients;

  // この部分を追加します
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
    'ハム'
  ];
  final List<String> fish = ['魚', 'エビ', 'イカ', 'タコ', 'カニ', '牡蠣'];
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
    '梅'
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
    'チリペッパー'
  ];
  final List<String> dairys = [
    'ヨーグルト',
    'クリームチーズ',
    'モッツァレラチーズ',
    'チェダーチーズ',
    '牛乳'
  ];
  final List<String> seasonings = [
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
    'ケチャップ'
  ];
  final List<String> beans = ['納豆', '豆腐', 'おから', 'レンズ豆', '栗', 'くるみ'];
  final List<String> alcohols = ['ワイン', '白ワイン', '赤ワイン', 'ビール'];

  List<String> selectedVegetables = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: categories.length + 1,
        itemBuilder: (context, index) {
          // 最後のアイテムの場合、ボタンを返す
          if (index == categories.length) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: (MediaQuery.of(context).size.height / 10) * 0.4,
                child: ElevatedButton(
                  onPressed: () {
                    print('選択された食材: ${selectedVegetables.join(', ')}');
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            CookingSituation(
                                selectedVegetables: selectedVegetables),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
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
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    "条件選択へ",
                    style: GoogleFonts.zenKakuGothicNew(
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
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  category,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 3.0,
                ),
                itemCount: categorizedIngredients[category]!.length,
                itemBuilder: (context, idx) {
                  String ingredient = categorizedIngredients[category]![idx];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (selectedVegetables.contains(ingredient)) {
                          selectedVegetables.remove(ingredient);
                        } else {
                          selectedVegetables.add(ingredient);
                        }
                      });
                    },
                    child: Card(
                      color: selectedVegetables.contains(ingredient)
                          ? Colors.blueGrey[300]
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Center(
                        child: Text(
                          ingredient,
                          style:
                              GoogleFonts.zenKakuGothicNew(color: Colors.black),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        });
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
