import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:week9/screens/donation_page.dart';

class UserDetailsPage extends StatelessWidget {
  final String email;

  UserDetailsPage({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Organization Details'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: email)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('An error occurred: ${snapshot.error}'));
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text('User not found.'));
          }

          var userData =
              snapshot.data!.docs.first.data() as Map<String, dynamic>;

          return UserDetailsWidget(userData: userData);
        },
      ),
    );
  }
}

class UserDetailsWidget extends StatelessWidget {
  final Map<String, dynamic> userData;

  UserDetailsWidget({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email: ${userData['email'] ?? 'Not available'}',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Text(
            'First Name: ${userData['firstName'] ?? 'Not available'}',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Text(
            'Last Name: ${userData['lastName'] ?? 'Not available'}',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
              height: 20), // Add some space between user details and button
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DonationPage(receiverEmail: userData['email']),
                ),
              );
            },
            child: Text('Donate'),
          ),
        ],
      ),
    );
  }
}
