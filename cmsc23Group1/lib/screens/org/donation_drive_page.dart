import 'package:flutter/material.dart';

class DonationDrivePage extends StatefulWidget {
  @override
  _DonationDrivePageState createState() => _DonationDrivePageState();
}

class _DonationDrivePageState extends State<DonationDrivePage> {
  final List<String> donationDrives = [
    'Drive 1',
    'Drive 2',
    'Drive 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation Drives'),
      ),
      body: ListView.builder(
        itemCount: donationDrives.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(donationDrives[index]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Edit drive
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Delete drive
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new donation drive
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
