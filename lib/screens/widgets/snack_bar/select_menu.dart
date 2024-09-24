// ignore_for_file: non_constant_identifier_names

import 'package:day12_login/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Snack_Select_Menu({required context, required Widget widget, required onPressed, delete_onPressed, backgColor}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: widget,
        backgroundColor: wtColor,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: redColor,
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: .8.h),
                ),
                onPressed: delete_onPressed ??
                    () {
                      Navigator.of(context).pop();
                    },
                child: Text(
                  'إلغاء',
                  style: TextStyle(color: wtColor, fontSize: 12.sp),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: .8.h),
                ),
                onPressed: onPressed,
                child: Text(
                  'تأكيد',
                  style: TextStyle(color: wtColor, fontSize: 12.sp),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
