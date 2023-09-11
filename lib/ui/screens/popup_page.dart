// ignore_for_file: use_build_context_synchronously, unused_element

import 'package:caul/providers/popup_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PopupPage extends StatelessWidget {
  final String description;
  final String buttonLabel;
  final VoidCallback onPressed;
  final bool showBackButton;
  final bool showNextButton;
  final PageController pageController;
  final ValueNotifier<int> currentPageNotifier;

  PopupPage({
    super.key,
    required this.description,
    required this.buttonLabel,
    required this.onPressed,
    required this.pageController,
    this.showBackButton = true,
    this.showNextButton = true,
    required this.currentPageNotifier, // ← コンストラクタにこれも追加します
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(
          flex: 2,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(description, style: TextStyle(fontSize: 16.0)),
        ),
        const Spacer(
          flex: 5,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return ValueListenableBuilder<int>(
                // この部分をValueListenableBuilderでラップ
                valueListenable: currentPageNotifier,
                builder: (context, currentPage, _) {
                  return Container(
                    margin: const EdgeInsets.all(4.0),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: currentPage == index ? Colors.blue : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  );
                },
              );
            })),
        const SizedBox(height: 20),
        Row(
          children: [
            const Spacer(),
            if (showBackButton)
              ElevatedButton(
                onPressed: () {
                  pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                },
                child: const Text(
                  '戻る',
                  style: TextStyle(color: Colors.black),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.blueGrey.withOpacity(0.1);
                      }
                      return Colors.white;
                    },
                  ),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  elevation: MaterialStateProperty.resolveWith<double>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return 2;
                      }
                      return 5;
                    },
                  ),
                  shadowColor: MaterialStateProperty.all(Colors.black45),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            const Spacer(flex: 7),
            if (showNextButton)
              ElevatedButton(
                onPressed: onPressed,
                child: Text(
                  buttonLabel,
                  style: const TextStyle(color: Colors.black),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.blueGrey.withOpacity(0.1);
                      }
                      return Colors.white;
                    },
                  ),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  elevation: MaterialStateProperty.resolveWith<double>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return 2;
                      }
                      return 5;
                    },
                  ),
                  shadowColor: MaterialStateProperty.all(Colors.black45),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}

// 新しいPopupDialogクラス
class PopupDialog {
  final BuildContext context;
  final WidgetRef ref;
  final PageController pageController = PageController(initialPage: 0);
  final ValueNotifier<int> currentPageNotifier = ValueNotifier<int>(0);

  PopupDialog({
    required this.context,
    required this.ref,
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
                              currentPageNotifier: currentPageNotifier,
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
                              currentPageNotifier: currentPageNotifier,
                            );
                          case 2:
                            return PopupPage(
                              description: "これはページ3です。",
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
      await prefs.setBool('hasShownPopup', true);
    }
  }
}

// 使用方法: 
// PopupDialog(context: context, ref: ref, pageController: pageController).show();
