
import 'package:flutter/material.dart';

class DonationUtils {
  static const errorMessageStyle = TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.bold 
    );

  static InputDecoration inputBorderStyle = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: const BorderSide(color: Colors.black, width: 2.0)
    )
  );

  static InputDecoration errorInputBorderStyle = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: const BorderSide(color: Colors.red, width: 2.0),
    ),
    hintText: "error"
  );
  
}

