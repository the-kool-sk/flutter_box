import 'package:flutter_box/res/font_families.dart';
import 'package:flutter/material.dart';

class BoxText extends StatelessWidget {
  const BoxText(
      {Key? key,
      required this.text,
      required this.color,
      required this.fontWeight,
      required this.fontSize,
      this.decoration = TextDecoration.none,
      this.alignment = TextAlign.center,
      this.textOverflow = TextOverflow.fade,
      this.maxLines = 10})
      : super(key: key);
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
  final TextDecoration decoration;
  final TextAlign alignment;
  final TextOverflow textOverflow;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: textOverflow,
      maxLines: maxLines,
      style: TextStyle(
        decoration: decoration,
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontFamily: BoxFonts.poppins,
      ),
      textAlign: alignment,
    );
  }
}
