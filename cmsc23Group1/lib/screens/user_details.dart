import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(user?.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            var userData = snapshot.data?.data() as Map<String, dynamic>?;

            if (userData == null) {
              return Text('User data not found');
            }

            bool isOrganization = userData['isOrganization'] ?? false;

            // Check if the user is an organization
            // if (!isOrganization) {
            //   return Text('You are not authorized to view this page.');
            // }

            return ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(40.0),
              children: <Widget>[
                const Text(
                  "Organization User Details",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(height: 20),
                Text("Email: ${userData['email'] ?? 'N/A'}"),
                const SizedBox(height: 10),
                Text("First Name: ${userData['firstName'] ?? 'N/A'}"),
                const SizedBox(height: 10),
                Text("Last Name: ${userData['lastName'] ?? 'N/A'}"),
              ],
            );
          },
        ),
      ),
    );
  }
}
