import 'package:caul/providers/chat_gpt_provider.dart';
import 'package:caul/ui/components/caul_situations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:caul/ui/screens/loading_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:caul/ui/components/caul_button.dart';

class CookingSituation extends ConsumerWidget {
  final List<String> selectedVegetables;

  final List<String> selectedSeasonings;

  const CookingSituation(
      {Key? key,
      required this.selectedVegetables,
      required this.selectedSeasonings})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CookingSituationInternal(
      selectedVegetables: selectedVegetables,
      selectedSeasonings: selectedSeasonings,
    );
  }
}

class CookingSituationInternal extends StatefulWidget {
  final List<String> selectedVegetables;
  final List<String> selectedSeasonings;

  const CookingSituationInternal({
    super.key,
    required this.selectedVegetables,
    required this.selectedSeasonings,
  });

  @override
  CookingSituationInternalState createState() =>
      CookingSituationInternalState();
}

class CookingSituationInternalState extends State<CookingSituationInternal> {
  Map<String, Set<String>> selectedHeaders = {
    "調理時間": {},
    "人数": {},
    "タイプ": {},
    "量": {},
    "その他の条件": {},
    "選んだ食材以外を材料に含めてもよい": {},
  };
  List<String> selectedVegetables = [];
  List<String> headers = [
    "調理時間",
    "人数",
    "タイプ",
    "量",
    "その他の条件",
    "選んだ食材以外を材料に含めてもよい"
  ];
  late List<List<String>> buttonGroups;

  void _toggleSelection(String header, String button) {
    if (header == "その他の条件") {
      if (button == "指定しない") {
        selectedHeaders[header]!.clear();
        selectedHeaders[header]!.add(button);
      } else {
        if (selectedHeaders[header]!.contains("指定しない")) {
          selectedHeaders[header]!.remove("指定しない");
        }
        if (selectedHeaders[header]!.contains(button)) {
          selectedHeaders[header]!.remove(button);
        } else {
          selectedHeaders[header]!.add(button);
        }
      }
    } else {
      if (selectedHeaders[header]!.contains(button)) {
        selectedHeaders[header]!.remove(button);
      } else {
        selectedHeaders[header]!.clear();
        selectedHeaders[header]!.add(button);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    buttonGroups = [
      timeOptions,
      servingSize,
      cuisineType,
      mealSize,
      preferences,
      confirmation
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          '条件を選びます',
          style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 25,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: headers.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
                      child: Row(
                        children: [
                          getIconOrImageForHeader(context, headers[index]),
                          const SizedBox(width: 10.0),
                          Text(
                            headers[index],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: const TextStyle().fontFamily,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: buttonGroups[index].map((button) {
                        bool isSelected =
                            selectedHeaders[headers[index]]!.contains(button);
                        return Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _toggleSelection(headers[index], button);
                                });
                              },
                              child: Card(
                                color: Colors.transparent,
                                elevation: 0.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground
                                          .withOpacity(0.3)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          button,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                          ),
                                        ),
                                        Icon(
                                          FontAwesomeIcons.circleCheck,
                                          color: isSelected
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .tertiary
                                              : Colors.transparent,
                                        ),
                                      ]),
                                ),
                              ),
                            ));
                      }).toList(),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: (MediaQuery.of(context).size.height / 10) * 0.7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CaulButton(
                      onPressed: () {
                        Navigator.pop(context, 'choose_ingredients');
                      },
                      label: '戻る',
                    ),
                    const SizedBox(width: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        List<String> timeConditions =
                            selectedHeaders["調理時間"]!.toList();
                        List<String> servingConditions =
                            selectedHeaders["人数"]!.toList();
                        List<String> cuisineConditions =
                            selectedHeaders["タイプ"]!.toList();
                        List<String> selectedSeasonings =
                            selectedHeaders["タイプ"]!.toList();
                        List<String> sizeConditions =
                            selectedHeaders["量"]!.toList();
                        List<String> preferenceConditions =
                            selectedHeaders["その他の条件"]!.toList();
                        List<String> confirmationConditions =
                            selectedHeaders["選んだ食材以外を材料に含めてもよい"]!.toList();

                        CookingData data = CookingData(
                          selectedVegetables: widget.selectedVegetables,
                          timeConditions: timeConditions,
                          servingConditions: servingConditions,
                          selectedSeasonings: selectedSeasonings,
                          cuisineConditions: cuisineConditions,
                          sizeConditions: sizeConditions,
                          preferenceConditions: preferenceConditions,
                          confirmationConditions: confirmationConditions,
                          selectedHeaders: selectedHeaders,
                          instruction: "",
                        );

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoadingScreen(data: data),
                        ));
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
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                              )),
                        ),
                      ),
                      child: Text(
                        "料理を作る！",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 20,
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

Widget getIconOrImageForHeader(BuildContext context, String header) {
  switch (header) {
    case "調理時間":
      return const Icon(FontAwesomeIcons.clock, size: 20.0);
    case "人数":
      return const Icon(FontAwesomeIcons.user, size: 20.0);
    case "タイプ":
      return Image.asset(
        'assets/images/curry.png',
        width: 28.0,
        height: 28.0,
        color: Theme.of(context).colorScheme.onBackground,
      );
    case "量":
      return const Icon(FontAwesomeIcons.bowlRice, size: 20.0);
    case "その他の条件":
      return const Icon(FontAwesomeIcons.kitchenSet, size: 20.0);
    case "選んだ食材以外を材料に含めてもよい":
      return const Icon(FontAwesomeIcons.commentDots, size: 20.0);
    default:
      return const SizedBox.shrink();
  }
}
