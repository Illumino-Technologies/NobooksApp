import 'package:flutter/material.dart';
import 'package:nobook/src/app/themes/colors.dart';

///This is the general widget for text in this app
///use this rather than the flutter provided text widget
///
/// static methods are provided for fontWeights
/// eg. AppText.semiBoldItalic(
///       "my text",
///       fontSize: 20,
///      )...
///   for -> fontWeight = 600
///          fontSize = 20
///          fontStyle = italic
///
/// if there are font weight that are not provided here
/// feel free to add a  method for it.
/// happy coding :)
///
class AppText extends StatelessWidget {
  final String text;
  final FontWeight? weight;
  final double? fontSize;
  final FontStyle? style;
  final Color? color;
  final TextAlign? alignment;
  final TextDecoration? decoration;
  final TextOverflow overflow;

  ///fontSize = 14
  const AppText(
    this.text, {
    Key? key,
    this.weight = FontWeight.w400,
    this.fontSize,
    this.style = FontStyle.normal,
    this.color,
    this.alignment = TextAlign.start,
    this.overflow = TextOverflow.visible,
    this.decoration,
  }) : super(key: key);

  ///fontSize: 14
  ///fontStyle: italic
  ///weight: w400
  static AppText italic(
    String text, {
    Color? color,
    FontWeight? weight,
  }) =>
      AppText(
        text,
        weight: weight,
        color: color,
        style: FontStyle.italic,
      );

  ///fontSize: 16
  ///weight: w400
  static AppText bodyMedium(
    String text, {
    Color? color,
    double? fontSize = 15,

  }) =>
      AppText(
        text,
        weight: FontWeight.w400,
        fontSize: fontSize,
        color: color,
      );

  ///fontSize: 15
  ///weight: w700
  static AppText bold(
    String text, {
    Color? color,
    double? fontSize = 15,
  }) =>
      AppText(
        text,
        weight: FontWeight.w700,
        color: color,
        fontSize: fontSize,
      );

  ///fontSize: 15
  ///weight: w700
  static AppText boldItalic(
    String text, {
    Color? color,
    double? fontSize = 15,
  }) =>
      AppText(
        text,
        weight: FontWeight.w700,
        color: color,
        fontSize: fontSize,
        style: FontStyle.italic,
      );

  ///fontSize: 15
  ///weight: w600
  static AppText semiBold(
    String text, {
    Color? color,
    double? fontSize = 15,
    TextAlign? alignment,
    TextDecoration? decoration,
  }) =>
      AppText(
        text,
        decoration: decoration,
        weight: FontWeight.w600,
        alignment: alignment,
        color: color,
        fontSize: fontSize,
      );

  ///fontSize: 15
  ///weight: w600
  static AppText semiBoldItalic(
    String text, {
    Color? color,
    double? fontSize,
    TextAlign? alignment,
    TextDecoration? decoration,
  }) =>
      AppText(
        text,
        decoration: decoration,
        weight: FontWeight.w600,
        alignment: alignment,
        color: color,
        style: FontStyle.italic,
        fontSize: fontSize,
      );

  ///weight: w500
  static AppText medium(
    String text, {
    Color? color,
    double? fontSize,
    TextAlign? alignment,
    TextDecoration? decoration,
  }) =>
      AppText(
        text,
        fontSize: fontSize,
        weight: FontWeight.w500,
        decoration: decoration,
        alignment: alignment,
        color: color,
      );

  ///weight: w500
  static AppText mediumItalic(
    String text, {
    Color? color,
    double? fontSize,
  }) =>
      AppText(
        text,
        fontSize: fontSize,
        style: FontStyle.italic,
        weight: FontWeight.w500,
        color: color,
      );

  ///weight: w500
  ///fontSize: 20
  ///color: #FFFFFF
  static AppText button(
    String text, {
    Color color = AppColors.white,
    double fontSize = 20,
    TextAlign? alignment,
    TextDecoration? decoration,
  }) =>
      AppText(
        text,
        fontSize: fontSize,
        weight: FontWeight.w500,
        decoration: decoration,
        alignment: alignment,
        color: color,
      );

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        decoration: decoration,
        fontSize: fontSize ?? 14,
        color: color,
        fontWeight: weight,
        overflow: overflow,
        fontStyle: style,
      ),
      textAlign: alignment,
    );
  }
}
