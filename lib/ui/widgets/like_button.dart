import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  final bool isLiked;
  final void Function()? onTap
;  const LikeButton({super.key, required this.isLiked,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap, 
      icon: isLiked? Icon(Icons.favorite): Icon(Icons.favorite_outline),
      color: Colors.deepPurple,
      );
  }
}