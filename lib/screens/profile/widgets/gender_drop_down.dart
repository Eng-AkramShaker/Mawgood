// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:day12_login/core/constants/constants.dart';
import 'package:day12_login/data/controllers/profile/profile_provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GenderDropDown extends StatefulWidget {
  @override
  State<GenderDropDown> createState() => _GenderDropDownState();
}

class _GenderDropDownState extends State<GenderDropDown> {
  List<String> items_gender = ['ذكر', 'انثى'];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<Profile_Provider>(
      builder: (context, profileProvider, child) {
        return DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    profileProvider.gender,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: bgColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: items_gender
                .map(
                  (item) => DropdownMenuItem<String>(
                    value: item,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: bgColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
            value: items_gender.contains(profileProvider.gender) ? profileProvider.gender : null,
            onChanged: (value) {
              setState(() {
                profileProvider.gender = value!;
              });
            },
            buttonStyleData: ButtonStyleData(
              height: 50,
              // width: size.width / 1.5,
              // padding: EdgeInsets.symmetric(horizontal: 14),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(14),
              //   border: Border.all(
              //     color: bluColor,
              //   ),
              //   color: Colors.white,
              // ),
              elevation: 2,
            ),
            iconStyleData: IconStyleData(
              icon: Icon(Icons.keyboard_arrow_down),
              iconSize: 22,
              iconEnabledColor: bgColor,
              iconDisabledColor: bgColor,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: size.height / 3,
              width: size.width / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: wtColor,
              ),
              offset: const Offset(0, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: MaterialStateProperty.all(6),
                thumbVisibility: MaterialStateProperty.all(true),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 14),
            ),
          ),
        );
      },
    );
  }
}
