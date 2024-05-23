import 'package:flutter/material.dart';

class DonationPage extends StatefulWidget {
  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  final List<String> donations = [
    'Donation 1',
    'Donation 2',
    'Donation 3',
  ];

  String? _status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Donations'),
      ),
      body: ListView.builder(
        itemCount: donations.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(donations[index]),
            trailing: DropdownButton<String>(
              value: _status,
              hint: Text('Update Status'),
              items: <String>['Pending', 'Confirmed', 'Scheduled for Pick-up', 'Complete', 'Canceled']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _status = newValue!;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
