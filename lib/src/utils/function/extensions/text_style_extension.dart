part of 'extensions.dart';

extension TextStyleExtension on TextStyle {
  TextStyle get withBlack => copyWith(color: AppColors.black);

  TextStyle get withWhite => copyWith(color: AppColors.white);

  TextStyle get withMediumWeight => copyWith(fontWeight: FontWeight.w500);

  TextStyle withSize(double fontSize) => copyWith(fontSize: fontSize);

  TextStyle withColor(Color color) => copyWith(color: color);

  TextStyle withHeight(double height) => copyWith(height: height);
}
