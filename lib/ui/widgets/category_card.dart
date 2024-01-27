import 'package:flutter/material.dart';
import 'package:health_care_app/ui/screens/doctor_screen.dart';
import 'package:health_care_app/ui/screens/first_screen.dart';

class CategoryWidget extends StatefulWidget {
  final icon;
  final categoryName;
  const CategoryWidget({super.key, required this.categoryName, required this.icon});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color:Color(0xffFFDDEE),
                        ),
                        child: Row(
                          children: [
                           Image.network(widget.icon, height: 40,),
                           SizedBox(width: 10,),
                            Text(widget.categoryName),
                          ],
                        ),
                        ),
    );
  }
}