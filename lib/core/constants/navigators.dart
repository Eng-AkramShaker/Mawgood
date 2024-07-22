import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

pushNewScreen(BuildContext context, Widget widget) {
  Navigator.push(
    context,
    CupertinoPageRoute(builder: (context) => widget),
  );
}

void pushAndRemoveUntil(BuildContext context, Widget screen, {arguments}) {
  Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(
        builder: (context) => screen,
      ),
      (route) => false);
}

void removeAllNavigation(BuildContext context, Widget screen) {
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => screen), (Route<dynamic> route) => false);
}

pop(BuildContext context) {
  Navigator.of(context).pop();
}

            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewScreen()));



