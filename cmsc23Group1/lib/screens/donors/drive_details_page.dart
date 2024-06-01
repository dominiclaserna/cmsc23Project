import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:week9/screens/donation_page_drive.dart'; // Adjusted import
import 'package:week9/main.dart'; // Import the CustomAppBar from main.dart

class DriveDetailsPage extends StatelessWidget {
  final String driveName;

  DriveDetailsPage({required this.driveName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('donationDrives')
            .where('driveName', isEqualTo: driveName)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('An error occurred: ${snapshot.error}'));
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Drive not found.'));
          }

          var driveData =
              snapshot.data!.docs.first.data() as Map<String, dynamic>;

          return DriveDetailsWidget(driveData: driveData);
        },
      ),
    );
  }
}

class DriveDetailsWidget extends StatelessWidget {
  final Map<String, dynamic> driveData;

  DriveDetailsWidget({required this.driveData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Drive Name: ${driveData['driveName'] ?? 'Not available'}',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Text(
            'Owner: ${driveData['owner'] ?? 'Not available'}',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 20,
          ), // Add some space between drive details and button
          ElevatedButton(
            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DonationPageDrive(
                    driveName: driveData['driveName'], // Pass driveName
                  ),
                ),
              );
            },
            child: Text('Donate'),
          ),
        ],
      ),
    );
  }
}
