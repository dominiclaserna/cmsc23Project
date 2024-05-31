import 'package:flutter/material.dart';
import '/main.dart'; // Import your main.dart to access CustomAppBar

class OrgHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(), // Include the CustomAppBar here
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/donation');
              },
              child: Text('List of Donations'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/donationDrive');
              },
              child: Text('Donation Drives'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/org_profile');
              },
              child: Text('Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
