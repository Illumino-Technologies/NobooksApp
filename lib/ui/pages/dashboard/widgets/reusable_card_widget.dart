// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:nobook/utilities/constants.dart';

class ReusableCardWidget extends StatelessWidget {
  final imageAsset;
  final String? title;
  final String? description;
  final String? date;

  const ReusableCardWidget(
      {Key? key, this.imageAsset, this.title, this.description, this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Card(
      color: mCardColor,
      elevation: 2.0,
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        height: 160,
        width: 160,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              Container(
                height: 32,
                width: 32,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Image.asset(''),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                title!,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Nunito',
                    color: Color.fromRGBO(56, 63, 77, 1)),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  description!,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Nunito',
                      color: Color.fromRGBO(137, 140, 148, 1)),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                date!,
                style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Nunito',
                    color: Color.fromRGBO(153, 158, 170, 1)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
