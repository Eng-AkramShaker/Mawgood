import 'package:day12_login/core/constants/constants.dart';
import 'package:flutter/material.dart';

class TextFeildWidget extends StatelessWidget {
  const TextFeildWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: wtColor, // Set the background color to white
        prefixIcon: Icon(Icons.search, color: gryColor),
        hintText: 'البحث ......',
        hintStyle: TextStyle(
          color: gryColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: primaryColor), // Default border color
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: primaryColor), // Enabled border color
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: primaryColor, width: 2), // Focused border color
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10), // Adjust padding here
      ),
    );
  }
}
