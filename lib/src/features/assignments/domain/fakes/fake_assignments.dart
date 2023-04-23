import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nobook/src/features/assignments/domain/models/assignment_model.dart';
import 'package:nobook/src/features/notes/subfeatures/document_editing/document_editing_barrel.dart';
import 'package:nobook/src/global/domain/domain_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

abstract class FakeAssignments {
  static final TextMetadata questionMetadata = TextMetadata(
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
  );

  static final NoteDocument fakeQuestion1 = [
    TextEditorController(
      text: 'What is the capital of Nigeria?',
      deltas: [],
    )..initialize(metadata: questionMetadata),
  ];

  static final NoteDocument fakeQuestion2 = [
    TextEditorController(
      text: 'How many states are in Nigeria?',
      deltas: [],
    )..initialize(metadata: questionMetadata),
  ];

  static final NoteDocument fakeQuestion3 = [
    TextEditorController(
      text: 'How many geopolitical zones are in Nigeria?',
      deltas: [],
    )..initialize(metadata: questionMetadata),
  ];

  static final NoteDocument fakeQuestion4 = [
    TextEditorController(
      text: 'What is your name?',
      deltas: [],
    )..initialize(metadata: questionMetadata),
  ];

  static final List<NoteDocument> questions = [
    fakeQuestion1,
    fakeQuestion2,
    fakeQuestion3,
    fakeQuestion4,
  ];

  static final Assignment geographyAssignment = Assignment(
    id: UniqueKey().toString(),
    subject: FakeSubjects.geography,
    topic: 'Current Affairs',
    teacher: FakeUsers.mrOgunyemi,
    questions: questions,
    answers: null,
    createdDate: DateTime.now().copySubtract(day: 1),
    submissionDate: DateTime.now().copyAdd(day: 5),
  );

  static final Assignment biologyAssignment = Assignment(
    id: UniqueKey().toString(),
    subject: FakeSubjects.biology,
    topic: 'Current Affairs',
    teacher: FakeUsers.mrOgunyemi,
    questions: questions,
    answers: null,
    createdDate: DateTime.now().copySubtract(day: 1),
    submissionDate: DateTime.now().copyAdd(day: 5),
  );

  static final Assignment chemistryAssignment = Assignment(
    id: UniqueKey().toString(),
    subject: FakeSubjects.chemistry,
    topic: 'Current Affairs',
    teacher: FakeUsers.mrOgunyemi,
    questions: questions,
    answers: null,
    createdDate: DateTime.now().copySubtract(day: 1),
    submissionDate: DateTime.now().copyAdd(day: 5),
  );

  static final Assignment physicsAssignment = Assignment(
    id: UniqueKey().toString(),
    subject: FakeSubjects.physics,
    topic: 'Current Affairs',
    teacher: FakeUsers.mrOgunyemi,
    questions: questions,
    answers: null,
    createdDate: DateTime.now().copySubtract(day: 1),
    submissionDate: DateTime.now().copyAdd(day: 5),
  );

  static final Assignment mathematicsAssignment = Assignment(
    id: UniqueKey().toString(),
    subject: FakeSubjects.maths,
    topic: 'Current Affairs',
    teacher: FakeUsers.mrOgunyemi,
    questions: questions,
    answers: null,
    createdDate: DateTime.now().copySubtract(day: 1),
    submissionDate: DateTime.now().copyAdd(day: 5),
  );

  static final Assignment englishAssignment = Assignment(
    id: UniqueKey().toString(),
    subject: FakeSubjects.englishLanguage,
    topic: 'Current Affairs',
    teacher: FakeUsers.mrOgunyemi,
    questions: questions,
    answers: null,
    createdDate: DateTime.now().copySubtract(day: 1),
    submissionDate: DateTime.now().copyAdd(day: 5),
  );

  static final List<Assignment> assignments = [
    geographyAssignment,
    biologyAssignment,
    chemistryAssignment,
    physicsAssignment,
    mathematicsAssignment,
    englishAssignment,
  ];
}
