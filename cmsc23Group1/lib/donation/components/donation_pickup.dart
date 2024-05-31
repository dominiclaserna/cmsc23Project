import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week9/donation/donation_provider.dart';
import 'package:week9/donation/donation_utility.dart';



class IsForPickupRadio extends StatefulWidget {
  const IsForPickupRadio({super.key});

  @override
  State<IsForPickupRadio> createState() => _IsForPickupRadioState();
}

class _IsForPickupRadioState extends State<IsForPickupRadio> {

  @override
  Widget build(BuildContext context) {
    final parentProvider = Provider.of<DonationFormProvider>(context);
  
  Widget createPickupRadio(String text) {
    bool radioValue = (text == "Is For Pickup") ? true : false;

    void highlightRadio() {
      setState( () {
        
      });
    }

    return RadioListTile(
        title: Text(text),
        value: text,
        groupValue: parentProvider.isForPickup,
        onChanged: (value) {
          parentProvider.updateIsForPickup(radioValue);
          highlightRadio();
        },
      );
  }

    return Column(
      children: [
        if (parentProvider.pickupErrorMessage.isNotEmpty) 
          Text(
            parentProvider.pickupErrorMessage,
            style: DonationUtils.errorMessageStyle
          ),
        const Text("Please indicate if it is for drop off:"),
          Column(
            children: [
              createPickupRadio("Is For Pickup"),
              createPickupRadio("Drop-off")
            ],
          ),
      ],
    );
  }
}
