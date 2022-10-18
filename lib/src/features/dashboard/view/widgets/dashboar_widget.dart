import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/utils/constants/constants.dart';

class DashboardWidget extends ConsumerWidget {
  const DashboardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      height: 200,
      width: 694,
      decoration: const BoxDecoration(
          color: mBackgroundColor, //kDashWidgetColor
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Container(
        decoration: const BoxDecoration(
            color: kDashWidgetColor,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 29),
          child: Row(
            children: [
              // ignore: prefer_const_literals_to_create_immutables
              SizedBox(
                width: 389,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 36,
                        width: 196,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Exam is close!!!',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28,
                                  color: Color.fromRGBO(255, 255, 255, 1))),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const SizedBox(
                        height: 51,
                        width: 389,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'The First term examination for the 2022/2023 Academic \nsession comes up on the 3rd of December, 2022. \nYou need to study your notes to prepare well for the exam.',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Color.fromRGBO(234, 235, 237, 1)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0)),
                          height: 33,
                          minWidth: 105,
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Get Started',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.blue[500]),
                            ),
                          ),
                          onPressed: () {})
                    ]),
              ),
              const Spacer(),
              Container(
                height: 142,
                width: 166,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/books.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
