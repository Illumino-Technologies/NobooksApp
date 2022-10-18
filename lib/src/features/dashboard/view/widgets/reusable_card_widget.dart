import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/features/dashboard/view/widgets/reusable_tile%20widgets.dart';
import 'package:nobook/src/utils/constants/constants.dart';

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
          GridView.builder(
            itemCount: 4,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, crossAxisSpacing: 16),
            itemBuilder: (context, index) => Container(
              decoration: const BoxDecoration(color: mCardColor),
            ),
          ),
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
          const SizedBox(
            height: 24,
          ),
          GridView.builder(
            itemCount: 4,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, crossAxisSpacing: 16),
            itemBuilder: (context, index) => Container(
              decoration: const BoxDecoration(color: mCardColor),
            ),
          ),
        ],
      ),
    );
  }
}
