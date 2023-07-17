import 'package:chat_messager_app/services/auth/loginorregister.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../pages/home_page.dart';

class auth_gate extends StatefulWidget {
  const auth_gate({super.key});

  @override
  State<auth_gate> createState() => _auth_gateState();
}

class _auth_gateState extends State<auth_gate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context,snapshots){
      if(snapshots.hasData){
        return Home_page();
      }
      else{
        return loginorregister();
      }
    },);
  }
}
