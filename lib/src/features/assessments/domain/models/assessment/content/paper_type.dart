part of '../assessment.dart';

/// This represents the possible types of questions that can be asked in an
/// assessment
enum PaperType {
  multipleChoice('Multiple Choice', 'MCQ'),
  theory('Theory', 'Theory'),
  practical('Practical', 'Practical'),
  ;

  final String text;
  final String shortName;

  const PaperType(this.text, this.shortName);
}
