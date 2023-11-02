import 'package:flutter/material.dart';
import 'package:caul/providers/chat_gpt_provider.dart';
import 'package:caul/ui/screens/cooking_screen/cooking_result_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoadingScreen extends StatefulWidget {
  final CookingData data;

  const LoadingScreen({super.key, required this.data});

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final provider = ChatGPTProvider();

    try {
      final instruction = await provider.getCookingInstruction(widget.data);
      CookingData finalData = CookingData(
        selectedVegetables: widget.data.selectedVegetables,
        selectedSeasonings: widget.data.selectedSeasonings,
        timeConditions: widget.data.timeConditions,
        servingConditions: widget.data.servingConditions,
        cuisineConditions: widget.data.cuisineConditions,
        sizeConditions: widget.data.sizeConditions,
        preferenceConditions: widget.data.preferenceConditions,
        confirmationConditions: widget.data.confirmationConditions,
        instruction: instruction,
        selectedHeaders: widget.data.selectedHeaders,
      );

      if (!mounted) return;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => CookingResultPage(
                data: finalData,
                selectedHeaders: finalData.selectedHeaders, // Add this line
                selectedVegetables:
                    finalData.selectedVegetables, // Add this line),
              )));
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "レシピを作っています...",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20.0),
          const HourglassAnimation(),
        ],
      ),
    );
  }
}

class HourglassAnimation extends StatefulWidget {
  const HourglassAnimation({super.key});

  @override
  HourglassAnimationState createState() => HourglassAnimationState();
}

class HourglassAnimationState extends State<HourglassAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();

    _animation = IntTween(begin: 0, end: 3).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<IconData> icons = [
      FontAwesomeIcons.hourglassStart,
      FontAwesomeIcons.hourglassHalf,
      FontAwesomeIcons.hourglassEnd,
      FontAwesomeIcons.hourglass,
    ];

    Color iconColor = Theme.of(context).colorScheme.onBackground;

    return Center(
        child: FaIcon(icons[_animation.value], size: 50.0, color: iconColor));
  }
}
