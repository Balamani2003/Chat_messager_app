import 'package:flutter/material.dart';
 class Mytextfield extends StatelessWidget {
   final TextEditingController controller;
   final bool obscureText;
   final String hinttext;

   const Mytextfield({super.key,required this.controller,required this.obscureText,required this.hinttext});

   @override
   Widget build(BuildContext context) {
     return TextField(
       controller: controller,
       obscureText: obscureText,
       decoration: InputDecoration(


         enabledBorder: OutlineInputBorder(
           borderSide: BorderSide(color: Colors.grey.shade300,)
         ),
         focusedBorder: OutlineInputBorder(
           borderSide: BorderSide(color: Colors.red),

         ),
         filled: true,
         fillColor: Colors.white,
         hintText:hinttext,
         hintStyle: TextStyle(color: Colors.grey)

       ),

     );
   }
 }
