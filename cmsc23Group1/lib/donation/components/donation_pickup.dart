import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week9/donation/donation_provider.dart';
import 'package:week9/donation/donation_utility.dart';



class IsForPickupSwitch extends StatefulWidget {
  const IsForPickupSwitch({super.key});

  @override
  State<IsForPickupSwitch> createState() => _IsForPickupSwitchState();
}

class _IsForPickupSwitchState extends State<IsForPickupSwitch> {

  @override
  Widget build(BuildContext context) {
    final parentProvider = Provider.of<DonationFormProvider>(context);

    return Column(
      children: [
        if (parentProvider.pickupErrorMessage.isNotEmpty) 
          Text(
            parentProvider.pickupErrorMessage,
            style: DonationUtils.errorMessageStyle
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Please indicate if it is for drop off:"),
            Switch(
              value: parentProvider.isForPickup ?? false,
              activeColor: Colors.green,
              onChanged: (bool? value) {
                parentProvider.updateIsForPickup(value ?? false);
              },
            )
          ],
        )
      ],
    );
  }
}
