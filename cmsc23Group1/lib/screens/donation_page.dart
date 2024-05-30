
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week9/donation/donation_form.dart';
import 'package:week9/donation/donation_provider.dart';
import 'package:week9/user/user_model.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: Text("Donate to test.")),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: DonationForm()
        )
      ,)
    );
  }
}