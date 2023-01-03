import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/core/themes/color.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:nobook/src/features/dashboard/models/cardinfo.dart';
import 'package:nobook/src/features/dashboard/view/widgets/reusable_tile%20widgets.dart';

class CardWidgets extends ConsumerWidget {
  const CardWidgets({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return SizedBox(
      height: 280.h,
      width: 694.w,
      child: Column(
        children: [
          // ignore: prefer_const_constructors
          SizedBox(
            height: 20.h,
          ),
          const ReusableTileWidget1(),
          SizedBox(
            height: 24.h,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  width: 160.w,
                  height: 160.h,
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
                        SizedBox(
                          height: 41.h,
                        ),
                        Center(
                          child: Image.asset('assets/plus.png'),
                        ),
                        SizedBox(
                          height: 17.h,
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
                SizedBox(
                  width: 16.w,
                ),
                Container(
                  width: 160.w,
                  height: 160.h,
                  decoration: const BoxDecoration(
                      color: AppColors.mCardColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 16.h,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 32.h,
                              width: 32.w,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                                image: DecorationImage(
                                  image: AssetImage('assets/subjects/mt.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 59.w,
                            ),
                            Container(
                              height: 15.h,
                              width: 39.w,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                                image: DecorationImage(
                                  image: AssetImage('assets/new.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                              text: const TextSpan(
                                  text: 'Math',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                  children: <TextSpan>[
                                TextSpan(
                                    text: '\nSet Theory',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey))
                              ])),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                              text: const TextSpan(
                                  text: '18th April, 2022 . 09:31am',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                    fontSize: 8,
                                  ),
                                  children: <TextSpan>[
                                TextSpan(
                                    text: '',
                                    style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black12))
                              ])),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
                Container(
                  width: 160.w,
                  height: 160.h,
                  decoration: const BoxDecoration(
                      color: AppColors.mCardColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 16.h,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 32.h,
                              width: 32.h,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                                image: DecorationImage(
                                  image: AssetImage('assets/subjects/bi.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 59.w,
                            ),
                            Container(
                              height: 15.h,
                              width: 39.w,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                                image: DecorationImage(
                                  image: AssetImage('assets/new.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                              text: const TextSpan(
                                  text: 'Biology',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                  children: <TextSpan>[
                                TextSpan(
                                    text: '\nCell Theory',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey))
                              ])),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                              text: const TextSpan(
                                  text: '18th April, 2022 . 09:31am',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                    fontSize: 8,
                                  ),
                                  children: <TextSpan>[
                                TextSpan(
                                    text: '',
                                    style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black12))
                              ])),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
                Container(
                  width: 160.w,
                  height: 160.h,
                  decoration: const BoxDecoration(
                      color: AppColors.mCardColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 32.h,
                              width: 32.w,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                                image: DecorationImage(
                                  image: AssetImage('assets/subjects/fm.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 59.w,
                            ),
                            Container(
                              height: 15.h,
                              width: 39.w,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                                image: DecorationImage(
                                  image: AssetImage('assets/new.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                              text: const TextSpan(
                                  text: 'Further Maths',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                  children: <TextSpan>[
                                TextSpan(
                                    text: '\nDifferentiation',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey))
                              ])),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                              text: const TextSpan(
                                  text: '18th April, 2022 . 09:31am',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                    fontSize: 8,
                                  ),
                                  children: <TextSpan>[
                                TextSpan(
                                    text: '',
                                    style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black12))
                              ])),
                        ),
                      ],
                    ),
                  ),
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
      height: 290.h,
      width: 694.w,
      child: Column(
        children: [
          // ignore: prefer_const_constructors
          SizedBox(
            height: 20.h,
          ),
          const ReusableTileWidget2(),
          SizedBox(
            height: 24.h,
          ),
          Row(
            children: [
              Container(
                width: 160.w,
                height: 160.h,
                decoration: BoxDecoration(
                    color: AppColors.mCardColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.r),
                    )),
                child: Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 16.h,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              height: 32.h,
                              width: 32.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4.r),
                                ),
                                image: const DecorationImage(
                                  image: AssetImage('assets/subjects/ec.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 59.w,
                            ),
                            Container(
                              height: 15.h,
                              width: 39.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4.r),
                                ),
                                image: const DecorationImage(
                                  image: AssetImage('assets/undone.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                            text: TextSpan(
                                text: 'Economics',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                ),
                                children: <TextSpan>[
                              TextSpan(
                                  text: '\nDemand and Supply',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey))
                            ])),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                            text: TextSpan(
                                text: '18th April, 2022 . 09:31am',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                  fontSize: 8.sp,
                                ),
                                children: <TextSpan>[
                              TextSpan(
                                  text: '\nExpires 19th April, 8:00am',
                                  style: TextStyle(
                                      fontSize: 8.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black12))
                            ])),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 16.w,
              ),
              Container(
                width: 160.w,
                height: 160.w,
                decoration: BoxDecoration(
                    color: AppColors.mCardColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.r),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 32,
                            width: 32,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              image: DecorationImage(
                                image: AssetImage('assets/subjects/bi.png'),
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
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              image: DecorationImage(
                                image: AssetImage('assets/undone.png'),
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
                            text: const TextSpan(
                                text: 'Biology',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                                children: <TextSpan>[
                              TextSpan(
                                  text: '\nCell Theory',
                                  style: TextStyle(
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
                            text: const TextSpan(
                                text: '18th April, 2022 . 09:31am',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                  fontSize: 8,
                                ),
                                children: <TextSpan>[
                              TextSpan(
                                  text: '\nExpires 19th April, 8:00am',
                                  style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black12))
                            ])),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
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
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 32,
                            width: 32,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              image: DecorationImage(
                                image: AssetImage('assets/subjects/fm.png'),
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
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              image: DecorationImage(
                                image: AssetImage('assets/submitted.png'),
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
                            text: const TextSpan(
                                text: 'Further Maths',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                                children: <TextSpan>[
                              TextSpan(
                                  text: '\nDifferentiation',
                                  style: TextStyle(
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
                            text: const TextSpan(
                                text: '18th April, 2022 . 09:31am',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                  fontSize: 8,
                                ),
                                children: <TextSpan>[
                              TextSpan(
                                  text: '\nExpires 19th April, 8:00am',
                                  style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black12))
                            ])),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
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
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 32,
                            width: 32,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              image: DecorationImage(
                                image: AssetImage('assets/subjects/en.png'),
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
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              image: DecorationImage(
                                image: AssetImage('assets/expired.png'),
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
                            text: const TextSpan(
                                text: 'English',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                                children: <TextSpan>[
                              TextSpan(
                                  text: '\nPhrases and Clauses',
                                  style: TextStyle(
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
                            text: const TextSpan(
                                text: '18th April, 2022 . 09:31am',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                  fontSize: 8,
                                ),
                                children: <TextSpan>[
                              TextSpan(
                                  text: '\nExpires 19th April, 8:00am',
                                  style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black12))
                            ])),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
