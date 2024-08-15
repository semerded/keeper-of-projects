import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:keeper_of_projects/data.dart';

// ignore: must_be_immutable
class AdaptiveText extends StatelessWidget {
  final dynamic data;
  double? fontSize;
  FontWeight? fontWeight;
  TextAlign? textAlign;
  FontStyle? fontStyle;
  TextOverflow? overflow;

  AdaptiveText(
    this.data, {
    super.key,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.fontStyle,
    this.overflow
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data!,
      textAlign: textAlign,
      key: key,
      style: TextStyle(
        color: Palette.text,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        overflow: overflow,
      ),
    );
  }
}
