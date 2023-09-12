import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:caul/status/popup.state.dart';

final pageControllerProvider = Provider((ref) => PageController());

class CookingScreen extends ConsumerWidget {
  const CookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          '食材を選ぶ',
          style: TextStyle(color: Colors.black, fontSize: 35),
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
    '人参',
    'ピーマン',
    'じゃがいも',
    'しめじ',
    'ほうれん草',
    'ブロッコリー',
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
    '海老',
    'イカ',
    'タコ',
    'カニ',
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
    '桃',
    'プラム',
    'マンゴー',
    'ぶどう',
    'リンゴ',
    'オレンジ',
    '柿',
    '柚子',
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
    '醤油',
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
    'ケチャップ'
  ];

  List<String> selectedVegetables = [];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
                ? Colors.orange[800]
                : Colors.orange[200],
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
