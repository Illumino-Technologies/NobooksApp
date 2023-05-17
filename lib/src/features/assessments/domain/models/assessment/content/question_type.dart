part of '../assessment.dart';

/// This represents the possible types of questions that can be asked in an
/// assessment
enum PaperType {
  theory('Theory'),
  practical('Practical'),
  multipleChoice('Multiple Choice'),
  ;

  final String text;

  const PaperType(this.text);
}
