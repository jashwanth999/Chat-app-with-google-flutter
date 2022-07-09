import 'package:chat_app/providers/google_sign_in.dart';
import 'package:chat_app/screens/chat_home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = "aa";

  String password = "aa";

  CollectionReference users =
      FirebaseFirestore.instance.collection('all_users');

  void emailChanged(text) {
    setState(() {
      email = text;
    });
  }

  void passwordChanged(text) {
    setState(() {
      password = text;
    });
  }

  // sign in

  String message = "";

  void signIn() async {
    try {
      return;
    } catch (e) {
      message = e.toString();
      // }
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {},
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(23, 32, 42, 1),
        body: ChangeNotifierProvider<GoogleSignInProvider>(
            create: (context) => GoogleSignInProvider(),
            child: Consumer<GoogleSignInProvider>(
                builder: ((context, provider, child) {
              return Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    sigin_button(signIn, provider, context),
                  ],
                ),
              );
            }))));
  }

  Widget sigin_button(signIn, provider, context) {
    double width = MediaQuery.of(context).size.width / 1.5;
    return GestureDetector(
        onTap: () async {
          provider.googleLogin(context);
        },
        child: Container(
            height: 60,
            width: width,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(right: 10),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        'https://img.icons8.com/color/2x/google-logo.png'),
                  ),
                ),
                Text(
                  "Sign in with Google",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            )));
  }
}
