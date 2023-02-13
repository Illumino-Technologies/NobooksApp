// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';

class ReuseableCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String bottomtitle;
  final String bottomsubTitle;
  final String firstImage;
  final String secondImage;

  const ReuseableCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.bottomtitle,
    required this.bottomsubTitle,
    required this.firstImage,
    required this.secondImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 160,
      decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const SizedBox(
              width: 16,
            ),
            Row(
              children: [
                Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4),
                    ),
                    image: DecorationImage(
                      image: AssetImage(firstImage),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 59,
                ),
                Container(
                  height: 15,
                  width: 39,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4),
                    ),
                    image: DecorationImage(
                      image: AssetImage(secondImage),
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                  text: TextSpan(
                      text: title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <TextSpan>[
                    TextSpan(
                        text: '\n$subTitle',
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey))
                  ])),
            ),
            const SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                  text: TextSpan(
                      text: bottomtitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        fontSize: 8,
                      ),
                      children: <TextSpan>[
                    TextSpan(
                        text: '\n$bottomsubTitle',
                        style: const TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            color: Colors.black12))
                  ])),
            ),
          ],
        ),
      ),
    );
  }
}
