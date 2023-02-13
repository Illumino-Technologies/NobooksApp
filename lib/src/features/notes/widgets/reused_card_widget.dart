import 'package:flutter/material.dart';
import 'package:nobook/src/core/themes/color.dart';

class ReusedCardBio extends StatelessWidget {
  const ReusedCardBio({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      image: AssetImage('assets/new.png'),
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
                        text: '\nEvolution',
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
    );
  }
}

class ReusedCardPlus extends StatelessWidget {
  const ReusedCardPlus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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

class ReusedCardBk extends StatelessWidget {
  const ReusedCardBk({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      image: AssetImage('assets/subjects/bk.png'),
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
                      image: AssetImage('assets/new.png'),
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
                      text: 'Book Keeping',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      children: <TextSpan>[
                    TextSpan(
                        text: '\nTrial Balance',
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
    );
  }
}

class ReusedCardCh extends StatelessWidget {
  const ReusedCardCh({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      image: AssetImage('assets/subjects/ch.png'),
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
                      image: AssetImage('assets/new.png'),
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
                      text: 'Chemistry',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      children: <TextSpan>[
                    TextSpan(
                        text: '\nRedox Reactions',
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
    );
  }
}

class ReusedCardCv extends StatelessWidget {
  const ReusedCardCv({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      image: AssetImage('assets/subjects/cv.png'),
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
                      image: AssetImage('assets/new.png'),
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
                      text: 'Civic Education',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      children: <TextSpan>[
                    TextSpan(
                        text: '\nThe Constitution',
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
    );
  }
}

class ReusedCardEc extends StatelessWidget {
  const ReusedCardEc({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      image: AssetImage('assets/subjects/ec.png'),
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
                      image: AssetImage('assets/new.png'),
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
                      text: 'Economics',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      children: <TextSpan>[
                    TextSpan(
                        text: '\nDemand and Supply',
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
                        text: '\n',
                        style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            color: Colors.black12))
                  ])),
            ),
          ],
        ),
      ),
    );
  }
}

class ReusedCardEn extends StatelessWidget {
  const ReusedCardEn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      image: AssetImage('assets/new.png'),
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
                        text: '\n',
                        style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            color: Colors.black12))
                  ])),
            ),
          ],
        ),
      ),
    );
  }
}

class ReusedCardFm extends StatelessWidget {
  const ReusedCardFm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      image: AssetImage('assets/new.png'),
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
                      text: 'Further Math',
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
                        text: '\n',
                        style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            color: Colors.black12))
                  ])),
            ),
          ],
        ),
      ),
    );
  }
}

class ReusedCardGe extends StatelessWidget {
  const ReusedCardGe({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      image: AssetImage('assets/subjects/ge.png'),
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
                      image: AssetImage('assets/new.png'),
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
                      text: 'Geography',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      children: <TextSpan>[
                    TextSpan(
                        text: '\nRelief and Drainage',
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
                        text: '\n',
                        style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            color: Colors.black12))
                  ])),
            ),
          ],
        ),
      ),
    );
  }
}

class ReusedCardMt extends StatelessWidget {
  const ReusedCardMt({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      image: AssetImage('assets/subjects/mt.png'),
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
                      image: AssetImage('assets/new.png'),
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
                      text: 'Maths',
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
                        text: '\n',
                        style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            color: Colors.black12))
                  ])),
            ),
          ],
        ),
      ),
    );
  }
}

class ReusedCardPh extends StatelessWidget {
  const ReusedCardPh({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      image: AssetImage('assets/subjects/ph.png'),
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
                      image: AssetImage('assets/new.png'),
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
                      text: 'Physics',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      children: <TextSpan>[
                    TextSpan(
                        text: '\nParticulate Nature of Matter',
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
                        text: '\n',
                        style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            color: Colors.black12))
                  ])),
            ),
          ],
        ),
      ),
    );
  }
}
