import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DonationDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Accessing the current user from Firebase Auth
    User? user = FirebaseAuth.instance.currentUser;
    print(user?.email);
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation Details'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('donations')
            .where('receiver', isEqualTo: user?.email)
            .where('sender', isEqualTo: user?.email)
            .get(),
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
