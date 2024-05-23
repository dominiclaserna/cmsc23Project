
import 'package:flutter/material.dart';
import 'package:week9/donation/donation_form.dart';
import 'package:week9/user/user_model.dart';

class DonationPage extends StatefulWidget {
  final User organization;
  const DonationPage({super.key, required this.organization});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Donate to ${widget.organization.name}")),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: DonationForm()
        )
      ,)
    );
  }
}