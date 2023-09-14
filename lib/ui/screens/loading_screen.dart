import 'package:flutter/material.dart';
import 'package:caul/providers/chat_gpt_provider.dart';
import 'package:caul/ui/screens/cooking_screen/cooking_result.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingScreen extends StatefulWidget {
  final CookingData data;

  LoadingScreen({required this.data});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final provider = ChatGPTProvider();

    try {
      final instruction =
          await provider.getCookingInstruction(widget.data); // ここを変更
      CookingData finalData = CookingData(
        selectedIngredients: widget.data.selectedIngredients,
        timeConditions: widget.data.timeConditions,
        servingConditions: widget.data.servingConditions,
        cuisineConditions: widget.data.cuisineConditions,
        sizeConditions: widget.data.sizeConditions,
        preferenceConditions: widget.data.preferenceConditions,
        confirmationConditions: widget.data.confirmationConditions,
        instruction: instruction,
      );

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => CookingResultPage(data: finalData),
      ));
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "レシピを作っています...",
            style: GoogleFonts.zenKakuGothicNew(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20.0), // この部分でテキストとアイコンの間にスペースを追加します
          HourglassAnimation(),
        ],
      ),
    );
  }
}

class HourglassAnimation extends StatefulWidget {
  @override
  _HourglassAnimationState createState() => _HourglassAnimationState();
}

class _HourglassAnimationState extends State<HourglassAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 4), // アニメーションの長さ
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
    return Center(child: FaIcon(icons[_animation.value], size: 50.0));
  }
}
