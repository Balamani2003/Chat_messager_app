import 'package:chat_messager_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Chat_Services extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // SEND MESSAGE
  Future<void> sendmessage(String Receiveruid, String message) async {
    // get current user info
    final String currentuserid = _auth.currentUser!.uid;
    final String currentusermail = _auth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // create message
    Message newmessage = Message(
        senderid: currentuserid,
        senderemail: currentusermail,
        receiverid: Receiveruid,
        message: message,
        timestamp: timestamp);

    // construct the chatromm id from the current user and  receiver id
    List<String> ids = [currentuserid, Receiveruid];
    ids.sort();
    String chatroomid = ids.join("_");
    //add the message in database
    await _firestore.collection("chatroom").doc(chatroomid).collection(
        'messages').add(newmessage.toMap());
  }
    //GET MESSAGES
    Stream<QuerySnapshot> getmessage(String Userid,String Otheruid) {
      // construct chatroomid with userid and otheruid
      List<String> ids=[Userid,Otheruid];
      ids.sort();
      String chatroomid=ids.join("_");
     return _firestore.collection("chatroom").doc(chatroomid).collection("messages").orderBy("timestamp",descending: false).snapshots();
    }
  }

