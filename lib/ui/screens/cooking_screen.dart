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
        title: const Text('食材を選ぶ'), // <-- 追加: タイトル
      ),
      body: VegetablesListView(), // <-- 追加: リストビュー
    );
  }
}

class VegetablesListView extends StatefulWidget {
  @override
  _VegetablesListViewState createState() => _VegetablesListViewState();
}

class _VegetablesListViewState extends State<VegetablesListView> {
  // 野菜のリストを作成
  List<String> vegetables = List.generate(50, (index) => '野菜$index');
  List<String> selectedVegetables = []; // <-- 追加: 選択された野菜を保存するリスト

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
            child: ListTile(
              title: Text(vegetables[index]),
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
