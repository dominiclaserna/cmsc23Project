import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/main.dart'; // Import your main.dart to access CustomAppBar
import 'package:week9/models/donation_model.dart';
import 'package:week9/api/donation_api.dart';

class AdminAllDonationsPage extends StatefulWidget {
  @override
  _AdminAllDonationsPageState createState() => _AdminAllDonationsPageState();
}

class _AdminAllDonationsPageState extends State<AdminAllDonationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(), // Include the CustomAppBar here
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('donations').snapshots(),
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
                    Text('Status: ${donation['status']}'),
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
