import 'package:flutter/material.dart';

/// ### Neutral Colors:
/// These colors are used as
/// supporting secondary colors in
/// backgrounds, text colors, separators, modals etc.
///
/// ### Primary Colors:
/// The primary color palette
/// is used across all interactive elements
/// such as CTAs, links, active states, inputs etc.
///
/// ### Accent Colors:
/// The Accent color palette
/// is used to accompany the primary color.
/// It is used for emphasis, to enhance a color scheme,
/// or to liven up the design
///
/// ### Success Colors:
/// These colors depict an emotion of positivity.
/// Generally used across success and complete states.
///
/// ### Warning Colors:
/// These colors depict an emotion of holding.
/// Generally used across on-hold or warning states.
///
/// ### Error:
/// These colors depict an emotion of negativity.
/// Generally used across error states
///
/// ### Background: These colors are used for texts, backgrounds etc.
///
/// ### Note:
/// - subjectColors all have 40 opacity
abstract class AppColors {
  ///#080B17
  static const Color neutral900 = Color(0xFF080B17);

  ///#050F23
  static const Color neutral800 = Color(0xFF050F23);

  ///#141F35
  static const Color neutral700 = Color(0xFF141F35);

  ///#383F4D
  static const Color neutral600 = Color(0xFF383F4D);

  ///#4F5669
  static const Color neutral500 = Color(0xFF4F5669);

  ///#636876
  static const Color neutral400 = Color(0xFF636876);

  ///#898C94
  static const Color neutral300 = Color(0xFF898C94);

  ///#999EAA
  static const Color neutral200 = Color(0xFF999EAA);

  ///#D2D4D9
  static const Color neutral100 = Color(0xFFD2D4D9);

  ///#EAEBED
  static const Color neutral50 = Color(0xFFEAEBED);

  ///Primary
  ///#000B47
  static const Color blue900 = Color(0xFF000B47);

  ///#00147D
  static const Color blue800 = Color(0xFF00147D);

  ///#001AA0
  static const Color blue700 = Color(0xFF001AA0);

  ///#001FC4
  static const Color blue600 = Color(0xFF001FC4);

  ///#0C33FF
  static const Color blue500 = Color(0xFF0C33FF);

  ///#2447FF
  static const Color blue400 = Color(0xFF2447FF);

  ///#5570FF
  static const Color blue300 = Color(0xFF5570FF);

  ///#8599FF
  static const Color blue200 = Color(0xFF8599FF);

  ///#B6C2FF
  static const Color blue100 = Color(0xFFB6C2FF);

  ///#E7EBFF
  static const Color blue50 = Color(0xFFE7EBFF);

  ///Success
  ///#005723
  static const Color green900 = Color(0xFF005723);

  ///#007830
  static const Color green800 = Color(0xFF007830);

  ///#00A341
  static const Color green700 = Color(0xFF00A341);

  ///#00C44E
  static const Color green600 = Color(0xFF00C44E);

  ///#00DA57
  static const Color green500 = Color(0xFF00DA57);

  ///#0AFF6C
  static const Color green400 = Color(0xFF0AFF6C);

  ///#5BFF9D
  static const Color green300 = Color(0xFF5BFF9D);

  ///#8AFFB9
  static const Color green200 = Color(0xFF8AFFB9);

  ///#B9FFD5
  static const Color green100 = Color(0xFFB9FFD5);

  ///#DCFFEA
  static const Color green50 = Color(0xFFDCFFEA);

  ///Warning
  ///#594B00
  static const Color yellow900 = Color(0xFF594B00);

  ///#806B00
  static const Color yellow800 = Color(0xFF806B00);

  ///#B39600
  static const Color yellow700 = Color(0xFFB39600);

  ///#E6C100
  static const Color yellow600 = Color(0xFFE6C100);

  ///#FFD600
  static const Color yellow500 = Color(0xFFFFD600);

  ///#FFDE33
  static const Color yellow400 = Color(0xFFFFDE33);

  ///#FFDE33
  static const Color yellow300 = Color(0xFFFFDE33);

  ///#FFE870
  static const Color yellow200 = Color(0xFFFFE870);

  ///#FFF0A3
  static const Color yellow100 = Color(0xFFFFF0A3);

  ///#FFF8D6
  static const Color yellow50 = Color(0xFFFFF8D6);

  ///Warning
  ///#6F0000
  static const Color red900 = Color(0xFF6F0000);

  ///#9F0000
  static const Color red800 = Color(0xFF9F0000);

  ///#CF0000
  static const Color red700 = Color(0xFFCF0000);

  ///#FF1F1F
  static const Color red600 = Color(0xFFFF1F1F);

  ///#FF3F3F
  static const Color red500 = Color(0xFFFF3F3F);

  ///#FF5656
  static const Color red400 = Color(0xFFFF5656);

  ///#FF8484
  static const Color red300 = Color(0xFFFF8484);

  ///#FF8484
  static const Color red200 = Color(0xFFFF8484);

  ///#FFC9C9
  static const Color red100 = Color(0xFFFFC9C9);

  ///#FFE0E0
  static const Color red50 = Color(0xFFFFE0E0);

  ///#FBFBFB
  static const Color backgroundGrey = Color(0xFFFBFBFB);

  ///#0A0807
  static const Color backgroundBlack = Color(0xFF0A0807);

  ///#FFFFFF
  static const Color white = Color(0xFFFFFFFF);

  ///#000000
  static const Color black = Color(0xFF000000);

  ///#000000 0%
  static const Color transparent = Color(0x00000000);

  ///#0C33FF 40%
  static const Color subjectBlue = Color(0x660C33FF);

  ///#0C33FF 40%
  static const Color subjectOffBlue = Color(0x66249AFF);

  ///#296B01 40%
  static const Color subjectGreen = Color(0x66296B01);

  ///#FC7496 40%
  static const Color subjectPink = Color(0x66FC7496);

  ///#AF013B 40%
  static const Color subjectWine = Color(0x66AF013B);

  ///#D26500 40%
  static const Color subjectDarkOrange = Color(0x66D26500);

  ///#20D2B2 40%
  static const Color subjectLightGreen = Color(0x6620D2B2);

  ///#085B7666 40%
  static const Color subjectLightBlue = Color(0x66085B76);

  ///#DB07A7 40%
  static const Color subjectPurple = Color(0x66DB07A7);

  ///#DBA507 40%
  static const Color subjectOrange = Color(0x66DBA507);

  ///#A9C499 40%
  static const Color subjectGreenVariant = Color(0x66A9C499);

  ///#A7D6FF 40%
  static const Color subjectLightBlueVariant = Color(0x66A7D6FF);

  ///#F19CDC 40%
  static const Color subjectPinkVariant = Color(0x66F19CDC);
}
