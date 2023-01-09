import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/core/extensions/size_extension.dart';
import 'package:nobook/src/core/themes/color.dart';

class DashboardWidget extends ConsumerWidget {
  const DashboardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      children: [
        Container(padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            height: context.height * 0.22,
          width: context.width * 0.50,
          decoration: const BoxDecoration(
              color: AppColors.blue,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    const Text('Exam is close!!!',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Color.fromRGBO(
                                255, 255, 255, 1))),
                    const Text(
                      'The First term examination for the 2022/2023 Academic\nsession comes up on the 3rd of December, 2022.\nYou need to study your notes to prepare well for the exam.',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Color.fromRGBO(234, 235, 237, 1)),
                    ),
                    SizedBox(height: 8.h),
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0)),
                        height: context.height * 0.05,
                        minWidth: context.height * 0.13,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        child: const Text(
                          'Get Started',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize:8,
                              color: AppColors.blue),
                        ),
                        onPressed: () {})
                  ]),
       
            Image.asset('assets/images/books.png')
            ],
          ),
        ),
      ],
    );
  }
}
