import 'package:flutter/material.dart';
import 'package:nobook/src/features/notes/model/note/note.dart';
import 'package:nobook/src/global/domain/fakes/subject/fake_subjects.dart';
import 'package:nobook/src/global/domain/models/subject/subject.dart';


abstract class FakeNotes {
  static final List<Note> allNotes = [
    Note(
      subject: FakeSubjects.biology,
      topic: 'Cell Theory',
      noteBody: 'Evolution',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now()
    ),
    Note(
      subject: FakeSubjects.biology,
      topic: 'Evolution',
      noteBody: 'Evolution',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Note(
      subject: FakeSubjects.biology,
      topic: 'Cell Theory',
      noteBody: 'Evolution',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Note(
      subject: FakeSubjects.biology,
      topic: 'Evolution',
      noteBody: 'Evolution',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Note(
      subject: FakeSubjects.chemistry,
      topic: 'Redox Reaction',
      noteBody: 'Redox Reaction',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Note(
      subject:
          FakeSubjects.civicEducation,
      topic: 'Civil Society',
      noteBody: 'Civic Education',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Note(
      subject:
          FakeSubjects.civicEducation,
      topic: 'Civil Society',
      noteBody: 'Civic Education',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Note(
      subject:
          FakeSubjects.civicEducation,
      topic: 'Civil Society',
      noteBody: 'Civic Education',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Note(
      subject:
          FakeSubjects.bookKeeping,
      topic: 'Trial Balance',
      noteBody: 'Booking Keeping',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Note(
      subject:
          FakeSubjects.bookKeeping,
      topic: 'Trial Balance',
      noteBody: 'Booking Keeping',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Note(
      subject:
          FakeSubjects.bookKeeping,
      topic: 'Trial Balance',
      noteBody: 'Booking Keeping',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Note(
      subject:
          FakeSubjects.bookKeeping,
      topic: 'Trial Balance',
      noteBody: 'Booking Keeping',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];
}

List<Note> biologynote = [
  Note(
    subject: const Subject(code: '', name: 'Biology', color: Colors.black),
    topic: 'Cell Theory',
    noteBody: 'Evolution',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Note(
    subject: const Subject(code: '', name: 'Biology', color: Colors.black),
    topic: 'Evolution',
    noteBody: 'Evolution',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Note(
    subject: const Subject(code: '', name: 'Biology', color: Colors.black),
    topic: 'Cell Theory',
    noteBody: 'Evolution',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Note(
    subject: const Subject(code: '', name: 'Biology', color: Colors.black),
    topic: 'Evolution',
    noteBody: 'Evolution',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];

List<Note> chemistrynote = [
  Note(
    subject: FakeSubjects.chemistry,
    topic: ' Redox Reaction',
    noteBody: 'Redox Reaction',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Note(
    subject: FakeSubjects.chemistry,
    topic: ' Redox Reaction',
    noteBody: 'Redox Reaction',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Note(
    subject: FakeSubjects.chemistry,
    topic: ' Redox Reaction',
    noteBody: 'Redox Reaction',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Note(
    subject: FakeSubjects.chemistry,
    topic: ' Redox Reaction',
    noteBody: 'Redox Reaction',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];

List<Note> civicnote = [
  Note(
    subject: FakeSubjects.chemistry,
    topic: ' Redox Reaction',
    noteBody: 'Redox Reaction',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Note(
    subject:
        FakeSubjects.civicEducation,
    topic: ' Civil Society',
    noteBody: 'Civic Education',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Note(
    subject:
        FakeSubjects.civicEducation,
    topic: ' Civil Society',
    noteBody: 'Civic Education',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Note(
    subject:
        FakeSubjects.civicEducation,
    topic: ' Civil Society',
    noteBody: 'Civic Education',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];
List<Note> bookeepingnote = [
  Note(
    subject:
        FakeSubjects.bookKeeping,
    topic: 'Trial Balance',
    noteBody: 'Booking Keeping',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Note(
    subject:
        FakeSubjects.bookKeeping,
    topic: 'Trial Balance',
    noteBody: 'Booking Keeping',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Note(
    subject:
        FakeSubjects.bookKeeping,
    topic: 'Trial Balance',
    noteBody: 'Booking Keeping',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Note(
    subject:
        FakeSubjects.bookKeeping,
    topic: 'Trial Balance',
    noteBody: 'Booking Keeping',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];
