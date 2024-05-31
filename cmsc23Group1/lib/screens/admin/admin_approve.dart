import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/main.dart'; // Import your main.dart to access CustomAppBar
import 'package:week9/models/user.dart'; // Import the User model

class AdminApproverPage extends StatefulWidget {
  @override
  _AdminApproverPageState createState() => _AdminApproverPageState();
}

class _AdminApproverPageState extends State<AdminApproverPage> {
  String _selectedUserType = ''; // Store the selected user type

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(), // Include the CustomAppBar here
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('proofs', isGreaterThan: '')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final approvers = snapshot.data!.docs;

          if (approvers.isEmpty) {
            return Center(child: Text('No approvers found.'));
          }

          return ListView.builder(
            itemCount: approvers.length,
            itemBuilder: (context, index) {
              final approver = approvers[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text('Approver ID: ${approvers[index].id}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Name: ${approver['firstName']} ${approver['lastName']}'),
                    Text('Email: ${approver['email']}'),
                    Text('Proof: ${approver['proofs']}'),
                    Text('Status: ${approver['userType']}'),
                    SizedBox(height: 10), // Add spacing
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Function to update user type
                            _updateUserType(
                                approvers[index].id, _selectedUserType);
                          },
                          child: Text('Update UserType'),
                        ),
                        SizedBox(width: 10), // Add spacing
                        DropdownButton<String>(
                          value: _selectedUserType.isNotEmpty
                              ? _selectedUserType
                              : null,
                          hint: Text('Select UserType'),
                          onChanged: (newValue) {
                            setState(() {
                              _selectedUserType = newValue!;
                            });
                          },
                          items: <String>['donor', 'organization']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _updateUserType(String userId, String userType) {
    // Update the userType in Firestore
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'userType': userType}).then((value) {
      // Show success message or perform any other actions
      print('UserType updated successfully!');
    }).catchError((error) {
      // Show error message or perform any other actions
      print('Failed to update UserType: $error');
    });
  }
}
