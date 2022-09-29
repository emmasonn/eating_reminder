import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:informat/core/firebase_services/data_model.dart';
import 'package:informat/core/firebase_services/user_model.dart';

class CoreFirebaseAuth<T extends DataModel> {
  // check if user has loggedIn
  CoreFirebaseAuth() {
    _firebaseAuth.userChanges().listen((firebase_auth.User? firebaseUser) {
      if (firebaseUser != null) {
        user = firebaseUser.toUser();
        //call notifyListener()
      }
    });
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn.standard();
  final firebase_auth.FirebaseAuth _firebaseAuth =
      firebase_auth.FirebaseAuth.instance;
  String? authError;
  T? user;

  Future<void> loginWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final userCred = await _firebaseAuth.signInWithCredential(credential);
      if (userCred.user != null) {
        user = userCred.user!.toUser();
      } else {
        authError = 'Unknown auth error';
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      authError = e.toString();
    } on Exception catch (e) {
      //ignore: avoid_print
      print('Unexpected loginWithGoogle Exception: $e');
      authError = 'Unknown auth error';
    }
  }

  void signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}

extension on firebase_auth.User {
  T toUser<T extends DataModel>() {
    return UserModel(
      id: uid,
      email: email,
      imageUrl: photoURL,
    ) as T;
  }
}
