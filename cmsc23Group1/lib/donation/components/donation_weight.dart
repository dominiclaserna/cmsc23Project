// ignore_for_file: avoid_print

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
    bool isInKg = true;


    String kgToLb (String value) {
      double newValue = double.parse(value);
      newValue = newValue * 2.20462;
      return newValue.toStringAsFixed(2);
    }

    String lbToKg (String value) {
      double newValue = double.parse(value);
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
        Text("Weight of items (${isInKg ? 'kg' :'lb'}): "),
        TextField(
          keyboardType: TextInputType.number,
          controller: weightController,
          decoration: DonationUtils.inputBorderStyle.copyWith(
            suffixIcon: TextButton(
              child: Text(isInKg ? "kg" : "Lbs"),
              onPressed: () {
                setState(() {
                  isInKg = !isInKg;
                  print(isInKg);
                  if(isInKg) {
                    weightController.text = kgToLb(weightController.text);
                  } else {
                    weightController.text = lbToKg(weightController.text);
                  }
                });
              },
            )
          ),
          onChanged: (value) {
            parentProvider.updateWeight(double.parse(weightController.text));
          },
          
        )
      ],
    );
  }
}
