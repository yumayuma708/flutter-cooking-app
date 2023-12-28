import 'package:caul/ui/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:caul/providers/chat_gpt_devider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SavedCookingResult extends StatelessWidget {
  final ChatGPTDividedData dividedData;

  const SavedCookingResult({Key? key, required this.dividedData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width > maxScreenWidth
            ? maxScreenWidth
            : MediaQuery.of(context).size.width,
        child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.background,
              centerTitle: true,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.restaurant_menu,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    'AIの考えたレシピ',
                    style: TextStyle(
                        fontSize: 25,
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(width: 8.0),
                  Icon(
                    Icons.restaurant_menu,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20.0),
                        Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              "【${dividedData.dishName}】",
                              style: TextStyle(
                                fontSize: 25,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(FontAwesomeIcons.stopwatch),
                            const SizedBox(width: 8.0),
                            Text(
                              "目安時間：${dividedData.estimatedTime}",
                              style: TextStyle(
                                fontSize: 20,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            )
                          ],
                        ),
                        const SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 20.0),
                            const Icon(FontAwesomeIcons.carrot, size: 20),
                            const SizedBox(width: 8.0),
                            Text(
                              "材料(${dividedData.numberOfPeople})",
                              style: TextStyle(
                                fontSize: 20,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              dividedData.ingredients
                                  .split('\n')
                                  .map((line) => '・$line')
                                  .join('\n'),
                              style: TextStyle(
                                fontSize: 18,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Image.asset('assets/images/knife.png',
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  width: 20,
                                  height: 20),
                              const SizedBox(width: 8.0),
                              Text(
                                '作り方',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              dividedData.recipe,
                              style: TextStyle(
                                fontSize: 18,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              const Icon(Icons.star, size: 20),
                              const SizedBox(width: 8.0),
                              Text(
                                'ポイント',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              (dividedData.appealPoint.startsWith('：') ||
                                          dividedData.appealPoint
                                              .startsWith(':')
                                      ? dividedData.appealPoint.substring(1)
                                      : dividedData.appealPoint)
                                  .trim(),
                              style: TextStyle(
                                fontSize: 18,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
