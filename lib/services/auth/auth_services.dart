import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  //get current user
  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static Future<void>? _initialization;

  static Future<void> _initializeGoogleSignIn() {
    return _initialization ??= _googleSignIn.initialize();
  }

  Future<UserCredential> signInWithGoogle() async {
    if (kIsWeb) {
      return FirebaseAuth.instance.signInWithPopup(GoogleAuthProvider());
    }

    await _initializeGoogleSignIn();

    final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    return FirebaseAuth.instance.signInWithCredential(credential);
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //With Email and Password
  //sign in
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      //save user info in a seperate doc
      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        'email': email,
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sign up
  Future<UserCredential> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      //save user info in a seperate doc
      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        'email': email,
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
}
