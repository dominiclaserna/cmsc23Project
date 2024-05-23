import 'package:flutter/material.dart';

class OrgProfilePage extends StatefulWidget {
  @override
  _OrgProfilePageState createState() => _OrgProfilePageState();
}

class _OrgProfilePageState extends State<OrgProfilePage> {
  final _formKey = GlobalKey<FormState>();
  bool _isDonationsOpen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Organization Name',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'About the Organization',
                ),
                maxLines: 3,
              ),
              SwitchListTile(
                title: Text('Status for donations'),
                value: _isDonationsOpen,
                onChanged: (bool value) {
                  setState(() {
                    _isDonationsOpen = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save profile
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
