import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/global/global_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

abstract final class Ui {
  static BorderRadius allBorderRadius(double radius) => BorderRadius.all(
        Radius.circular(radius),
      );

  static BorderRadius topBorderRadius(double radius) => BorderRadius.vertical(
        top: Radius.circular(radius),
      );

  static BorderRadius bottomBorderRadius(double radius) =>
      BorderRadius.vertical(
        bottom: Radius.circular(radius),
      );

  static Widget cacheNetworkImageLoadingBuilder(
    BuildContext context,
    String url,
    DownloadProgress progress,
  ) {
    if (progress.downloaded == progress.totalSize ||
        progress.progress == null) {
      return Container();
    }
    return Center(
      child: CircularProgressIndicator(
        value: progress.progress,
        strokeWidth: 3,
      ),
    );
  }

  static InputDecoration authFieldDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyles.paragraph2.copyWith(
        fontSize: 16.spMax,
        height: 1.5,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.l),
        borderSide: const BorderSide(
          color: AppColors.neutral200,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.l),
        borderSide: const BorderSide(
          color: AppColors.neutral200,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.l),
        borderSide: const BorderSide(
          color: AppColors.neutral200,
        ),
      ),
    );
  }

  static void showErrorSnackbar(String message) {
    //TODO: implement
  }

  static Widget imageLoadingBuilder(
    BuildContext context,
    Widget child,
    ImageChunkEvent? loadingProgress,
  ) {
    if (loadingProgress == null) return child;
    return Container(
      color: AppColors.white.withOpacity(0.3),
      child: Center(
        child: Opacity(
          opacity: 0.7,
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        ),
      ),
    );
  }

  static Widget generalImageErrorBuilder(context, error, stackTrace) {
    return Container(
      color: AppColors.neutral200,
      child: const Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          color: AppColors.neutral200,
          size: 25,
        ),
      ),
    );
  }
}
