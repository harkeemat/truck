// @dart=2.9

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:truck/network_utils/api.dart';
import 'package:truck/notification/message.dart';
import 'package:truck/screen/jobpost.dart';



/// Listens for incoming foreground messages and displays them in a list.
class MessageList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MessageList();
}

class _MessageList extends State<MessageList> {
  List<RemoteMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      setState(() {
        _messages = [..._messages, message];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_messages.isEmpty) {
      return const Text('No messages received');
    }

    return ListView.builder(
        shrinkWrap: true,
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          RemoteMessage message = _messages[index];
             // print("dfsf: ${message.data}");
          return Container(
         padding: EdgeInsets.all(2),  
          
         child: Column(
           children: [
         
             Text(message.data['sender_name'],style: const TextStyle(fontWeight: FontWeight.bold)),
 
           Text("This luggage  "+message.data['luggage']+ "pick up from "+message.data['current']+" to "+message.data['drop']+" Total Distance is "+message.data['Distance'] +" and price is 200",style: TextStyle(color: Colors.black.withOpacity(0.8))),
           Text(message.data['drop']),
         
         
         Center(
           child: Container(
                      child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FlatButton(
                      onPressed: () {
                      
                      },
                      child: Text("Cancel")
                      ),
                  FlatButton(
                      onPressed: () {
                      sumitorder(message.data);
                      },
                      child: Text("Aprrove")),
                ],
              ),
             ),
           ),
         ),
           ],
         )
         
            
         );
         
      
        });
  }
  void sumitorder(value) async {
    
  
    //print(data);
    var res = await Network().authData(value, '/make_order');
     var body = json.decode(res.body);
    // Map<String, dynamic> user = body['userData'];

     print(body);
  if(res.statusCode == 201){
      print(body['userData']);
      
      //localStorage.setString('user1', json.encode(body['userData']));
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => Jobpost()
          ),
      );
    }
  
  }
}