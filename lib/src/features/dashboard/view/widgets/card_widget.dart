import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/core/themes/color.dart';
import 'package:nobook/src/features/dashboard/view/widgets/reusable_cardWidget.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:nobook/src/features/dashboard/models/cardinfo.dart';
import 'package:nobook/src/features/dashboard/view/widgets/reusable_tile%20widgets.dart';

class CardWidgets extends ConsumerWidget {
  const CardWidgets({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return SizedBox(
      height: 280,
      width: 694,
      child: Column(
        children: [
          // ignore: prefer_const_constructors
          SizedBox(
            height: 20,
          ),
          const ReusableTileWidget1(),
          const SizedBox(
            height: 24,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  width: 160,
                  height: 160,
                  decoration: const BoxDecoration(
                      color: AppColors.mCardColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const SizedBox(
                          height: 41,
                        ),
                        Center(
                          child: Image.asset('assets/plus.png'),
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Add new note',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(93, 93, 93, 1),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                const ReuseableCard(
                  title: 'Math',
                  subTitle: 'Set Theory',
                  bottomtitle: '18th April, 2022 . 09:31am',
                  bottomsubTitle: '',
                  firstImage: 'assets/subjects/mt.png',
                  secondImage: 'assets/new.png',
                ),
                const SizedBox(
                  width: 16,
                ),
                const ReuseableCard(
                  title: 'Biology',
                  subTitle: 'Cell Theory',
                  bottomtitle: '18th April, 2022 . 09:31am',
                  bottomsubTitle: '',
                  firstImage: 'assets/subjects/bi.png',
                  secondImage: 'assets/new.png',
                ),
                const SizedBox(
                  width: 16,
                ),
                const ReuseableCard(
                  title: 'Further Maths',
                  subTitle: 'Differentiation',
                  bottomtitle: '18th April, 2022 . 09:31am',
                  bottomsubTitle: '',
                  firstImage: 'assets/subjects/fm.png',
                  secondImage: 'assets/new.png',
                ),
              ],
            ),
          ),
          // GridView.builder(
          //   itemCount: demoMyFiles.length,
          //   shrinkWrap: true,
          //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 4, crossAxisSpacing: 16),
          //   itemBuilder: (context, index) => Container(
          //     decoration: const BoxDecoration(
          //         color: mCardColor,
          //         borderRadius: BorderRadius.all(
          //           Radius.circular(8),
          //         )),
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Column(
          //         children: [
          //           Row(
          //             children: [
          //               Container(
          //                 height: 32,
          //                 width: 32,
          //                 decoration: const BoxDecoration(
          //                   borderRadius: BorderRadius.all(
          //                     Radius.circular(4),
          //                   ),
          //                 ),
          //                 child: Image.asset(info.pngSrc!),
          //               )
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class CardWidgets2 extends ConsumerWidget {
  const CardWidgets2({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return SizedBox(
      height: 280,
      width: 694,
      child: Column(
        children: [
          // ignore: prefer_const_constructors
          SizedBox(
            height: 20,
          ),
          const ReusableTileWidget2(),
          // SizedBox(
          //   height: 15.h,
          // ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const ReuseableCard(
                  title: 'Economics',
                  subTitle: 'Demand and Supply',
                  bottomtitle: '18th April, 2022 . 09:31am',
                  bottomsubTitle: 'Expires 19th April, 8:00am',
                  firstImage: 'assets/subjects/ec.png',
                  secondImage: 'assets/undone.png',
                ),
                const SizedBox(
                  width: 16,
                ),
                const ReuseableCard(
                  title: 'Biology',
                  subTitle: 'Cell Theory',
                  bottomtitle: '18th April, 2022 . 09:31am',
                  bottomsubTitle: 'Expires 19th April, 8:00am',
                  firstImage: 'assets/subjects/bi.png',
                  secondImage: 'assets/undone.png',
                ),
                const SizedBox(
                  width: 16,
                ),
                const ReuseableCard(
                  title: 'Further Maths',
                  subTitle: 'Differentiation',
                  bottomtitle: '18th April, 2022 . 09:31am',
                  bottomsubTitle: 'Expires 19th April, 8:00am',
                  firstImage: 'assets/subjects/fm.png',
                  secondImage: 'assets/submitted.png',
                ),
                const SizedBox(
                  width: 16,
                ),
                const ReuseableCard(
                  title: 'English',
                  subTitle: 'Phrases and Clauses',
                  bottomtitle: '18th April, 2022 . 09:31am',
                  bottomsubTitle: 'Expires 19th April, 8:00am',
                  firstImage: 'assets/subjects/en.png',
                  secondImage: 'assets/expired.png',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
