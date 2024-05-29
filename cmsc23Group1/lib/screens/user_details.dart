import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import '../providers/auth_provider.dart' as MyAppAuthProvider;

class UserDetailsPage extends StatelessWidget {
  const UserDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Accessing the current user from the custom AuthProvider
    User? user = context.watch<MyAppAuthProvider.AuthProvider>().userObj;

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Details"),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(40.0),
          children: <Widget>[
            const Text(
              "User Details",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 20),
            Text("Email: ${user?.email ?? 'N/A'}"),
            const SizedBox(height: 10),
            Text("First Name: ${user?.displayName?.split(' ')[0] ?? 'N/A'}"),
            const SizedBox(height: 10),
            Text("Last Name: ${user?.displayName?.split(' ')[1] ?? 'N/A'}"),
          ],
        ),
      ),
    );
  }
}
