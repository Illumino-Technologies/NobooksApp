import 'package:flutter/material.dart';

// import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobook/src/features/calculator/calcpage.dart';
import 'package:nobook/src/global/ui/ui_barrel.dart';

class TestandExamPage extends ConsumerStatefulWidget {
  const TestandExamPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AssignmentPageState();
}

class _AssignmentPageState extends ConsumerState<TestandExamPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 1110,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: AppColors.backgroundGrey,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 32,
                ),
                Center(
                  child: Container(
                    width: 800,
                    height: 80,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox.shrink(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CalcPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Maths',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    trailing: const Text(
                      '01:10pm . 18th April, 2022',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: AppColors.neutral200,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 32,
                    child: Row(
                      children: const [
                        Text(
                          'Topic:',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: SizedBox(
                            width: 800,
                            child: SizedBox.shrink(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: Text(
                      'Write something here...',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColors.neutral200,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: 1110,
                    height: 1088,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: Colors.black),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox.shrink(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
