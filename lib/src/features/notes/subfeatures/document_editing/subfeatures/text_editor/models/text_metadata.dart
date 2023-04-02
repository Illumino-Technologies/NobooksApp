import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nobook/src/features/features_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/function/util_functions/util_functions.dart';

class TextMetadata extends Equatable {
  final Color color;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final double fontSize;
  final TextDecorationEnum decoration;
  final List<FontFeature>? fontFeatures;
  final TextAlign alignment;

  const TextMetadata({
    this.color = AppColors.black,
    this.fontWeight = FontWeight.w400,
    this.fontStyle = FontStyle.normal,
    this.fontSize = 14,
    this.alignment = TextAlign.start,
    this.decoration = TextDecorationEnum.none,
    this.fontFeatures,
  });

  TextMetadata copyWith({
    Color? color,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? fontSize,
    TextDecoration? decoration,
    List<FontFeature>? fontFeatures,
    TextAlign? alignment,
  }) {
    return TextMetadata(
      color: color ?? this.color,
      fontWeight: fontWeight ?? this.fontWeight,
      fontStyle: fontStyle ?? this.fontStyle,
      fontSize: fontSize ?? this.fontSize,
      decoration: decoration ?? this.decoration,
      fontFeatures: fontFeatures ?? this.fontFeatures,
      alignment: alignment ?? this.alignment,
    );
  }

  TextStyle get style =>
      TextStyle(
        fontSize: fontSize,
        color: color,
        decoration: decoration.value,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        fontFeatures: fontFeatures,
      );

  @override
  List<Object?> get props =>
      [
        color,
        fontWeight,
        fontStyle,
        fontSize,
        alignment,
        decoration,
        fontFeatures,
      ];

  Map<String, dynamic> toMap() {
    return {
      'color': color.toSerializerString,
      'fontWeight': fontWeight.index,
      'fontStyle': fontStyle.index,
      'fontSize': fontSize,
      'fontFeatures': fontFeatures?.map((e) => _fontFeatureToMap(e)).toList(),
      'alignment': alignment.index,
      //Todo figure out text decoration serialization
      'decoration': decoration.index,
    };
  }

  factory TextMetadata.fromMap(Map<String, dynamic> map) {
    return TextMetadata(
      color: UtilFunctions.colorFromMap(map),
      fontWeight: FontWeight.values[(map['fontWeight'])],
      fontStyle: FontStyle.values[(map['fontStyle'])],
      fontSize: map['fontSize'] as double,
      fontFeatures: (map['fontFeatures'] as List)
          .cast<Map<String, dynamic>>()
          .map((e) => _fontFeatureFromMap(e))
          .toList(),
      alignment: TextAlign.values[(map['alignment'])],
      //Todo figure out text decoration serialization
      decoration: map['decoration'] as TextDecoration,
    );
  }
}


FontFeature _fontFeatureFromMap(Map map) {
  return FontFeature(
    map['feature'],
    map['value'],
  );
}

Map<String, dynamic> _fontFeatureToMap(FontFeature feature) {
  return {
    'feature': feature.feature,
    'value': feature.value,
  };
}


enum TextDecorationEnum {
  none(TextDecoration.none),
  underline(TextDecoration.underline),
  strikeThrough(TextDecoration.lineThrough),
  ;

  final TextDecoration value;

  const TextDecorationEnum(this.value);


}