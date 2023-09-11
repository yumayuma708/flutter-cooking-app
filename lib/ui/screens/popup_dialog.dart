// ignore_for_file: use_build_context_synchronously, unused_element

import 'package:caul/ui/screens/popup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PopupDialog {
  final BuildContext context;
  final WidgetRef ref;
  final String tabType; // <-- 追加
  final PageController pageController = PageController(initialPage: 0);
  final ValueNotifier<int> currentPageNotifier = ValueNotifier<int>(0);

  PopupDialog({
    required this.context,
    required this.ref,
    required this.tabType, // <-- 追加
  });

  String getTabDescription(int pageIndex) {
    switch (tabType) {
      case 'cook':
        return ["これは料理のページ$pageIndex+1です。", "次へ", "開始する"][pageIndex];
      case 'save':
        return ["これは保存のページ$pageIndexです。", "次へ", "はじめる"][pageIndex];
      case 'favorite':
        return ["これはお気に入りのページ$pageIndexです。", "次へ", "開始する"][pageIndex];
      case 'mypage':
        return ["これはマイページ$pageIndexです。", "次へ", "開始する"][pageIndex];
      default:
        throw Exception("Invalid tab type");
    }
  }

  String getPopupKey() {
    return 'hasShownPopup_$tabType'; // <-- 追加
  }

  Future<void> show() async {
    final prefs = await SharedPreferences.getInstance();
    final key = getPopupKey(); // <-- 変更
    final hasShownPopup = prefs.getBool(key) ?? false;

    if (!hasShownPopup) {
      await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.blueGrey[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: SizedBox(
              width: 400,
              height: 500,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: 3,
                      onPageChanged: (index) {
                        currentPageNotifier.value = index; // この行を追加
                      },
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return PopupPage(
                              description: getTabDescription(index),
                              buttonLabel: "次へ",
                              onPressed: () => pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut),
                              showBackButton: false,
                              showNextButton: true,
                              pageController: pageController,
                              currentPageNotifier: currentPageNotifier,
                            );
                          case 1:
                            return PopupPage(
                              description: getTabDescription(index),
                              buttonLabel: "次へ",
                              onPressed: () => pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut),
                              showBackButton: true,
                              showNextButton: true,
                              pageController: pageController,
                              currentPageNotifier: currentPageNotifier,
                            );
                          case 2:
                            return PopupPage(
                              description: getTabDescription(index),
                              buttonLabel: "料理を作る！",
                              onPressed: () => Navigator.of(context).pop(),
                              showBackButton: true,
                              showNextButton: true,
                              pageController: pageController,
                              currentPageNotifier: currentPageNotifier,
                            );
                          default:
                            throw Exception("Invalid page index");
                        }
                      },
                    ),
                  ),
                  // (The dots at the bottom)
                ],
              ),
            ),
          );
        },
      );
      await prefs.setBool(key, true); // <-- 変更
    }
  }
}

// 使用方法: 
// PopupDialog(context: context, ref: ref, pageController: pageController).show();
