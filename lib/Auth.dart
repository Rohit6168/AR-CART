import 'package:firebase_auth/firebase_auth.dart';
import 'package:ar_cart/firebaseuser.dart';
import 'package:ar_cart/loginuser.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Convert Firebase User to custom FirebaseUser
  FirebaseUser? _firebaseUser(User? user) {
    return user != null ? FirebaseUser(uid: user.uid, email: user.email) : null;
  }

  // Stream of FirebaseUser changes
  Stream<FirebaseUser?> get user {
    return _auth.authStateChanges().map(_firebaseUser);
  }

  // Sign in anonymously
  Future<FirebaseUser?> signInAnonymous() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User? user = userCredential.user;
      return _firebaseUser(user);
    } catch (e) {
      print(e.toString());
      return FirebaseUser(code: e.toString(), uid: null);
    }
  }

  // Sign in with email and password
  Future<FirebaseUser?> signInEmailPassword(LoginUser _login) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _login.email, // Correct parameter name
        password: _login.password, // Correct parameter name
      );
      User? user = userCredential.user;
      return _firebaseUser(user);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return FirebaseUser(code: e.code, uid: null);
    }
  }

  // Register with email and password
  Future<FirebaseUser?> registerEmailPassword(LoginUser _login) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _login.email, // Correct parameter name
        password: _login.password, // Correct parameter name
      );
      User? user = userCredential.user;
      return _firebaseUser(user);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return FirebaseUser(code: e.code, uid: null);
    } catch (e) {
      print(e.toString());
      return FirebaseUser(code: e.toString(), uid: null);
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
