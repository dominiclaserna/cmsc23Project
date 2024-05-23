import 'package:flutter/material.dart';

class DonationForm extends StatefulWidget {
  const DonationForm({super.key});

  @override
  State<DonationForm> createState() => _DonationFormState();
}

class _DonationFormState extends State<DonationForm> {

  GlobalKey<FormState> donationFormKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Form(
      key: donationFormKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            
          ],
        )
      )
    );
  }
}