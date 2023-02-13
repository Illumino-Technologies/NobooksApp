// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/features/notes/widgets/reused_card_widget.dart';

class NoteScreen extends ConsumerStatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);
  @override
  NoteScreenState createState() => NoteScreenState();
}

class NoteScreenState extends ConsumerState<NoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 758,
          height: MediaQuery.of(context).size.height,
          color: AppColors.backgroundGrey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 29),
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  // ignore: sort_child_properties_last
                  // ignore: prefer_const_literals_to_create_immutables
                  Row(
                    children: [
                      Text(
                        'Your Notes',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 29,
                        ),
                      ),
                      Spacer(),
                      MaterialButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        height: 38,
                        minWidth: 98,
                        color: AppColors.blue500,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Personal',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: AppColors.backgroundGrey,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'General',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Biology",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        ReusedCardPlus(),
                        SizedBox(
                          width: 8,
                        ),
                        ReusedCardBio(),
                        SizedBox(
                          width: 8,
                        ),
                        ReusedCardBio(),
                        SizedBox(
                          width: 8,
                        ),
                        ReusedCardBio(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Book Keeping",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        ReusedCardPlus(),
                        SizedBox(width: 8),
                        ReusedCardBk(),
                        SizedBox(width: 8),
                        ReusedCardBk(),
                        SizedBox(width: 8),
                        ReusedCardBk(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 48,
                  ),

                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Chemistry",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        ReusedCardPlus(),
                        SizedBox(width: 8),
                        ReusedCardCh(),
                        SizedBox(width: 8),
                        ReusedCardCh(),
                        SizedBox(width: 8),
                        ReusedCardCh(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Civic Education",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        ReusedCardPlus(),
                        SizedBox(width: 8),
                        ReusedCardCv(),
                        SizedBox(width: 8),
                        ReusedCardCv(),
                        SizedBox(width: 8),
                        ReusedCardCv(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Economics",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        ReusedCardPlus(),
                        SizedBox(width: 8),
                        ReusedCardEc(),
                        SizedBox(width: 8),
                        ReusedCardEc(),
                        SizedBox(width: 8),
                        ReusedCardEc(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "English Language",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        ReusedCardPlus(),
                        SizedBox(width: 8),
                        ReusedCardEn(),
                        SizedBox(width: 8),
                        ReusedCardEn(),
                        SizedBox(width: 8),
                        ReusedCardEn(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Further Maths",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        ReusedCardPlus(),
                        SizedBox(width: 8),
                        ReusedCardFm(),
                        SizedBox(width: 8),
                        ReusedCardFm(),
                        SizedBox(width: 8),
                        ReusedCardFm(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Geography",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        ReusedCardPlus(),
                        SizedBox(width: 8),
                        ReusedCardGe(),
                        SizedBox(width: 8),
                        ReusedCardGe(),
                        SizedBox(width: 8),
                        ReusedCardGe(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Maths",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        ReusedCardPlus(),
                        SizedBox(width: 8),
                        ReusedCardMt(),
                        SizedBox(width: 8),
                        ReusedCardMt(),
                        SizedBox(width: 8),
                        ReusedCardMt(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Physics",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        ReusedCardPlus(),
                        ReusedCardPh(),
                        ReusedCardPh(),
                        ReusedCardPh(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 48,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
