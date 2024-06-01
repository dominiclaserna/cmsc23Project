import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:week9/main.dart'; // Import the CustomAppBar from main.dart
import 'package:week9/screens/donors/drive_details_page.dart';

class DonationDrivesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('donationDrives').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('An error occurred: ${snapshot.error}'));
          }

          var donationDrives =
              snapshot.data!.docs.map((doc) => doc['driveName']).toList();

          return ListView.builder(
            itemCount: donationDrives.length,
            itemBuilder: (context, index) {
              return Card(
                // Wrap ListTile with Card
                elevation: 4, // Add some elevation for visual effect
                child: ListTile(
                  onTap: () {
                    String driveName =
                        donationDrives[index]; // Get the driveName
                    print('Navigating to details page for drive: $driveName');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DriveDetailsPage(driveName: driveName),
                      ),
                    );
                  },
                  title: Text(donationDrives[index]),
                  // Add other ListTile properties as needed
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white, // Set the background color to white
      title: Text('CMSC23 Project'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            // Perform logout action
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

void main() {
  runApp(MaterialApp(
    home: DonationDrivesPage(),
  ));
}
