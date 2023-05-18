import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/features/dashboard/view/widgets/reusable_cardWidget.dart';
import 'package:nobook/src/features/dashboard/view/widgets/reusable_tile%20widgets.dart';

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
              children: const [
                ReuseableCard(
                  title: 'Economics',
                  subTitle: 'Demand and Supply',
                  bottomtitle: '18th April, 2022 . 09:31am',
                  bottomsubTitle: 'Expires 19th April, 8:00am',
                  firstImage: 'assets/subjects/ec.png',
                  secondImage: 'assets/undone.png',
                ),
                SizedBox(
                  width: 16,
                ),
                ReuseableCard(
                  title: 'Biology',
                  subTitle: 'Cell Theory',
                  bottomtitle: '18th April, 2022 . 09:31am',
                  bottomsubTitle: 'Expires 19th April, 8:00am',
                  firstImage: 'assets/subjects/bi.png',
                  secondImage: 'assets/undone.png',
                ),
                SizedBox(
                  width: 16,
                ),
                ReuseableCard(
                  title: 'Further Maths',
                  subTitle: 'Differentiation',
                  bottomtitle: '18th April, 2022 . 09:31am',
                  bottomsubTitle: 'Expires 19th April, 8:00am',
                  firstImage: 'assets/subjects/fm.png',
                  secondImage: 'assets/submitted.png',
                ),
                SizedBox(
                  width: 16,
                ),
                ReuseableCard(
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
