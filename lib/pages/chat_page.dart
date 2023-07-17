



import 'package:chat_messager_app/components/chat_bubble.dart';
import 'package:chat_messager_app/components/my_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/chat/chat_services.dart';
 class chat_page extends StatefulWidget {
   final String Receiveruseremail;
   final String ReceiverUID;
   const chat_page({super.key,required this.ReceiverUID,required this.Receiveruseremail});


   @override

   State<chat_page> createState() => _chat_pageState();
 }

 class _chat_pageState extends State<chat_page> {
   final TextEditingController _messagecontroller=TextEditingController();
   final FirebaseAuth _auth=FirebaseAuth.instance;
   final Chat_Services _chat_services=Chat_Services();
   void sendmessage() async {
     if (_messagecontroller.text.isNotEmpty) {
           await _chat_services.sendmessage(widget.ReceiverUID, _messagecontroller.text);
           _messagecontroller.clear();

     }
   }
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Colors.grey[200],
       appBar:  PreferredSize(
         preferredSize: Size.fromHeight(55),
         child: AppBar(
         title: Text(widget.Receiveruseremail),
           centerTitle:true,
         backgroundColor: Colors.grey[700],
         elevation: 0.0,

       ),),
       body: Column(
         children: [
           // message
           Expanded(child:
           _buildmessagelist(),
           ),
           //userinput
           _buildmessageinput(),


           const SizedBox(height: 10,)
         ],
       ),

     );
     }
     Widget _buildmessagelist(){
     return StreamBuilder(stream: _chat_services.getmessage(widget.ReceiverUID,_auth.currentUser!.uid),builder:(context, snapshot){
       if(snapshot.hasError){
         return Text('error${snapshot.error}');
       }
       if(snapshot.connectionState==ConnectionState.waiting){
         return Text('Loading....');
       }
       else{
         return ListView(
           children: snapshot.data!.docs.map((document) => _buildmessageitem(document)).toList(),

         );
       }

     }, );
     }
     Widget _buildmessageitem(DocumentSnapshot snapshot){
     Map<String,dynamic> data=snapshot.data() as Map<String,dynamic>;
     var alignment=data['senderid'] ==_auth.currentUser!.uid ? Alignment.centerRight:Alignment.centerLeft;
     var color =
     data['senderid'] == _auth.currentUser!.uid ? Colors.green : Colors.grey; // Customize the bubble color based on sender or receiver
     return Padding(
       padding: const EdgeInsets.symmetric(horizontal:16.0),
       child: Container(
         alignment: alignment,

           child: Column(
             crossAxisAlignment: (data['senderid']==_auth.currentUser!.uid)? CrossAxisAlignment.end:CrossAxisAlignment.start,
             children: [
SizedBox(height: 7),

chat_bubble(message: data['message'],color: color,)

             ],
           ),


       ),
     );

     }
   Widget _buildmessageinput(){
     return Padding(
       padding: const EdgeInsets.symmetric(horizontal: 25.0),
       child: Row(
         children: [

           Expanded(


               child: Mytextfield(


                 controller: _messagecontroller, obscureText: false,hinttext: ("Enter a message"),
               ),
             ),

SizedBox(width: 10,),
           Container(
             decoration: ShapeDecoration(
               shape: CircleBorder(),
               color: Colors.grey,
             ),
             child: IconButton(
               onPressed: sendmessage,
               icon: const Icon(
                 Icons.arrow_upward_outlined,
                 size: 40,
                 color: Colors.white,
               ),
               splashRadius: 20,
               padding: const EdgeInsets.only(right: 13,left:4),
             ),
           )


         ]
       ),
     );
   }

   }

