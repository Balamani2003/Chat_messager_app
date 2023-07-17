import 'package:chat_messager_app/services/auth/auth_services.dart';
import 'package:flutter/material.dart';

import '../components/my_text_field.dart';
import '../components/mybutton.dart';

class Register extends StatefulWidget {
  final void Function()? ontap;

  Register({super.key, required this.ontap});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();
  final AuthServices _auth = AuthServices();
  void signup() async {
    if (passwordcontroller.text != confirmpasswordcontroller.text) {
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PASSWORD NOT SAME')),
      );
      return;
    } else {
      try {

        await _auth.signupwithemailandpassword(
            emailcontroller.text, passwordcontroller.text);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
        ));
      }
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
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Lets's create an account for you!",
                  style: TextStyle(fontSize: 24, color: Colors.grey),
                ),
                SizedBox(
                  height: 25,
                ),
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
                SizedBox(
                  height: 10,
                ),
                Mytextfield(
                    controller: confirmpasswordcontroller,
                    obscureText: true,
                    hinttext: "Confirm Password"),
                SizedBox(
                  height: 30,
                ),
                Mybutton(text: "Sign Up", ontap: signup),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already a member?",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: widget.ontap,
                      child: Text(
                        "login now",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
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
