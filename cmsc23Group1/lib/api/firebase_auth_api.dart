import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthAPI {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> getUser() {
    return auth.authStateChanges();
  }

  Future<User?> getCurrentUser() async {
    return auth.currentUser;
  }

  String? getUserUID() {
    var currentUser = auth.currentUser; //get current user
    return currentUser?.uid; // return the uid of current user
  }

  Future<String?> signIn(String email, String password) async {
    UserCredential credential;
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      //let's print the object returned by signInWithEmailAndPassword
      //you can use this object to get the user's id, email, etc.
      print(credential);
    } on FirebaseAuthException catch (e) {
      // if (e.code == 'user-not-found') {
      //possible to return something more useful
      //than just print an error message to improve UI/UX
      //   print('No user found for that email.');
      // } else if (e.code == 'wrong-password') {
      //   print('Wrong password provided for that user.');
      // }
      return e.code;
    }
  }

  Future<String?> signUp(String email, String password, String firstName,
      String lastName, bool isOrganization) async {
    UserCredential credential;
    try {
      credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update user's display name
      await credential.user?.updateDisplayName('$firstName $lastName');
      await credential.user?.reload();

      // Save additional fields to Firestore
      var user = await auth.currentUser;
      await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'isOrganization': isOrganization,
      });

      return null;
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      print(e);
      return ('unknown error');
    }
  }

  Future<void> signOut() async {
    auth.signOut();
  }
}
