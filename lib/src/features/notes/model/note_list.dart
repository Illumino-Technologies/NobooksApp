import 'package:flutter/material.dart';
import 'package:nobook/src/features/notes/model/note/note.dart';
import 'package:nobook/src/global/domain/fakes/subject/fake_subjects.dart';
import 'package:nobook/src/global/domain/models/subject/subject.dart';

abstract class FakeNotes {
  static final List<Note> allNotes = [
    Note(
      id: 'uniqueString-x',
      subject: FakeSubjects.biology,
      topic: 'Cell Theory',
      noteBody: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Note(
      id: 'hello',
      subject: FakeSubjects.biology,
      topic: 'Evolution',
      noteBody: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Note(
      id: 'hello',
      subject: FakeSubjects.biology,
      topic: 'Cell Theory',
      noteBody: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Note(
      id: 'hello',
      subject: FakeSubjects.biology,
      topic: 'Evolution',
      noteBody: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Note(
      id: 'hello',
      subject: FakeSubjects.chemistry,
      topic: 'Redox Reaction',
      noteBody: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Note(
      id: 'hello',
      subject: FakeSubjects.civicEducation,
      topic: 'Civil Society',
      noteBody: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Note(
      id: 'hello',
      subject: FakeSubjects.civicEducation,
      topic: 'Civil Society',
      noteBody: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Note(
      id: 'hello',
      subject: FakeSubjects.civicEducation,
      topic: 'Civil Society',
      noteBody: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Note(
      id: 'hello',
      subject: FakeSubjects.bookKeeping,
      topic: 'Trial Balance',
      noteBody: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Note(
      id: 'hello',
      subject: FakeSubjects.bookKeeping,
      topic: 'Trial Balance',
      noteBody: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Note(
      id: 'hello',
      subject: FakeSubjects.bookKeeping,
      topic: 'Trial Balance',
      noteBody: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Note(
      id: 'hello',
      subject: FakeSubjects.bookKeeping,
      topic: 'Trial Balance',
      noteBody: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];
}

List<Note> biologynote = [
  Note(
    id: 'hello',
    subject: const Subject(code: '', name: 'Biology', color: Colors.black),
    topic: 'Cell Theory',
    noteBody: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Note(
    id: 'hello',
    subject: const Subject(code: '', name: 'Biology', color: Colors.black),
    topic: 'Evolution',
    noteBody: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Note(
    id: 'hello',
    subject: const Subject(code: '', name: 'Biology', color: Colors.black),
    topic: 'Cell Theory',
    noteBody: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Note(
    id: 'hello',
    subject: const Subject(code: '', name: 'Biology', color: Colors.black),
    topic: 'Evolution',
    noteBody: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];

List<Note> chemistrynote = [
  Note(
    id: 'hello',
    subject: FakeSubjects.chemistry,
    topic: ' Redox Reaction',
    noteBody: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Note(
    id: 'hello',
    subject: FakeSubjects.chemistry,
    topic: ' Redox Reaction',
    noteBody: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Note(
    id: 'hello',
    subject: FakeSubjects.chemistry,
    topic: ' Redox Reaction',
    noteBody: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Note(
    id: 'hello',
    subject: FakeSubjects.chemistry,
    topic: ' Redox Reaction',
    noteBody: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];

List<Note> civicnote = [
  Note(
    id: 'hello',
    subject: FakeSubjects.chemistry,
    topic: ' Redox Reaction',
    noteBody: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Note(
    id: 'hello',
    subject: FakeSubjects.civicEducation,
    topic: ' Civil Society',
    noteBody: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Note(
    id: 'hello',
    subject: FakeSubjects.civicEducation,
    topic: ' Civil Society',
    noteBody: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Note(
    id: 'hello',
    subject: FakeSubjects.civicEducation,
    topic: ' Civil Society',
    noteBody: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];
List<Note> bookeepingnote = [
  Note(
    id: 'hello',
    subject: FakeSubjects.bookKeeping,
    topic: 'Trial Balance',
    noteBody: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Note(
    id: 'hello',
    subject: FakeSubjects.bookKeeping,
    topic: 'Trial Balance',
    noteBody: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Note(
    id: 'hello',
    subject: FakeSubjects.bookKeeping,
    topic: 'Trial Balance',
    noteBody: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Note(
    id: 'hello',
    subject: FakeSubjects.bookKeeping,
    topic: 'Trial Balance',
    noteBody: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];
