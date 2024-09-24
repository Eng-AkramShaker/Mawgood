import 'dart:io';

import 'package:day12_login/core/constants/constants.dart';
import 'package:flutter/material.dart';

class DisplayImage extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  List<File> images_File;

  // Constructor
  DisplayImage({
    super.key,
    required this.imagePath,
    required this.onPressed,
    required this.images_File,
  });

  @override
  Widget build(BuildContext context) {
    final image = imagePath.contains('https://') ? NetworkImage(imagePath) : FileImage(File(imagePath));

    return Center(
      child: Stack(
        children: [
          images_File.isEmpty
              ? CircleAvatar(
                  radius: 75,
                  backgroundColor: bluColor,
                  child: CircleAvatar(
                    backgroundImage: image as ImageProvider,
                    radius: 72,
                  ),
                )
              : CircleAvatar(
                  radius: 80,
                  backgroundImage: FileImage(images_File.first),
                ),
          // Positioned(
          //   right: 4,
          //   top: 10,
          //   child: buildEditIcon(bluColor),
          // )
        ],
      ),
    );
  }

  // Builds Edit Icon on Profile Picture
  Widget buildEditIcon(Color color) => buildCircle(
      all: 8,
      child: Icon(
        Icons.edit,
        color: color,
        size: 20,
      ));

  // Builds/Makes Circle for Edit Icon on Profile Picture
  Widget buildCircle({
    required Widget child,
    required double all,
  }) =>
      ClipOval(
          child: Container(
        padding: EdgeInsets.all(all),
        color: Colors.white,
        child: child,
      ));
}
