import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week9/donation/components/donation_category.dart';
import 'package:week9/donation/donation_provider.dart';
import 'package:week9/donation/components/donation_pickup.dart';

class DonationForm extends StatefulWidget {
  const DonationForm({super.key});

  @override
  State<DonationForm> createState() => _DonationFormState();
}

class _DonationFormState extends State<DonationForm> {

  @override
  Widget build(BuildContext context) {
  final donationFormProvider = Provider.of<DonationFormProvider>(context);


    return const SingleChildScrollView(
      child: Column(
        children: [
          CategoryCheckbox(),
          IsForPickupRadio()
        ]
      )
    );
  }
}