// ignore_for_file: use_build_context_synchronously, unused_element

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
        const Spacer(
          flex: 2,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(description, style: const TextStyle(fontSize: 16.0)),
        ),
        const Spacer(
          flex: 5,
        ),
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
                child: const Text(
                  '戻る',
                  style: TextStyle(color: Colors.black),
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
