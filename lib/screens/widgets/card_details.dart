// ignore_for_file: must_be_immutable

import 'package:day12_login/core/constants/constants.dart';
import 'package:day12_login/screens/widgets/images/Custom_Image.dart';
import 'package:flutter/material.dart';

class CardDetails extends StatelessWidget {
  CardDetails({super.key, required this.name, required this.img});

  final String name;
  final String img;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      // height: 210,
      // width: 210,
      decoration: BoxDecoration(color: wtColor, borderRadius: BorderRadius.circular(12), border: Border.all(color: primaryColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Custom_Image(h: 150, w: size.width, images: img),

          //
          Padding(
            padding: const EdgeInsets.all(5),
            child: Center(
              child: Text(
                '${name}',
                style: TextStyle(fontSize: 18, color: primaryColor, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
