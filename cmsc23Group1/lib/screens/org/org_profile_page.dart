// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:week9/api/org_api.dart';
import 'package:week9/themedata.dart';

class OrgProfilePage extends StatefulWidget {
  @override
  _OrgProfilePageState createState() => _OrgProfilePageState();
}

class _OrgProfilePageState extends State<OrgProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? orgData;
  final TextEditingController _descriptionController = TextEditingController();

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
          orgData = querySnapshot.docs.first.data();
          _descriptionController.text = orgData!['description'] ?? '';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: appTheme,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Organization Profile'),
        ),
        body: user == null
            ? const Center(child: Text('No user logged in'))
            : orgData == null
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      elevation: 4.0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Organization Name: ${orgData!['orgName'] ?? 'Not available'}',
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'About the Organization:',
                              style: TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _descriptionController,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Enter organization description...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                ),
                              ),
                              maxLines: null,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Current Description: ${orgData!['description'] ?? 'No description available'}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text(
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
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                saveOrganizationProfile();
                              },
                              child: const Text('Save'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
