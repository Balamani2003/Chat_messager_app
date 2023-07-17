import 'package:chat_messager_app/services/auth/auth_gate.dart';
import 'package:chat_messager_app/services/auth/auth_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chat_messager_app/services/auth/loginorregister.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyBrRmZWdgRwM-NYW2PCkZvxRQPyZ4eTwlQ',
      appId: '1:82686451600:android:0971e7ff34da4cd5629d15',
      projectId: 'chat-app-68a8b',
      messagingSenderId: '82686451600',
    ),
  );
  runApp(
    ChangeNotifierProvider(create: (context)=>AuthServices(),

      child:MyApp()));
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: auth_gate());
  }
}
