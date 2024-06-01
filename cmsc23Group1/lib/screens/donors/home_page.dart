import 'package:flutter/material.dart';
import '/main.dart'; // Import your main.dart to access CustomAppBar

class HomePage extends StatelessWidget {
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
                Navigator.pushNamed(context, '/donor_profile');
              },
              child: Text('Donate to an Organization'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/donor_drive');
              },
              child: Text('Donate to a Donation Drive'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/donated');
              },
              child: Text('Donation History'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/user_profile');
              },
              child: Text('User Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
