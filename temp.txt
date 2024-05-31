// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:week9/donation/donation_provider.dart';
import 'package:week9/donation/donation_utility.dart';

class DonationAddressInput extends StatefulWidget {
  const DonationAddressInput({super.key});

  @override
  State<DonationAddressInput> createState() => _DonationAddressInputState();
}

class _DonationAddressInputState extends State<DonationAddressInput> {
  List<String>? addresses = ["test", "test2"];
  TextEditingController addressController = TextEditingController();

  Widget createAddressCard(String address) {
    return ListTile(
      leading: Text(address),
      trailing: IconButton.outlined(onPressed: () {print("Button pressed.");}, icon: const Icon(Icons.delete)),
      title: Text(address),
    );
  }

  Widget createAddressList(context) {
    return ListView.builder(
        itemCount: addresses?.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return createAddressCard(addresses![index]);
        },
      );
  }

  Widget createAddressInput(context, parentProvider) {
    return Container(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextField(
            keyboardType: TextInputType.streetAddress,
            controller: addressController,
            decoration: DonationUtils.inputBorderStyle,
            onChanged: (value) {
              parentProvider.updateWeight(double.parse(addressController.text));
            },
          ),
          TextButton(g 
            child: const Text("Add Address"),
            onPressed: () {
              addresses!.add(addressController.text);
              parentProvider.updateAddress(addresses);
              addressController.clear();
            },
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final parentProvider = Provider.of<DonationFormProvider>(context);

    if (parentProvider.isForPickup == false || parentProvider.isForPickup == null)  {
      return const Text("Not for pickup.");
    }

    return createAddressInput(context, parentProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Enter address(es) for pickup: "),
        // createAddressInput(context, parentProvider),
        createAddressList(context)
      ],
    );
    
  }
}