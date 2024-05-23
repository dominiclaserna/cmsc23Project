import 'package:flutter/material.dart';

class DonatePage extends StatefulWidget {
  @override
  _DonatePageState createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  final _formKey = GlobalKey<FormState>();
  bool _isPickup = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donate'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Text('Donation item category:'),
              CheckboxListTile(
                title: Text('Food'),
                value: false,
                onChanged: (bool? value) {},
              ),
              CheckboxListTile(
                title: Text('Clothes'),
                value: false,
                onChanged: (bool? value) {},
              ),
              CheckboxListTile(
                title: Text('Cash'),
                value: false,
                onChanged: (bool? value) {},
              ),
              CheckboxListTile(
                title: Text('Necessities'),
                value: false,
                onChanged: (bool? value) {},
              ),
              CheckboxListTile(
                title: Text('Others'),
                value: false,
                onChanged: (bool? value) {},
              ),
              Text('Select if the items are for pickup or drop-off:'),
              ListTile(
                title: Text('Pickup'),
                leading: Radio<bool>(
                  value: true,
                  groupValue: _isPickup,
                  onChanged: (bool? value) {
                    setState(() {
                      _isPickup = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('Drop-off'),
                leading: Radio<bool>(
                  value: false,
                  groupValue: _isPickup,
                  onChanged: (bool? value) {
                    setState(() {
                      _isPickup = value!;
                    });
                  },
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Weight of items (kg/lbs)',
                ),
              ),
              Text('Photo of the items to donate (optional):'),
              ElevatedButton(
                onPressed: () {
                  // Implement photo picker
                },
                child: Text('Take Photo'),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Date and time for pickup/drop-off',
                ),
              ),
              if (_isPickup)
                Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Pickup Address',
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Contact Number',
                      ),
                    ),
                  ],
                ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process data
                  }
                },
                child: Text('Submit'),
              ),
              if (!_isPickup)
                ElevatedButton(
                  onPressed: () {
                    // Generate QR code
                  },
                  child: Text('Generate QR Code'),
                ),
              ElevatedButton(
                onPressed: () {
                  // Cancel donation
                },
                child: Text('Cancel Donation'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
