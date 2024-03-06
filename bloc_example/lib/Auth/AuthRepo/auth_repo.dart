import 'package:bloc_example/Auth/AuthModel/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<AuthModel?> createUserFirebase(String mail, String password) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: mail.trim(), password: password.trim());
      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        return AuthModel(
            id: firebaseUser.uid,
            email: firebaseUser.email ?? "",
            displayName: firebaseUser.displayName ?? "");
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<void> preformSignOutUser() async {
    final User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      await _firebaseAuth.signOut();
    }
  }

  Future<AuthModel?> preformSignInUser(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
              email: email.trim(), password: password.trim());

      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        return AuthModel(
            id: firebaseUser.uid,
            email: firebaseUser.email ?? "",
            displayName: firebaseUser.displayName ?? "");
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<bool> getResetPasswordLink(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (_) {
      return false;
    } catch (_) {
      return false;
    }
  }

  void getCurrentUser(Function(AuthModel?) callBack) {
    try {
      final User? firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser != null) {
        AuthModel model = AuthModel(
            id: firebaseUser.uid,
            email: firebaseUser.email ?? "",
            displayName: firebaseUser.displayName ?? "");
        callBack(model);
      } else {
        callBack(null);
      }
    } catch (_) {
      callBack(null);
    }
  }
}
