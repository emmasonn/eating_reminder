import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:informat/core/exceptions/exception.dart';
import 'package:informat/core/failure/failure.dart';
import 'package:informat/core/firebase_services/data_model.dart';
import 'package:informat/core/firebase_services/user_model.dart';

class CoreFirebaseAuth<T extends UserModel> {
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

  T? user;

  Future<T?> get currentUser async => _firebaseAuth.currentUser?.toUser();

  Future<T> loginWithApple() {
    throw ImplemetationError('title', 'message');
  }

  Future<T> forgottenPassword() {
    throw ImplemetationError('title', 'message');
  }

  //parameter will contain email and password
  Future<T> loginWithEmail(
    String email,
    String password,
  ) async {
    try {
      final userCred = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCred.user!.toUser();
      if (user != null) {
        return user!;
      } else {
        throw ServerException('An error occurred, try again');
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ServerException('No user found for that email, try Sign up.');
      } else if (e.code == 'wrong-password') {
        throw ServerException('You entered a wrong password.');
      } else {
        throw ServerException(e.toString());
      }
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }

  //parameter with contain email, password, fullname, others
  Future<T> registerWithEmail(String email, String password) async {
    try {
      final userCred = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCred.user!.toUser();
      if (user != null) {
        return user!;
      } else {
        throw ServerException('An error occurred, try again');
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw ServerException('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw ServerException('The account already exists for that email.');
      } else {
        throw ServerException(e.toString());
      }
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }

  //parameter will contain an OTP
  Future<T> resetPassword() {
    throw ImplemetationError('title', 'message');
  }

  //login  with firebase
  // Future<T> signWithFacebook() {
  //   try{

  //   }
  // }

  //login with google
  Future<T> loginWithGoogle() async {
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
        return user!;
      } else {
        throw ServerException('Unknown auth error');
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw CommonException(e.toString());
    } on Exception catch (e) {
      //ignore: avoid_print
      print('Unexpected loginWithGoogle Exception: $e');
      throw CommonException('Unknown auth error');
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
