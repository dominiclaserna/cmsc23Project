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
    var currentUser = auth.currentUser;
    return currentUser?.uid;
  }

  Future<String?> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // Return null to indicate success
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future<String?> signUp(
    String email,
    String password,
    String firstName,
    String lastName,
    String username,
    String contactNumber,
    List<String> addresses,
    String userType,
    String? orgName,
    String? proofs,
    bool isOrganization,
  ) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update user's display name
      await credential.user?.updateDisplayName('$firstName $lastName');
      await credential.user?.reload();

      // Save additional fields to Firestore
      User? user = auth.currentUser;
      Map<String, dynamic> userData = {
        'firstName': firstName,
        'lastName': lastName,
        'username': username,
        'email': email,
        'contactNumber': contactNumber,
        'addresses': addresses,
        'userType': userType,
        'isOrganization': isOrganization,
      };

      if (isOrganization) {
        userData['orgName'] = orgName;
        userData['proofs'] = proofs;
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .set(userData);

      return null; // Return null to indicate success
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      print(e);
      return 'unknown error';
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
