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
    'トマト', 'キャベツ', 'レタス', 'ほうれん草', 'にんじん',
    'じゃがいも', 'なす', 'ピーマン', 'かぼちゃ', 'ブロッコリー',
    // ... 他の野菜
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
                ? Colors.green[200]
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
