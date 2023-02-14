import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/features/notes/notes_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';

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
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Your Notes',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 29,
                        ),
                      ),
                      const Spacer(),
                      MaterialButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        height: 38,
                        minWidth: 98,
                        color: AppColors.blue500,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
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
                      const Padding(
                        padding: EdgeInsets.all(8.0),
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
                  const SizedBox(height: 20),
                  const Align(
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
                  const SizedBox(
                    height: 24,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const ReusedCardPlus(),
                        const SizedBox(
                          width: 8,
                        ),
                        const ReusedCardBio(),
                        const SizedBox(
                          width: 8,
                        ),
                        const ReusedCardBio(),
                        const SizedBox(
                          width: 8,
                        ),
                        const ReusedCardBio(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  const Align(
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
                  const SizedBox(
                    height: 24,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const ReusedCardPlus(),
                        const SizedBox(width: 8),
                        const ReusedCardBk(),
                        const SizedBox(width: 8),
                        const ReusedCardBk(),
                        const SizedBox(width: 8),
                        const ReusedCardBk(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),

                  const Align(
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
                  const SizedBox(
                    height: 24,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const ReusedCardPlus(),
                        const SizedBox(width: 8),
                        const ReusedCardCh(),
                        const SizedBox(width: 8),
                        const ReusedCardCh(),
                        const SizedBox(width: 8),
                        const ReusedCardCh(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  const Align(
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
                  const SizedBox(
                    height: 24,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const ReusedCardPlus(),
                        const SizedBox(width: 8),
                        const ReusedCardCv(),
                        const SizedBox(width: 8),
                        const ReusedCardCv(),
                        const SizedBox(width: 8),
                        const ReusedCardCv(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  const Align(
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
                  const SizedBox(
                    height: 24,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const ReusedCardPlus(),
                        const SizedBox(width: 8),
                        const ReusedCardEc(),
                        const SizedBox(width: 8),
                        const ReusedCardEc(),
                        const SizedBox(width: 8),
                        const ReusedCardEc(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  const Align(
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
                  const SizedBox(
                    height: 24,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const ReusedCardPlus(),
                        const SizedBox(width: 8),
                        const ReusedCardEn(),
                        const SizedBox(width: 8),
                        const ReusedCardEn(),
                        const SizedBox(width: 8),
                        const ReusedCardEn(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  const Align(
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
                  const SizedBox(
                    height: 24,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const ReusedCardPlus(),
                        const SizedBox(width: 8),
                        const ReusedCardFm(),
                        const SizedBox(width: 8),
                        const ReusedCardFm(),
                        const SizedBox(width: 8),
                        const ReusedCardFm(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  const Align(
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
                  const SizedBox(
                    height: 24,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const ReusedCardPlus(),
                        const SizedBox(width: 8),
                        const ReusedCardGe(),
                        const SizedBox(width: 8),
                        const ReusedCardGe(),
                        const SizedBox(width: 8),
                        const ReusedCardGe(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  const Align(
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
                  const SizedBox(
                    height: 24,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const ReusedCardPlus(),
                        const SizedBox(width: 8),
                        const ReusedCardMt(),
                        const SizedBox(width: 8),
                        const ReusedCardMt(),
                        const SizedBox(width: 8),
                        const ReusedCardMt(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  const Align(
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
                  const SizedBox(
                    height: 24,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const ReusedCardPlus(),
                        const ReusedCardPh(),
                        const ReusedCardPh(),
                        const ReusedCardPh(),
                      ],
                    ),
                  ),
                  const SizedBox(
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
