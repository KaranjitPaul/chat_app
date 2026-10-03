import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  // The v7 API exposes one shared Google Sign-In instance. It must be
  // initialized exactly once before interactive authentication begins.
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static Future<void>? _initialization;

  static Future<void> _initializeGoogleSignIn() {
    return _initialization ??= _googleSignIn.initialize();
  }

  /// Opens the native Google account chooser, then signs the selected account
  /// into Firebase. Google/Firebase exceptions are left for the UI to display.
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
}
