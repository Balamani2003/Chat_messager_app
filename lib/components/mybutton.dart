import 'package:flutter/material.dart';
class Mybutton extends StatelessWidget {
  final String text;
  final void Function()? ontap;
  const Mybutton({super.key,required this.text,required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(

          padding:const EdgeInsets.all(25),

        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Center(
          child: Text(text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold

          ),),
        ),
        ),

      );

  }
}
