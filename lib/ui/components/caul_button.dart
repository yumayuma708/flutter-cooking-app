import 'package:flutter/material.dart';

class CaulButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const CaulButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    const seedColor = Colors.orange;

    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
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
                color: Theme.of(context)
                    .colorScheme
                    .onBackground
                    .withOpacity(0.3)),
          ),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
          fontSize: 20,
        ),
      ),
    );
  }
}
