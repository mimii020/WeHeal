import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/ui/widgets/splash_animated_text.dart';
import 'package:lottie/lottie.dart';

class FirstAidPage extends StatelessWidget {
  final String animation;
  final Color color;
  final String instruction;
  const FirstAidPage({super.key, required this.animation, required this.color, required this.instruction});

  @override
  Widget build(BuildContext context) {
    return Container(
                  color: color,
                  child:Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LottieBuilder.network(animation),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                            child: SplashText(
                              text: instruction,
                              textStyle: TextStyle(color:Colors.deepPurple, fontSize: 17)
                              )
                             
                          ),
                        )
                      ],
                    ),
                  ),
                );
  }
}