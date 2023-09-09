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
                        String description;
                        String buttonLabel;
                        VoidCallback onPressed;

                        switch (index) {
                          case 0:
                            description = "これはページ1です。";
                            buttonLabel = "次へ";
                            onPressed = () => pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                            break;
                          case 1:
                            description = "これはページ2です。";
                            buttonLabel = "次へ";
                            onPressed = () => pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                            break;
                          case 2:
                            description = "これはページ3です。";
                            buttonLabel = "料理を作る！";
                            onPressed = () => Navigator.of(context).pop();
                            break;
                          default:
                            throw Exception("Invalid page index");
                        }

                        return Column(children: [
                          Text(description),
                          ElevatedButton(
                              onPressed: onPressed, child: Text(buttonLabel)),
                        ]);
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (idx) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        width: 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          color: ref.read(popupProvider).currentPage == idx + 1
                              ? Colors.blue
                              : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),
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
