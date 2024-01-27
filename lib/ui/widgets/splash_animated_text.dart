import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class SplashText extends StatelessWidget {
  final String text;
  
  final TextStyle textStyle;
  const SplashText({super.key, required this.text, required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      totalRepeatCount: 1,
      animatedTexts: [
        TyperAnimatedText(
        text,
        textStyle: textStyle,
        textAlign: TextAlign.center,
        ),
        
      ]
    );
  }
}