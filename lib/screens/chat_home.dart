import 'package:chat_app/screens/message_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ChatHome extends StatefulWidget {
  ChatHome({Key? key}) : super(key: key);

  @override
  _ChatHomeState createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  bool loading = false;
  CollectionReference ref = FirebaseFirestore.instance.collection("all_users");

  // get all users

  User? user = FirebaseAuth.instance.currentUser;

  Future getAllUsers() async {
    List<dynamic> users = [];
    try {
      final ref = FirebaseFirestore.instance.collection("all_users").get();
      await ref.then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          users.add(doc.data());
        });
      });
    } catch (e) {}

    return users;
  }

  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  void logOut() async {
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }

  List<dynamic> users = [];

  @override
  void initState() {
    super.initState();

    this.getAllUsers().then((data) => setState(() {
          users = data;
          loading = !loading;
        }));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(23, 32, 42, 1),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.deepOrangeAccent,
          leading: Container(
            padding: EdgeInsets.all(8),
            child: CircleAvatar(
              radius: 10,
              backgroundImage: NetworkImage("${user?.photoURL}"),
            ),
          ),
          title: Text(
            "Destiny",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: <Widget>[
            PopupMenuButton<int>(
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Sign out",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ],
              offset: Offset(-30, 45),
              color: Colors.white,
              elevation: 2,
              onSelected: (value) {
                if (value == 1) {
                  logOut();
                }
              },
            ),
          ],
        ),
        body: !loading
            ? Center(
                child:
                    CircularProgressIndicator(color: Colors.deepOrangeAccent),
              )
            : Stack(
                children: [
                  users_lists(),
                  Container(
                      alignment: Alignment.bottomRight,
                      padding: EdgeInsets.only(right: 30, bottom: 40),
                      child: FloatingActionButton(
                        child: Icon(Icons.add),
                        onPressed: () {},
                      )),
                ],
              ));
  }

  Widget users_lists() {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        if (users[index]['user_id'] == user!.uid) return Container();
        return GestureDetector(
            onTap: (() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => MessageScreen(
                            target_username: users[index]['user_name'],
                            target_userid: users[index]['user_id'],
                            target_profilepic: users[index]['user_profile_pic'],
                          )));
            }),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 0.3))),
              margin: EdgeInsets.only(top: 5, bottom: 3),
              padding: EdgeInsets.all(5.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage("${users[index]["user_profile_pic"]}"),
                    radius: 22,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        users[index]['user_name'].split(" ")[0],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ))
                ],
              ),
            ));
      },
    );
  }
}
