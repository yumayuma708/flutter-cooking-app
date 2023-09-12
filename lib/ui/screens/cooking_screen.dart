// cooking_screen.dart

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
        backgroundColor: Colors.orange[400], // <-- 背景色をオレンジに
        title: Text(
          '食材を選ぶ',
          style: TextStyle(color: Colors.black), // <-- テキストカラーを黒に
        ),
      ),
      body: VegetablesGridView(), // <-- GridViewに変更
      backgroundColor: Colors.orange[400], // <-- 背景色をオレンジに
    );
  }
}

class VegetablesGridView extends StatefulWidget {
  @override
  _VegetablesGridViewState createState() => _VegetablesGridViewState();
}

class _VegetablesGridViewState extends State<VegetablesGridView> {
  // 人気の野菜のリスト
  List<String> vegetables = [
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
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // <-- 一列に3つ並べる
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
                : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // <-- 楕円の形状
            ),
            child: Center(
              child: Text(vegetables[index]),
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
