// // ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison

// import 'package:flutter/material.dart';
// import '../../../const/constants.dart';

// Widget DisplayImage(imagesFile) {
//   return Center(
//     child: Stack(
//       children: [
//         imagesFile == null
//             ? Image.asset(
//                 "assets/images/add.png",
//                 height: 130,
//                 width: defaultPadding * 18,
//                 fit: BoxFit.fill,
//               )
//             : Image.file(
//                 imagesFile,
//                 height: 130,
//                 width: defaultPadding * 18,
//                 fit: BoxFit.fill,
//               ),
//         Positioned(
//           right: 4,
//           top: 10,
//           child: ClipOval(
//               child: Container(
//             padding: EdgeInsets.all(5),
//             color: Colors.white,
//             child: Icon(
//               Icons.edit,
//               color: bgColor,
//               size: 26,
//             ),
//           )),
//         )
//       ],
//     ),
//   );
// }
