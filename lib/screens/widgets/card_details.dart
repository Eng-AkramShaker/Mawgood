// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:day12_login/core/constants/constants.dart';
import 'package:flutter/material.dart';

class CardDetails extends StatelessWidget {
  CardDetails({super.key, required this.name, required this.img});

  final String name;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200,
      // width: double.infinity,
      decoration: BoxDecoration(color: wtColor, borderRadius: BorderRadius.circular(12), border: Border.all(color: primaryColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            child: CachedNetworkImage(
              imageUrl: img,
              width: double.infinity,
              height: 160,
              fit: BoxFit.fill,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
              errorWidget: (context, url, error) =>
                  Container(width: double.infinity, height: 160, child: Center(child: Icon(Icons.error, size: 25))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
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
