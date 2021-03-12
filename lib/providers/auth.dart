import 'package:cup/screens/create_goal_screen.dart';
import 'package:cup/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth extends ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
  ]);

  Future<String> signInAnonymously() async {
    final user = await _firebaseAuth.signInAnonymously();
    return user.user.uid;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges();
  }

  Future signInWithGoogle(context) async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser.authentication;

      _googleSignIn.signIn().then((value) {
        Navigator.of(context).pushNamed(CreateGoalScreen.routeName);
      });

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final user = await _firebaseAuth.signInWithCredential(credential);
      await _firebaseAuth.signInWithCredential(credential).then((value) {
        Navigator.of(context).pushNamed(Homescreen.routeName);
      });
      notifyListeners();
      return user.user.uid;
    } catch (e) {
      print(e);
      return e;
    }
  }

  Future<String> syncWithGoogle() async {
    final anonymousUser = _firebaseAuth.currentUser;
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final user = await anonymousUser.linkWithCredential(credential);
    return user ?? user.user.uid;
  }

  Future<User> currentUser() async {
    return _firebaseAuth.currentUser;
  }
}
