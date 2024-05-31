import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week9/donation/donation_provider.dart';
import 'package:week9/donation/donation_utility.dart';

class ContactTextField extends StatefulWidget {
  const ContactTextField({super.key});

  @override
  State<ContactTextField> createState() => _ContactTextFieldState();
}

class _ContactTextFieldState extends State<ContactTextField> {
  final TextEditingController contactController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final parentProvider = Provider.of<DonationFormProvider>(context);


    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text("Enter contact number"),
        TextField(
          keyboardType: TextInputType.phone,
          controller: contactController,
          decoration: DonationUtils.inputBorderStyle.copyWith(
            suffixIcon: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  contactController.clear();
                });
              },
              )
          ),
          onChanged: (value) {
            parentProvider.updateContactNumber(contactController.text);
          },
        )
      ],
    );
  }
}