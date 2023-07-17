

import 'package:chat_messager_app/pages/chat_page.dart';
import 'package:chat_messager_app/services/auth/auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home_page extends StatelessWidget {

  @override
  // build individual user list
  Widget _builduserlistitem(BuildContext context,DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
    // display current user  except current user
    if (FirebaseAuth.instance.currentUser!.email != data['email']) {
      return ListTile(
        title: Row(
          children: [
            Icon(Icons.person),
          SizedBox(width: 24,),
        Text(data['email']),],),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => chat_page(ReceiverUID: data['uid'], Receiveruseremail:data['email']
          ),
          ),
          );

    }
      );
  }
else{
  return Container();
  }
}

  // to display data in the second page after login
  Widget _BuilduserList() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshots) {
          if (snapshots.hasError) {
            return const Text("ERROR");
          }
          if (snapshots.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          return ListView(
            children: snapshots.data!.docs
                .map<Widget>((doc) => _builduserlistitem(context,doc))
                .toList(),
          );
        });
  }




  Widget build(BuildContext context) {
    final AuthServices _auth = AuthServices();
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: Text("Messages"),
        actions: [
          IconButton(
            onPressed: () async {
              await _auth.signout();
            },
            icon: Icon(Icons.login_outlined),
          )
        ],
      ),
      body: _BuilduserList(),
    );
  }
}
