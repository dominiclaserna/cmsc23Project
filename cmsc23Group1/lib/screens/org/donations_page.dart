import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/main.dart'; // Import your main.dart to access CustomAppBar
import 'package:week9/models/donation_model.dart';
import 'package:week9/api/donation_api.dart';

class DonationDetailsPage extends StatefulWidget {
  @override
  _DonationDetailsPageState createState() => _DonationDetailsPageState();
}

class _DonationDetailsPageState extends State<DonationDetailsPage> {
  @override
  Widget build(BuildContext context) {
    // Accessing the current user from Firebase Auth
    User? user = FirebaseAuth.instance.currentUser;
    print(user?.email);
    return Scaffold(
      appBar: CustomAppBar(), // Include the CustomAppBar here
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('donations')
            .where('receiver', isEqualTo: user?.email)
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
              final donation = donations[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text('Donation ID: ${donations[index].id}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sender: ${donation['sender']}'),
                    Text('Receiver: ${donation['receiver']}'),
                    Text('Categories: ${donation['categories'].join(', ')}'),
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
                            // Prompt user to select a new status
                            _showStatusDialog(context, donations[index].id);
                          },
                          child: Text('Update Status'),
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

  void _showStatusDialog(BuildContext context, String donationId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildStatusButton(context, donationId, 'Cancelled'),
              _buildStatusButton(context, donationId, 'Pending'),
              _buildStatusButton(context, donationId, 'Confirmed'),
              _buildStatusButton(context, donationId, 'ScheduledForPickup'),
              _buildStatusButton(context, donationId, 'Completed'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatusButton(
      BuildContext context, String donationId, String status) {
    return ElevatedButton(
      onPressed: () {
        // Update donation status
        _updateDonationStatus(donationId, status);
        Navigator.of(context).pop(); // Close the dialog
      },
      child: Text(status),
    );
  }

  void _updateDonationStatus(String donationId, String newStatus) {
    // Call the function to update the status in Firestore
    updateDonationStatusInFirestore(donationId, newStatus).then((_) {

      setState(() {});
    });
  }
}
