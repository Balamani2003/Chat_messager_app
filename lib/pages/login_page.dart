import 'package:chat_messager_app/services/auth/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:chat_messager_app/pages/register_page.dart';
import 'package:flutter/material.dart';

import '../components/my_text_field.dart';
import '../components/mybutton.dart';

class login_page extends StatefulWidget {
 final void Function()? ontap;
  login_page({required this.ontap});
  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();


  void signin() async{
final authservices=Provider.of<AuthServices>(context,listen: false);
try{
  await authservices.signinwithemailandpassword(emailcontroller.text, passwordcontroller.text);
}
catch(e){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(e.toString())));
}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Icon(
                  Icons.message_rounded,
                  size: 120,
                  color: Colors.blue,
                ),
                SizedBox(height: 40,),
                Text("Welcome back you\'ve been missed!",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey
                  ),
                ),
                SizedBox(height: 25,),
                Mytextfield(
                    controller: emailcontroller,
                    obscureText: false,
                    hinttext: "Email"),
                SizedBox(
                  height: 10,
                ),
                Mytextfield(
                    controller: passwordcontroller,
                    obscureText: true,
                    hinttext: "Password"),
                SizedBox(height: 30,),
                Mybutton(text: "Sign in", ontap:signin),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not a member?",style: TextStyle(                        fontSize: 15
                    ),),
                    SizedBox(width: 8,),
                    GestureDetector(
                      onTap: widget.ontap,
                      child: Text("Register now",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                      ),),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
