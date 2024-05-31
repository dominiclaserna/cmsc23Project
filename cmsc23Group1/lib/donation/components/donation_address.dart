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
  List<String>? addresses;
  TextEditingController addressController = TextEditingController();

  Widget createAddressCard(String address) {
    return ListTile(
      leading: Text(address),
      trailing: IconButton.outlined(
        icon: const Icon(Icons.delete),
        onPressed: () {
          setState(() {
            print("Deleteing ${address}.");
            addresses?.removeWhere((place) => place == address);
          });
        }
      ), 
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
    return TextField(
      keyboardType: TextInputType.streetAddress,
      controller: addressController,
      decoration: DonationUtils.inputBorderStyle.copyWith(
        suffixIcon: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              print("Add address button has been pressed with the value: ${addressController.text}");
              addresses?.add(addressController.text);
              parentProvider.updateAddress(addresses);
              addressController.clear();
              FocusScope.of(context).unfocus();
            });
          },
        )
      ),
      onChanged: (value) {
        parentProvider.updateAddress(double.parse(addressController.text));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final parentProvider = Provider.of<DonationFormProvider>(context);
    addresses = parentProvider.addressesForPickup ?? [];
    // if (parentProvider.isForPickup == false || parentProvider.isForPickup == null)  {
    //   return const Text("Not for pickup.");
    // }

    // return createAddressInput(context, parentProvider);

    return Visibility(
      visible: parentProvider.isForPickup == true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Enter address(es) for pickup: "),
          createAddressInput(context, parentProvider),
          createAddressList(context)
        ],
      ),
    );
    
  }
}