import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:week9/models/donation_model.dart';
import 'package:week9/api/donation_api.dart';
import 'package:week9/main.dart';

class DonationPage extends StatefulWidget {
  final String receiverEmail; // Add receiverEmail parameter

  DonationPage(
      {required this.receiverEmail}); // Constructor to receive receiverEmail

  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  List<DonationCategory> _selectedCategories = [];
  PickupType _selectedPickupType = PickupType.Pickup;
  TextEditingController _weightController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _contactNumberController = TextEditingController();
  TextEditingController _receiverController = TextEditingController();
  TextEditingController _senderController = TextEditingController();
  bool _isCancelled = false;
  DateTime? _selectedDateTime;

  void initState() {
    super.initState();

    // Set initial value of receiverController if receiverEmail is not null
    if (widget.receiverEmail != null) {
      _receiverController.text = widget.receiverEmail;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(), // Add the CustomAppBar here
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Donation Categories:'),
            CheckboxListTile(
              title: Text('Clothes'),
              value: _selectedCategories.contains(DonationCategory.Clothes),
              onChanged: (value) {
                setState(() {
                  if (value!) {
                    _selectedCategories.add(DonationCategory.Clothes);
                  } else {
                    _selectedCategories.remove(DonationCategory.Clothes);
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text('Cash'),
              value: _selectedCategories.contains(DonationCategory.Cash),
              onChanged: (value) {
                setState(() {
                  if (value!) {
                    _selectedCategories.add(DonationCategory.Cash);
                  } else {
                    _selectedCategories.remove(DonationCategory.Cash);
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text('Food'),
              value: _selectedCategories.contains(DonationCategory.Food),
              onChanged: (value) {
                setState(() {
                  if (value!) {
                    _selectedCategories.add(DonationCategory.Food);
                  } else {
                    _selectedCategories.remove(DonationCategory.Food);
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text('Necessities'),
              value: _selectedCategories.contains(DonationCategory.Necessities),
              onChanged: (value) {
                setState(() {
                  if (value!) {
                    _selectedCategories.add(DonationCategory.Necessities);
                  } else {
                    _selectedCategories.remove(DonationCategory.Necessities);
                  }
                });
              },
            ),
            CheckboxListTile(
              title: Text('Others'),
              value: _selectedCategories.contains(DonationCategory.Others),
              onChanged: (value) {
                setState(() {
                  if (value!) {
                    _selectedCategories.add(DonationCategory.Others);
                  } else {
                    _selectedCategories.remove(DonationCategory.Others);
                  }
                });
              },
            ),
            SizedBox(height: 16.0),
            Text('Select Pickup Type:'),
            RadioListTile<PickupType>(
              title: Text('Pickup'),
              value: PickupType.Pickup,
              groupValue: _selectedPickupType,
              onChanged: (value) {
                setState(() {
                  _selectedPickupType = value!;
                });
              },
            ),
            RadioListTile<PickupType>(
              title: Text('Drop-Off'),
              value: PickupType.DropOff,
              groupValue: _selectedPickupType,
              onChanged: (value) {
                setState(() {
                  _selectedPickupType = value!;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Weight (kg/lbs)',
                labelStyle: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              readOnly: true,
              onTap: () async {
                final DateTime? pickedDateTime = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (pickedDateTime != null) {
                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      _selectedDateTime = DateTime(
                        pickedDateTime.year,
                        pickedDateTime.month,
                        pickedDateTime.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );
                    });
                  }
                }
              },
              decoration: InputDecoration(
                labelText: 'Date and Time',
                labelStyle: TextStyle(color: Colors.black),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              controller: TextEditingController(
                text: _selectedDateTime != null
                    ? DateFormat.yMd().add_jm().format(_selectedDateTime!)
                    : '',
              ),
            ),
            Visibility(
              visible: _selectedPickupType == PickupType.Pickup,
              child: Column(
                children: [
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _contactNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Contact Number',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _receiverController,
              decoration: InputDecoration(
                labelText: 'Receiver',
                labelStyle: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _senderController,
              decoration: InputDecoration(
                labelText: 'Sender',
                labelStyle: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 16.0),
            CheckboxListTile(
              title: Text('Cancelled'),
              value: _isCancelled,
              onChanged: (value) {
                setState(() {
                  _isCancelled = value!;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Create a Donation object with the entered data
                Donation donation = Donation(
                  categories: _selectedCategories,
                  pickupType: _selectedPickupType,
                  weight: double.parse(_weightController.text),
                  dateTime: _selectedDateTime ?? DateTime.now(),
                  address: _addressController.text,
                  contactNumber: _contactNumberController.text,
                  receiver: _receiverController.text,
                  sender: _senderController.text,
                  isCancelled: _isCancelled,
                );

                // Save the donation to Firestore
                saveDonationToFirestore(donation);
              },
              child: Text('Create Donation'),
            ),
          ],
        ),
      ),
    );
  }
}
