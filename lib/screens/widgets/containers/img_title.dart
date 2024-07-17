// // ignore_for_file: non_constant_identifier_names

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../../const/constants.dart';
// import '../texts/custom_text.dart';

// Widget Container_img_icon_title({svgSrc, text, color, color_Text, double? size_Text, IconData? icon}) {
//   return Container(
//     margin: EdgeInsets.only(left: defaultPadding * 3, right: defaultPadding * 3),
//     // padding: EdgeInsets.all(defaultPadding),
//     decoration: BoxDecoration(
//       color: color ?? Colors.transparent,
//       border: Border.all(width: 2, color: primaryColor.withOpacity(0.60)),
//       borderRadius: const BorderRadius.all(Radius.circular(defaultPadding)),
//     ),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         icon != null
//             ? Icon(icon)
//             : svgSrc != null
//                 ? SizedBox(
//                     height: 20,
//                     width: 20,
//                     child: SvgPicture.asset(svgSrc),
//                   )
//                 : Container(),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 5),
//           child: Custom_Text(
//             text: text,
//             size: size_Text ?? defaultPadding,
//             fontweight: FontWeight.w400,
//             color: color_Text ?? wtColor,
//           ),
//         ),
//       ],
//     ),
//   );
// }
