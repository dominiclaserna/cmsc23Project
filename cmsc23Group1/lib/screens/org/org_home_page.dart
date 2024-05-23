import 'package:flutter/material.dart';

class OrgHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Organization’s View'),
      ),
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
                Navigator.pushNamed(context, '/profile');
              },
              child: Text('Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
