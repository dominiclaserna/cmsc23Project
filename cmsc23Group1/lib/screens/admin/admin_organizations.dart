import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/main.dart'; // Import your main.dart to access CustomAppBar
import 'package:week9/models/user.dart'; // Import the User model

class adminallorganizationPage extends StatefulWidget {
  @override
  _adminallorganizationPageState createState() =>
      _adminallorganizationPageState();
}

class _adminallorganizationPageState extends State<adminallorganizationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(), // Include the CustomAppBar here
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('userType', isEqualTo: "organization")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final donors = snapshot.data!.docs;

          if (donors.isEmpty) {
            return Center(child: Text('No donors found.'));
          }

          return ListView.builder(
            itemCount: donors.length,
            itemBuilder: (context, index) {
              final donor = donors[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text('Organization ID: ${donors[index].id}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${donor['firstName']} ${donor['lastName']}'),
                    Text('Email: ${donor['email']}'),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
