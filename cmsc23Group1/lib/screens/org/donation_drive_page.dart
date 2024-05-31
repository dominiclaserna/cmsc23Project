import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DonationDrivePage extends StatefulWidget {
  @override
  _DonationDrivePageState createState() => _DonationDrivePageState();
}

class _DonationDrivePageState extends State<DonationDrivePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<DocumentSnapshot> drives = [];
  Future<void> _addDonationDrive(String name, String organizationEmail) async {
    try {
      await _firestore.collection('donationDrives').add({
        'name': name,
        'organization_email': organizationEmail,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Donation drive added')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding donation drive: $e')),
      );
    }
  }

   @override
  void initState() {
    super.initState();
    _fetchDonationDrives();
  }

  Future<void> _fetchDonationDrives() async {
  final collectionReference = _firestore.collection('donationDrives');
  final snapshot = await collectionReference.get();
  setState(() {
    drives = snapshot.docs;
  });
}

  void _showEditDialog(
  BuildContext context,
  String driveId,
  String name,
  String organizationEmail,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Edit Donation Drive'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              autofocus: true,
              controller: TextEditingController(text: name),
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              onChanged: (value) {
                // Update the name variable with the new value
                name = value;
              },
            ),
            TextField(
              controller: TextEditingController(text: organizationEmail),
              decoration: const InputDecoration(
                labelText: 'Organization Email',
              ),
              onChanged: (value) {
                // Update the organizationEmail variable with the new value
                organizationEmail = value;
              },
            ),
           
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _updateDonationDrive(driveId, name, organizationEmail);
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}

  Future<void> _updateDonationDrive(String driveId, String name, String organizationEmail) async {
    try {
      await _firestore.collection('donationDrives').doc(driveId).update({
        'name': name,
        'organization_email': organizationEmail,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Donation drive updated')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating donation drive: $e')),
      );
    }
  }

  Future<void> _deleteDonationDrive(String driveId) async {
    try {
      await _firestore.collection('donationDrives').doc(driveId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Donation drive deleted')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting donation drive: $e')),
      );
    }
  }

  
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Donation Drives'),
    ),
    body: StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('donationDrives')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final drives = snapshot.data!.docs;

        if (drives.isEmpty) {
          return const Center(child: Text('No donation drives found.'));
        }

        return ListView.builder(
          itemCount: drives.length,
          itemBuilder: (context, index) {
            final drive = drives[index].data() as Map<String, dynamic>;
            return ListTile(
              title: Text('Donation Drive ID: ${drives[index].id}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${drive['name']}'),
                  Text('Organization Email: ${drive['organization_email']}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _showEditDialog(
                        context,
                        drives[index].id,
                        drive['name'],
                        drive['organization_email'],
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _deleteDonationDrive(drives[index].id);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () async {
        final TextEditingController nameController = TextEditingController();
        final TextEditingController organizationEmailController = TextEditingController();
        
        final driveName = await showDialog<String>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('New Donation Drive'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                  ),
                  TextField(
                    controller: organizationEmailController,
                    decoration: const InputDecoration(
                      labelText: 'Organization Email',
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    _addDonationDrive(
                      nameController.text,
                      organizationEmailController.text,
                    );
                    Navigator.of(context).pop();
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
      child: const Icon(Icons.add),
    ),
  );
}
}