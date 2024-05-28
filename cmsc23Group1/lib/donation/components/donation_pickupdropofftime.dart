// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week9/donation/donation_provider.dart';
import 'package:week9/donation/donation_utility.dart';

class PickDropTimeTextField extends StatefulWidget {
  const PickDropTimeTextField({super.key});

  @override
  State<PickDropTimeTextField> createState() => _PickDropTimeTextFieldState();
}

class _PickDropTimeTextFieldState extends State<PickDropTimeTextField> {


  TimeOfDay? selectedTime;
  TimePickerEntryMode entryMode = TimePickerEntryMode.dial;
  TextDirection textDirection = TextDirection.ltr;
  bool use24HourTime = false;
  MaterialTapTargetSize tapTargetSize = MaterialTapTargetSize.padded;


  Widget createTimePicker(parentProvider) {
    
    return IconButton(
      icon:const Icon(Icons.alarm),
      onPressed: () async {
        final TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: selectedTime ?? TimeOfDay.now(),
          initialEntryMode: entryMode,
          builder: (BuildContext context, Widget? child) {
            // We just wrap these environmental changes around the
            // child in this builder so that we can apply the
            // options selected above. In regular usage, this is
            // rarely necessary, because the default values are
            // usually used as-is.
            return Theme(
              data: Theme.of(context).copyWith(
                materialTapTargetSize: tapTargetSize,
              ),
              child: Directionality(
                textDirection: textDirection,
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    alwaysUse24HourFormat: use24HourTime,
                  ),
                  child: child!,
                ),
              ),
            );
          },
        );
        setState(() {
          selectedTime = time;
          print(selectedTime); 
          parentProvider.updatePickupDropOffTime(selectedTime);
        });
      },
    );
  }

  Widget createTimeDisplayAndSelector(parentProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Selected time: ${selectedTime!.format(context)}"),
        createTimePicker(parentProvider)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final parentProvider = Provider.of<DonationFormProvider>(context);
    
    return Column(
      children: [
        if (parentProvider.pickDropTimeErrorMessage.isNotEmpty) 
          Text(
            parentProvider.pickDropTimeErrorMessage,
            style: DonationUtils.errorMessageStyle
          ),
        const Text("Enter drop-off/pickup time: "),
        createTimePicker(parentProvider)
      ],
    );
  }
}