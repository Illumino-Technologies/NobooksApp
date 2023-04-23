import 'package:flutter/material.dart';
import 'package:nobook/src/features/assignments/assignment_barrel.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';

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

class ReusedAssCard extends StatelessWidget {
  final String image;
  final String subject;
  final String topic;
  final String date;
  final String expire;
  final String status;

  const ReusedAssCard({
    super.key,
    required this.image,
    required this.subject,
    required this.topic,
    required this.date,
    required this.expire,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AssignmentNote()),
        );
      },
      child: Container(
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
            children: [
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(4),
                      ),
                      image: DecorationImage(
                        image: AssetImage(image),
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
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(4),
                      ),
                      image: DecorationImage(
                        image: AssetImage(status),
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
                  text: TextSpan(
                    text: subject,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '\n$topic',
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
                    text: date,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      fontSize: 8,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '\n$expire',
                        style: const TextStyle(
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
  }
}
