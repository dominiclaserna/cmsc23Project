import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:week9/themedata.dart';

class DonationDetailsPage extends StatefulWidget {
  @override
  _DonationDetailsPageState createState() => _DonationDetailsPageState();
}

class _DonationDetailsPageState extends State<DonationDetailsPage> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Theme(
      data: appTheme,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Donation Details'),
        ),
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
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                          Text('Donation ID: ${donations[index].id}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
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
                                  _showStatusDialog(context, donations[index].id);
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
