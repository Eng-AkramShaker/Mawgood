// ignore_for_file: non_constant_identifier_names, camel_case_types, prefer_typing_uninitialized_variables, must_be_immutable, unused_local_variable

import 'package:day12_login/controllers/home/home_provider.dart';
import 'package:day12_login/core/constants/constants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Drop_Down_Items extends StatefulWidget {
  Drop_Down_Items({super.key, required this.title, required this.Items});

  final String title;
  final List<String> Items;

  @override
  State<Drop_Down_Items> createState() => _Drop_Down_ItemsState();
}

class _Drop_Down_ItemsState extends State<Drop_Down_Items> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final crlHome = Provider.of<Controller_Home>(context, listen: false);

    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: Center(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: gryColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          items: widget.Items.map((item) => DropdownMenuItem<String>(
                value: item,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: wtColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )).toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
          },
          buttonStyleData: ButtonStyleData(
            // height: 50,
            // width: size.width / 3,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: primaryColor,
              ),
              color: Colors.white,
            ),
            elevation: 2,
          ),
          iconStyleData: IconStyleData(
            icon: Icon(Icons.keyboard_arrow_down),
            iconSize: 22,
            iconEnabledColor: gryColor,
            iconDisabledColor: gryColor,
          ),
          underline: Container(),
          dropdownStyleData: DropdownStyleData(
            maxHeight: size.height / 3,
            // width: size.width / 2.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: bgColor,
            ),
            offset: const Offset(0, 0),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all(6),
              thumbVisibility: MaterialStateProperty.all(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            // height: 40,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      ),
    );
  }
}
