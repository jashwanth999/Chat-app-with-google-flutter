import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  final target_username;
  final target_userid;
  final target_profilepic;
  MessageScreen(
      {Key? key,
      @required this.target_username,
      this.target_userid,
      this.target_profilepic})
      : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final fieldText = TextEditingController();

  String message = "";

  List<dynamic> messages = [];

  User? user = FirebaseAuth.instance.currentUser;

  CollectionReference ref = FirebaseFirestore.instance.collection("all_users");

  void messageChanged(value) {
    setState(() {
      message = value;
    });
  }

  // send message function

  Future<void> sendMessage() async {
    scrollDown();
    fieldText.clear();
    var data = {
      'message': message,
      'messager_user_id': user!.uid,
      'messager_name': user!.displayName,
      "timestamp": DateTime.now(),
    };

    try {
      await ref
          .doc(user!.uid)
          .collection("chat_users")
          .doc(widget.target_userid)
          .collection("all_messages")
          .add(data);

      await ref
          .doc(widget.target_userid)
          .collection("chat_users")
          .doc(user!.uid)
          .collection("all_messages")
          .add(data);
    } catch (e) {
      print(e);
    }
  }

  ScrollController _scrollController = ScrollController(initialScrollOffset: 0);

  void scrollDown() {
    //
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  @override
  void initState() {
    super.initState();
    //this.scrollDown();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(23, 32, 42, 1),
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Row(
            children: [
              Container(
                  padding: EdgeInsets.all(5),
                  child: CircleAvatar(
                    backgroundImage:
                        NetworkImage("${widget.target_profilepic}"),
                  )),
              Text(
                widget.target_username,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: Column(children: [
          Expanded(
              child: messages_lists(context, user, widget.target_userid,
                  _scrollController, scrollDown)),
          Container(
              padding: EdgeInsets.all(2),
              color: Color.fromRGBO(23, 32, 42, 1),
              child: Row(
                children: [
                  message_input_container(messageChanged, fieldText),
                  send_message_button(sendMessage),
                ],
              ))
        ]));
  }
}

Widget message_input_container(messageChanged, fieldText) {
  return Expanded(
      child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: Colors.white,
    ),
    child: TextField(
      onChanged: messageChanged,
      controller: fieldText,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Type here ',
          contentPadding: EdgeInsets.only(left: 10)),
    ),
  ));
}

Widget send_message_button(sendMessage) {
  return GestureDetector(
      onTap: sendMessage,
      child: Container(
          margin: EdgeInsets.only(left: 2),
          alignment: Alignment.center,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
              color: Colors.deepOrangeAccent,
              borderRadius: BorderRadius.circular(50)),
          child: Icon(
            Icons.send,
            size: 30,
            color: Colors.white,
          )));
}

Widget messages_lists(
    context, user, target_userid, _scrollController, scrollDown) {
  double width = MediaQuery.of(context).size.width / 1.5;
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("all_users")
          .doc(user!.uid)
          .collection("chat_users")
          .doc(target_userid)
          .collection("all_messages")
          .orderBy("timestamp")
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
            controller: _scrollController,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return Align(
                  alignment: snapshot.data!.docs[index]['messager_user_id'] !=
                          user!.uid
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                    constraints: BoxConstraints(maxWidth: width),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin:
                          EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 1),
                      decoration: BoxDecoration(
                          color: snapshot.data!.docs[index]['messager_user_id'] !=
                                  user!.uid
                              ? Colors.white
                              : Colors.deepOrange,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              topLeft: Radius.circular(snapshot.data!.docs[index]
                                          ['messager_user_id'] !=
                                      user!.uid
                                  ? 0
                                  : 10),
                              topRight: Radius.circular(snapshot.data!
                                          .docs[index]['messager_user_id'] !=
                                      user!.uid
                                  ? 10
                                  : 0))),
                      child: Text(snapshot.data!.docs[index]['message'],
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: snapshot.data!.docs[index]
                                          ['messager_user_id'] ==
                                      user!.uid
                                  ? Colors.white
                                  : Colors.black)),
                    ),
                  ));
            });
      });
}
