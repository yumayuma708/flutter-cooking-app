import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AlertPopup extends StatelessWidget {
  final String contentText;
  const AlertPopup({super.key, required this.contentText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.alphaBlend(
          Theme.of(context).colorScheme.error.withOpacity(0.25),
          Theme.of(context).colorScheme.background),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: Icon(FontAwesomeIcons.circleExclamation,
          size: 32, color: Theme.of(context).colorScheme.onErrorContainer),
      content: Text(
        contentText,
        style: TextStyle(color: Theme.of(context).colorScheme.onErrorContainer),
      ),
      actions: [
        Expanded(
          child: ButtonBar(
            alignment: MainAxisAlignment.center,
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
                      side: BorderSide(
                          color:
                              Theme.of(context).colorScheme.onErrorContainer),
                    ),
                  ),
                ),
                child: Text(
                  'OK',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onErrorContainer),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
