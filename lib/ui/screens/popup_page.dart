// ignore_for_file: use_build_context_synchronously, unused_element

import 'package:caul/providers/popup_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 新しいPopupDialogクラス
class PopupDialog {
  final BuildContext context;
  final WidgetRef ref;
  final PageController pageController;

  PopupDialog({
    required this.context,
    required this.ref,
    required this.pageController,
  });

  Future<void> show() async {
    final prefs = await SharedPreferences.getInstance();

    final hasShownPopup = prefs.getBool('hasShownPopup') ?? false;

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
                        ref
                            .read(popupProvider.notifier)
                            .updateCurrentPage(index + 1);
                      },
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return PopupPage(
                              description: "これはページ1です。",
                              buttonLabel: "次へ",
                              onPressed: () => pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut),
                              showBackButton: false,
                              showNextButton: true,
                              pageController: pageController,
                            );
                          case 1:
                            return PopupPage(
                              description: "これはページ2です。",
                              buttonLabel: "次へ",
                              onPressed: () => pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut),
                              showBackButton: true,
                              showNextButton: true,
                              pageController: pageController,
                            );
                          case 2:
                            return PopupPage(
                              description: "これはページ3です。",
                              buttonLabel: "料理を作る！",
                              onPressed: () => Navigator.of(context).pop(),
                              showBackButton: true,
                              showNextButton: false,
                              pageController: pageController,
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
      await prefs.setBool('hasShownPopup', true);
    }
  }
}

class PopupPage extends StatelessWidget {
  final String description;
  final String buttonLabel;
  final VoidCallback onPressed;
  final bool showBackButton;
  final bool showNextButton;
  final PageController pageController; // 追加: PageControllerの参照

  const PopupPage({
    super.key,
    required this.description,
    required this.buttonLabel,
    required this.onPressed,
    required this.pageController, // コンストラクタに追加
    this.showBackButton = true,
    this.showNextButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Center(child: Text(description))),
        Row(
          children: [
            if (showBackButton)
              ElevatedButton(
                onPressed: () {
                  // 戻るボタンのアクションを更新
                  pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                },
                child: const Text('戻る'),
              ),
            const Spacer(),
            if (showNextButton)
              ElevatedButton(onPressed: onPressed, child: Text(buttonLabel)),
          ],
        ),
      ],
    );
  }
}



// 使用方法: 
// PopupDialog(context: context, ref: ref, pageController: pageController).show();
