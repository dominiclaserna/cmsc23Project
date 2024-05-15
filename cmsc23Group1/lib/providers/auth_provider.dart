import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../api/firebase_auth_api.dart';

class AuthProvider with ChangeNotifier {
  late FirebaseAuthAPI authService;
  late Stream<User?> uStream;
  User? userObj;

  AuthProvider() {
    authService = FirebaseAuthAPI();
    fetchAuthentication();
  }

  Stream<User?> get userStream => uStream;

  void fetchAuthentication() {
    uStream = authService.getUser();

    // Update userObj when authentication state changes
    uStream.listen((User? user) {
      userObj = user;
      notifyListeners();
    });
  }

  Future<String?> signUp(
      String email, String password, String firstName, String lastName) async {
    String? authHandle =
        await authService.signUp(email, password, firstName, lastName);
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
