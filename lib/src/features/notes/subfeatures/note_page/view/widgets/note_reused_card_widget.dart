import 'package:flutter/material.dart';
import 'package:nobook/src/features/notes/model/note_list.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';
import 'package:nobook/src/utils/function/extensions/extensions.dart';

class BiologyNoteCards extends StatelessWidget {
  const BiologyNoteCards({
    super.key,
  });

  // final Subject? subject;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Biology',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          20.boxHeight,
          Row(
            children: [
              16.boxWidth,
              const AddNoteCards(),
              8.boxWidth,
              Expanded(
                child: SizedBox(
                  height: 160,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: biologynote.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          width: 160,
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
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
                                          image: AssetImage(
                                            'assets/subjects/bk.png',
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(
                                      text: biologynote[index].subject.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '\n${biologynote[index].topic}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(
                                      text: biologynote[index]
                                          .createdAt
                                          .toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                        fontSize: 8,
                                      ),
                                      children: const [
                                        TextSpan(
                                          text: '',
                                          style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black12,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChemistryNoteCards extends StatelessWidget {
  const ChemistryNoteCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Chemistry',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          20.boxHeight,
          Row(
            children: [
              16.boxWidth,
              const AddNoteCards(),
              Expanded(
                child: SizedBox(
                  height: 160,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: chemistrynote.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          width: 160,
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
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
                                          image: AssetImage(
                                              'assets/subjects/ch.png',),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(
                                      text: chemistrynote[index].subject.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              '\n${chemistrynote[index].topic}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(
                                      text: chemistrynote[index]
                                          .createdAt
                                          .toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                        fontSize: 8,
                                      ),
                                      children: const [
                                        TextSpan(
                                          text: '',
                                          style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black12,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BookKeepingNoteCards extends StatelessWidget {
  const BookKeepingNoteCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Book Keeping',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          20.boxHeight,
          Row(
            children: [
              16.boxWidth,
              const AddNoteCards(),
              Expanded(
                child: SizedBox(
                  height: 160,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: bookeepingnote.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          width: 160,
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
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
                                          image: AssetImage(
                                              'assets/subjects/bk.png',),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(
                                      text: bookeepingnote[index].subject.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              '\n${bookeepingnote[index].topic}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(
                                      text: bookeepingnote[index]
                                          .createdAt
                                          .toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                        fontSize: 8,
                                      ),
                                      children: const [
                                        TextSpan(
                                          text: '',
                                          style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black12,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CivicNoteCards extends StatelessWidget {
  const CivicNoteCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Civic Education',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          20.boxHeight,
          Row(
            children: [
              16.boxWidth,
              const AddNoteCards(),
              Expanded(
                child: SizedBox(
                  height: 160,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: civicnote.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          width: 160,
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
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
                                          image: AssetImage(
                                              'assets/subjects/cv.png',),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(
                                      text: civicnote[index].subject.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '\n${civicnote[index].topic}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(
                                      text:
                                          civicnote[index].createdAt.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                        fontSize: 8,
                                      ),
                                      children: const [
                                        TextSpan(
                                          text: '',
                                          style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black12,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AddNoteCards extends StatelessWidget {
  const AddNoteCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 160,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
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
    );
  }
}
