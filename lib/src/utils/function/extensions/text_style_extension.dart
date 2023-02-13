part of 'extensions.dart';

extension TextStyleExtension on TextStyle {
  // TextStyle get withTextBlack => copyWith(color: AppColors.textBlack);
  //
  // ///Body Text Color
  // TextStyle get withTextGrey => copyWith(color: AppColors.textGrey);
  //
  // TextStyle get withInactiveGrey => copyWith(color: AppColors.textGreyVariant);
  //
  // TextStyle get withBlack => copyWith(color: AppColors.black);
  //
  // TextStyle get withWhite => copyWith(color: AppColors.white);

  TextStyle get withMediumWeight => copyWith(fontWeight: FontWeight.w500);

  TextStyle withSize(double fontSize) => copyWith(fontSize: fontSize);

  TextStyle withColor(Color color) => copyWith(color: color);

  TextStyle withHeight(double height) => copyWith(height: height);

  static void doThis(){}

}
