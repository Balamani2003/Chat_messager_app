
import 'package:chat_messager_app/pages/login_page.dart';
import 'package:chat_messager_app/pages/register_page.dart';
import 'package:flutter/material.dart';
class loginorregister extends StatefulWidget {
  const loginorregister({super.key});

  @override
  State<loginorregister> createState() => _loginorregisterState();
}

class _loginorregisterState extends State<loginorregister> {
  bool showsignin=true;
  void toggleview(){
    setState(() {
      showsignin=!showsignin;
    });

  }
  @override
  Widget build(BuildContext context) {

   if(showsignin){
    return  login_page(ontap: toggleview,);
    }
    else{
     return Register(ontap: toggleview,);
    }
  }
}
