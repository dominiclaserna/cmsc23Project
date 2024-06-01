import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:week9/themedata.dart'; // Adjust the import according to your file structure

class AllDonationDrivesPage extends StatefulWidget {
  @override
  _AllDonationDrivesPageState createState() => _AllDonationDrivesPageState();
}

class _AllDonationDrivesPageState extends State<AllDonationDrivesPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _addDonationDrive(String driveName, String owner) async {
    try {
      await _firestore.collection('donationDrives').add({
        'driveName': driveName,
        'owner': owner,
        'open': true, // Setting "open" field to true by default
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

  Future<void> _toggleDriveOpenStatus(String driveId, bool isOpen) async {
    try {
      await _firestore.collection('donationDrives').doc(driveId).update({
        'open': isOpen,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Donation drive status updated')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating donation drive status: $e')),
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

  void _navigateToDonationsPage(String driveName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DonationsPage(driveName: driveName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: appTheme,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('All Donation Drives'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('donationDrives').snapshots(),
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
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      _navigateToDonationsPage(drive['driveName']);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      elevation: 4.0,
                      child: ListTile(
                        title: Text('Drive Name: ${drive['driveName']}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Managed by: ${drive['owner']}'),
                            Text('Open: ${drive['open']}'),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                  drive['open'] ? Icons.lock_open : Icons.lock),
                              onPressed: () {
                                _toggleDriveOpenStatus(
                                    drives[index].id, !drive['open']);
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
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final TextEditingController nameController =
                TextEditingController();
            final TextEditingController organizationEmailController =
                TextEditingController();

            await showDialog<String>(
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
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: organizationEmailController,
                        decoration: const InputDecoration(
                          labelText: 'Organization Email',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
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
      ),
    );
  }
}

class DonationsPage extends StatelessWidget {
  final String driveName;

  const DonationsPage({Key? key, required this.driveName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Theme(
      data: appTheme,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Donations for $driveName'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('donations')
              .where('driveName', isEqualTo: driveName)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final donations = snapshot.data!.docs;

            if (donations.isEmpty) {
              return Center(child: Text('No donations found.'));
            }

            return ListView.builder(
              itemCount: donations.length,
              itemBuilder: (context, index) {
                final donation =
                    donations[index].data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    elevation: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Donation ID: ${donations[index].id}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          Text('Sender: ${donation['sender']}'),
                          Text('Receiver: ${donation['receiver']}'),
                          Text(
                              'Categories: ${donation['categories'].join(', ')}'),
                          Text('Pickup Type: ${donation['pickupType']}'),
                          Text('Weight: ${donation['weight']}'),
                          Text('Address: ${donation['address']}'),
                          Text('Contact Number: ${donation['contactNumber']}'),
                          Text('Date: ${donation['dateTime'].toDate()}'),
                          Text('Cancelled: ${donation['isCancelled']}'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Status: ${donation['status']}',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _showStatusDialog(
                                      context, donations[index].id);
                                },
                                child: Text('Change Status'),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showStatusDialog(BuildContext context, String donationId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildStatusButton(context, donationId, 'Approved'),
              _buildStatusButton(context, donationId, 'Pending'),
              _buildStatusButton(context, donationId, 'Rejected'),
            ],
          ),
        );
      },
    );
  }

  ElevatedButton _buildStatusButton(
      BuildContext context, String donationId, String status) {
    return ElevatedButton(
      onPressed: () {
        _updateDonationStatus(donationId, status);
        Navigator.of(context).pop();
      },
      child: Text(status),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  void _updateDonationStatus(String donationId, String newStatus) {
    FirebaseFirestore.instance
        .collection('donations')
        .doc(donationId)
        .update({'status': newStatus});
  }
}
