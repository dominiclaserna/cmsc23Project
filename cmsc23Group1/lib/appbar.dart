import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('CMSC23 Project'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            // Call your logout method from AuthProvider
            Provider.of<AuthProvider>(context, listen: false).signOut();
            // Navigate to login screen
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/login', (route) => false);
          },
        ),
      ],
    );
  }
}
