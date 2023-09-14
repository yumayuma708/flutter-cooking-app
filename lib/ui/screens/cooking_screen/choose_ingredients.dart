import 'package:caul/ui/screens/cooking_screen/cooking_situation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:caul/status/popup.state.dart';

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
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w400),
        ),
      ),
      body: VegetablesGridView(), // ボディ部分を変更
    );
  }
}

class VegetablesGridView extends StatefulWidget {
  @override
  _VegetablesGridViewState createState() => _VegetablesGridViewState();
}

class _VegetablesGridViewState extends State<VegetablesGridView> {
  // 人気の野菜のリスト
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
    'みょうが',
    '豚肉',
    '鶏むね肉',
    '鶏もも肉',
    '牛肉',
    '魚',
    'エビ',
    'イカ',
    'タコ',
    'カニ',
    '牡蠣',
    'ウィンナー',
    'ベーコン',
    'ハム',
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
    'バジル',
    'パセリ',
    'ローズマリー',
    'タイム',
    'ヨーグルト',
    'クリームチーズ',
    'モッツァレラチーズ',
    'チェダーチーズ',
    'ハーブ',
    'オレガノ',
    'クミン',
    'カレー粉',
    'ワイン',
    '白ワイン',
    '赤ワイン',
    'ビール',
    '納豆',
    '豆腐',
    'おから',
    '生姜',
    'レンズ豆',
    '山椒',
    'わさび',
    '栗',
    '松の実',
    'くるみ',
    'しょうが',
    'オリーブオイル',
    '塩',
    'こしょう',
    '砂糖',
    'みそ',
    '酢',
    'しょうゆ',
    'みりん',
    'だし',
    '乾燥わかめ',
    'ごま油',
    'ゴマ',
    'マヨネーズ',
    'サラダ油',
    'バター',
    'チリペッパー',
    'チリソース',
    'ケチャップ',
    '牛乳',
  ];

  List<String> selectedVegetables = [];

  @override
  Widget build(BuildContext context) {
    return Column(
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
            itemCount: vegetables.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    if (selectedVegetables.contains(vegetables[index])) {
                      selectedVegetables.remove(vegetables[index]);
                    } else {
                      selectedVegetables.add(vegetables[index]);
                    }
                  });
                },
                child: Card(
                  color: selectedVegetables.contains(vegetables[index])
                      ? Colors.blueGrey[300]
                      : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Center(
                    child: Text(
                      vegetables[index],
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0), // タブとボタンの間に8.0ピクセルのスペースを追加
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: (MediaQuery.of(context).size.height / 10) * 0.4,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        CookingSituation(),
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
              child: const Text(
                "条件選択へ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
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
