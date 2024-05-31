import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/main.dart'; // Import your main.dart to access CustomAppBar
import 'package:week9/api/org_api.dart'; // Import the API

class OrgProfilePage extends StatefulWidget {
  @override
  _OrgProfilePageState createState() => _OrgProfilePageState();
}

class _OrgProfilePageState extends State<OrgProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? orgData;
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchOrganizationData();
  }

  Future<void> fetchOrganizationData() async {
    if (user != null) {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: user!.email)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          orgData = querySnapshot.docs.first.data() as Map<String, dynamic>;
          _descriptionController.text = orgData!['description'] ?? '';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Implement logout functionality
            },
          ),
        ],
      ),
      body: user == null
          ? Center(child: Text('No user logged in'))
          : orgData == null
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Organization Name: ${orgData!['orgName'] ?? 'Not available'}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'About the Organization:',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          hintText: 'Enter organization description...',
                        ),
                        maxLines: null,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Current Description: ${orgData!['description'] ?? 'No description available'}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Accepting Donations:',
                            style: TextStyle(fontSize: 16),
                          ),
                          Checkbox(
                            value: orgData!['acceptingDonations'] ?? false,
                            onChanged: (bool? value) {
                              setState(() {
                                orgData!['acceptingDonations'] = value;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Save changes to organization profile
                          saveOrganizationProfile();
                        },
                        child: Text('Save'),
                      ),
                    ],
                  ),
                ),
    );
  }

  void saveOrganizationProfile() {
    if (user != null) {
      final newDescription = _descriptionController.text.isNotEmpty
          ? _descriptionController.text
          : 'No description provided';

      final acceptingDonations = orgData!['acceptingDonations'] ?? false;

      OrganizationAPI.updateOrganizationDescription(
          user!.email!, newDescription, acceptingDonations);
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}
