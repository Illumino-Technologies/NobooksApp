import 'package:flutter/material.dart';
import 'package:nobook/ui/pages/dashboard/widgets/reusable_tile%20widgets.dart';
import 'package:nobook/utilities/constants.dart';

class CardWidgets extends StatelessWidget {
  const CardWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: 694,
      child: Column(
        children: [
          // ignore: prefer_const_constructors
          SizedBox(
            height: 32,
          ),
          const ReusableTileWidget(),
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
