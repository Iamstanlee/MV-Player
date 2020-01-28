import 'package:flutter/material.dart';

const primaryFont = 'BrandonText';
const secondaryFont = 'BrandonText';

// BRFirma-Regular
ThemeData appTheme = ThemeData(
    fontFamily: primaryFont,
    appBarTheme: AppBarTheme(
        elevation: 0.5,
        color: blackColor,
        iconTheme: IconThemeData(color: Colors.white)));
TextStyle textStyle = const TextStyle(fontSize: 14.0, fontFamily: primaryFont);
TextStyle textStyleBold = const TextStyle(
    fontSize: 14.0, fontWeight: FontWeight.w800, fontFamily: primaryFont);
TextStyle textStyleWhite = const TextStyle(
    fontSize: 14.0, color: Colors.white, fontFamily: primaryFont);
Color transparentColor = const Color.fromRGBO(0, 0, 0, 0.2);
Color dangerButtonColor = const Color(0XFFf53a4d);
Color blackColor = const Color(0xFF1B1E23);

Widget raisedButton(Function onPressed, String child,
    {Color color = Colors.blue, double horizontalPadding = 0.0}) {
  return FlatButton(
    onPressed: onPressed,
    shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    color: color,
    child: Text(child,
        style: textStyle.copyWith(
            fontFamily: secondaryFont,
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w600)),
    padding:
        EdgeInsets.symmetric(vertical: 14.0, horizontal: horizontalPadding),
  );
}
