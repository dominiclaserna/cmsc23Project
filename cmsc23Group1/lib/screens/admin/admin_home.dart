// admin_home_page.dart
import 'package:flutter/material.dart';

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/admin_donations');
              },
              child: Text('View All Organizations and Donations'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/admin_approve');
              },
              child: Text('Approve Organization Sign Up'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/admin_donors');
              },
              child: Text('View All Donors'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/admin_orgs');
              },
              child: Text('View All Organizations'),
            ),
          ],
        ),
      ),
    );
  }
}
