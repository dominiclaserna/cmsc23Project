import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week9/donation/donation_provider.dart';
import 'package:week9/donation/donation_utility.dart';



class WeightTextField extends StatefulWidget {
  const WeightTextField({super.key});

  @override
  State<WeightTextField> createState() => _WeightTextFieldState();
}

class _WeightTextFieldState extends State<WeightTextField> {
  final TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final parentProvider = Provider.of<DonationFormProvider>(context);

    double weight = 0;

    String kgToLb (String value) {
      double newValue = value as double;
      newValue = newValue * 2.20462;
      return newValue.toStringAsFixed(2);
    }

    String lbToKg (String value) {
      double newValue = value as double;
      newValue = newValue / 2.20462;
      return newValue.toStringAsFixed(2);
    }
    
    return Column(
      children: [
        if (parentProvider.weightErrorMessage.isNotEmpty) 
          Text(
            parentProvider.weightErrorMessage,
            style: DonationUtils.errorMessageStyle
          ),
        const Text("Weight of items (kgs): "),
        TextField(
          keyboardType: TextInputType.number,
          controller: weightController,
          decoration: DonationUtils.inputBorderStyle,
          onChanged: (value) {
            parentProvider.updateWeight(double.parse(weightController.text));
          },
        )
      ],
    );
  }
}
