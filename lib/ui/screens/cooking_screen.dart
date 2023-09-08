// cooking_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:caul/status/popup.state.dart';
import 'package:caul/providers/popup_provider.dart';

final pageControllerProvider = Provider((ref) => PageController());

class CookingScreen extends ConsumerWidget {
  const CookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(popupProvider);
    final pageController = ref.watch(pageControllerProvider);

    Future<void> _showPopup() async {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return PageView.builder(
            controller: pageController, // ここでPageControllerをセット
            itemCount: 3,
            onPageChanged: (index) {
              ref.read(popupProvider.notifier).updateCurrentPage(index + 1);
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

              return _PopupPage(
                description: description,
                buttonLabel: buttonLabel,
                onPressed: onPressed,
              );
            },
          );
        },
      );
    }

    return Scaffold(
      body: Container(
        color: Colors.orange[400],
        child: Center(
          child: ElevatedButton(
            onPressed: _showPopup,
            child: const Text('料理ページを開く'),
          ),
        ),
      ),
    );
  }
}

class PopupNotifier extends StateNotifier<PopupState> {
  PopupNotifier() : super(PopupState(currentPage: 1));

  void updateCurrentPage(int page) {
    state = PopupState(currentPage: page);
  }
}

class _PopupPage extends StatelessWidget {
  final String description;
  final String buttonLabel;
  final VoidCallback onPressed;

  const _PopupPage({
    Key? key,
    required this.description,
    required this.buttonLabel,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(description),
          ElevatedButton(onPressed: onPressed, child: Text(buttonLabel)),
        ],
      ),
    );
  }
}
