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
              child: Text('Donate'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/donor_profile');
              },
              child: Text('Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
