import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week9/donation/donation_provider.dart';



class CategoryCheckbox extends StatefulWidget {
  const CategoryCheckbox({super.key});

  @override
  State<CategoryCheckbox> createState() => _CategoryCheckboxState();
}

class _CategoryCheckboxState extends State<CategoryCheckbox> {
static const List<String> categories = ["Food", "Clothes", "Cash", "Necessities", "Others"];

  @override
  Widget build(BuildContext context) {
    final parentProvider = Provider.of<DonationFormProvider>(context);

    return  ListView.builder(
      shrinkWrap: true,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return CheckboxListTile(
          title: Text(category),
          value: parentProvider.selectedCategories.contains(category),
          onChanged: (bool? value) {
            parentProvider.updateCategory(category, value ?? false);
          }
        );
      }
    );
  }
}
