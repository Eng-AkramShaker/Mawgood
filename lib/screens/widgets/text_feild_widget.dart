import 'package:flutter/material.dart';

class TextFeildWidget extends StatelessWidget {
  const TextFeildWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: Colors.grey.withOpacity(0.7),
        ),
        hintText: 'Search here......',
        hintStyle: TextStyle(
          color: Colors.grey.withOpacity(0.4),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.4),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10), // Adjust padding here
      ),
    );
  }
}
