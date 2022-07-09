import 'package:chat_app/screens/chat_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider with ChangeNotifier {
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin(context) async {
    try {
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        googleSignIn.signOut();
        await FirebaseAuth.instance.signOut();

        return;
      }

      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final userCredentiial = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential credential =
          await FirebaseAuth.instance.signInWithCredential(userCredentiial);

      User? firebaseUser = credential.user;

      await FirebaseFirestore.instance
          .collection("all_users")
          .doc(firebaseUser!.uid)
          .set({
        'user_name': user.displayName,
        'user_email': user.email,
        'user_id': firebaseUser.uid,
        "user_profile_pic": user.photoUrl,
        'timestamp': DateTime.now()
      });
      Navigator.push(context, MaterialPageRoute(builder: (_) => ChatHome()));
      notifyListeners();
    } catch (e) {}
  }
}
