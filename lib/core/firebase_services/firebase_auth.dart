import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:informat/core/exceptions/exception.dart';
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
  T toUser<T extends UserModel>() {
    return UserModel(
      id: uid,
      email: email,
      imageUrl: photoURL,
    ) as T;
  }
}
