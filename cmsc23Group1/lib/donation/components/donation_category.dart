import 'package:flutter/material.dart';

class Motto extends FormField<String> {
  final ValueChanged<String> onSubmit;
  void reset() {

  }

  Motto({
    super.key,
    required this.onSubmit,
  }) : super(
          onSaved: (value) {
            print('Saved value: $value');
          },
          validator: (value) {
            if (value == null) {
              print("Motto validator failure.");
              return 'Motto validator failure.';
            } else {
              print("Motto validator success.");
              onSubmit(value);
              return null;
            }
          },
          builder: (FormFieldState<String> field) {
            return RadioGroup(
              onChanged: (value) {
                field.didChange(value);
              },
            );
          },
        );
  }

class RadioGroup extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onReset;
  const RadioGroup({super.key, this.onChanged, this.onReset});

  @override
  State<RadioGroup> createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {
  String? inputValue = "Default";

  static final Map<String, bool> mottoList = {
    "Haters gonna hate": true,
    "Bakers gonna Bake": false,
    "If cannot be, borrow one from three": false,
    "Less is more, more or less": false,
    "Better late than sorry": false,
    "Don't talk to strangers when your mouth is full": false,
    "Let's burn the bridge when we get there": false
  };


  late String _selectedValue;

  @override
  void initState() {
    super.initState();

    _selectedValue = "Haters gonna hate";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: mottoList.keys.map((option) {
        return RadioListTile(
          title: Text(option),
          value: option,
          groupValue: _selectedValue,
          onChanged: (value) {
            setState(() {
              _selectedValue = value.toString();
              widget.onChanged?.call(_selectedValue);
            });
            // print("Changed radio to $_selectedValue.");
          },
        );
      }).toList(),
    );
  }
}