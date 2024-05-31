import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'user_details_page.dart'; // Ensure this import matches the file path
import '/main.dart'; // Import your main.dart to access CustomAppBar

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> userEmails = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(), // Include the CustomAppBar here
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'List of Organizations',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _fetchUserEmails(context);
              },
              child: Text('Fetch Organization Emails'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: userEmails.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(userEmails[index]),
                    onTap: () {
                      print(
                          'Navigating to details page for email: ${userEmails[index]}');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UserDetailsPage(email: userEmails[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _fetchUserEmails(BuildContext context) async {
    try {
      QuerySnapshot usersSnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      List<String> emails = [];
      usersSnapshot.docs.forEach((doc) {
        final email = doc['email'];
        final isOrganization = doc.exists && doc['isOrganization'] == true;

        if (email != null && isOrganization) {
          emails.add(email);
          print('Fetched email: $email');
        }
      });

      setState(() {
        userEmails = emails;
      });
    } catch (error) {
      print('Error fetching users: $error');
    }
  }
}
