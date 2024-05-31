import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:week9/api/firebase_auth_api.dart';

class AuthProvider with ChangeNotifier {
  late FirebaseAuthAPI authService;
  late Stream<firebase.User?> uStream;
  firebase.User? userObj;
  bool isOrganization = false;

  AuthProvider() {
    authService = FirebaseAuthAPI();
    fetchAuthentication();
  }

  Stream<firebase.User?> get userStream => uStream;

  void fetchAuthentication() {
    uStream = authService.getUser();

    // Update userObj when authentication state changes
    uStream.listen((firebase.User? user) async {
      userObj = user;
      if (user != null) {
        await fetchUserData(user);
      }
      notifyListeners();
    });
  }

  Future<void> fetchUserData(firebase.User user) async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    if (userDoc.exists) {
      isOrganization = userDoc['isOrganization'] ?? false;
    } else {
      isOrganization = false;
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
    String? authHandle = await authService.signUp(
      email,
      password,
      firstName,
      lastName,
      username,
      contactNumber,
      addresses,
      userType,
      orgName,
      proofs,
      isOrganization,
    );
    notifyListeners();
    return authHandle;
  }

  Future<String?> signIn(String email, String password) async {
    String? authHandle = await authService.signIn(email, password);
    notifyListeners();
    return authHandle;
  }

  Future<void> signOut() async {
    await authService.signOut();
    notifyListeners();
  }
}
