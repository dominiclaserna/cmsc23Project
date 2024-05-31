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
  DateTime? selectedDate;
  DateTime? completeTimeDetails = DateTime.now();
  TimePickerEntryMode entryMode = TimePickerEntryMode.dial;
  TextDirection textDirection = TextDirection.ltr;
  bool use24HourTime = false;
  MaterialTapTargetSize tapTargetSize = MaterialTapTargetSize.padded;


  Widget createDatePicker(parentProvider) {

    return IconButton(
      icon: const Icon(Icons.calendar_month),
      onPressed: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2101),
          // builder: 
        );
        if (picked != null && picked != selectedDate) {
          setState(() {
            selectedDate = picked;
            print(selectedDate);

            completeTimeDetails = DateTime(
              selectedDate!.year, 
              selectedDate!.month,
              selectedDate!.day,
              completeTimeDetails!.hour,
              completeTimeDetails!.minute
            );

            parentProvider.updatePickupDropOffTime(completeTimeDetails);
          });
        }
      },
    );
  }

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

          completeTimeDetails = DateTime(
              completeTimeDetails!.year, 
              completeTimeDetails!.month,
              completeTimeDetails!.day,
              selectedTime!.hour,
              selectedTime!.minute
              );

          parentProvider.updatePickupDropOffTime(completeTimeDetails);
        });
      },
    );
  }

  Widget createTimeDisplayAndSelector(parentProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if(completeTimeDetails != null) Text("Selected date: ${completeTimeDetails!.toString()}"),
        createTimePicker(parentProvider),
        createDatePicker(parentProvider)
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
        createTimeDisplayAndSelector(parentProvider)
      ],
    );
  }
}