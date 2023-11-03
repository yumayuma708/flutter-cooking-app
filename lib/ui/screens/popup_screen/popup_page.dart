import 'package:flutter/material.dart';

class PopupPage extends StatelessWidget {
  final String description;
  final String buttonLabel;
  final VoidCallback onPressed;
  final bool showBackButton;
  final bool showNextButton;
  final PageController pageController;
  final ValueNotifier<int> currentPageNotifier;

  const PopupPage({
    super.key,
    required this.description,
    required this.buttonLabel,
    required this.onPressed,
    required this.pageController,
    this.showBackButton = true,
    this.showNextButton = true,
    required this.currentPageNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(flex: 2),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(description,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontSize: 16.0)),
        ),
        const Spacer(flex: 5),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return ValueListenableBuilder<int>(
                valueListenable: currentPageNotifier,
                builder: (context, currentPage, _) {
                  return Container(
                    margin: const EdgeInsets.all(4.0),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: currentPage == index
                          ? Theme.of(context).colorScheme.tertiary
                          : Theme.of(context)
                              .colorScheme
                              .tertiary
                              .withOpacity(0.3),
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
                child: Text(
                  '戻る',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
              ),
            const Spacer(flex: 7),
            if (showNextButton)
              ElevatedButton(
                onPressed: onPressed,
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
                child: Text(
                  buttonLabel,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}

//保存しました。のポップアップを作成
void savedPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        // ポップアップの角を丸くする
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        backgroundColor: Colors.orange[100],
        // タイトルをアイコンに変更
        title: const Icon(
          Icons.bookmark,
          color: Colors.black,
          size: 40,
        ),
        content: const Text(
          'レシピを保存しました！',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        actions: [
          // OKボタンを中央揃えにするためのExpandedとColumnを使用
          Expanded(
            child: ButtonBar(
              alignment: MainAxisAlignment.center, // ボタンを中央に配置
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    elevation: MaterialStateProperty.resolveWith<double>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return 0.0;
                        }
                        return 0.0;
                      },
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(color: Colors.orangeAccent),
                      ),
                    ),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
            ),
          ),
        ],
      );
    },
  );
}
