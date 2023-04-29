// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:nobook/src/features/assignments/domain/models/assignment_model.dart';
// import 'package:nobook/src/features/assignments/subfeatures/assignment/assignment_barrel.dart';

// class AssignmentScreen extends ConsumerStatefulWidget {
//   final Assignment assignment;

//   const AssignmentScreen({
//     Key? key,
//     required this.assignment,
//   }) : super(key: key);

//   @override
//   ConsumerState createState() => _AssignmentScreenState();
// }

// class _AssignmentScreenState extends ConsumerState<AssignmentScreen> {
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     ref.read(AssignmentStateNotifier.provider.notifier).initializeAssignment(
//           widget.assignment,
//         );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
