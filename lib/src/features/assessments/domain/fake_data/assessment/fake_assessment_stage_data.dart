part of 'fake_assessments_data.dart';

abstract final class _FakeAssessmentStageData {
  static final List<NoteDocument> mcqOptions = [
    NoteDocument.from([
      TextEditorController(text: 'Natural')
        ..initialize()
        ..setDeltasToTextWithMetadata(),
    ]),
    NoteDocument.from([
      TextEditorController(text: 'Artificial')
        ..initialize()
        ..setDeltasToTextWithMetadata(),
    ]),
    NoteDocument.from([
      TextEditorController(text: 'Sexual')
        ..initialize()
        ..setDeltasToTextWithMetadata(),
    ]),
    NoteDocument.from([
      TextEditorController(text: 'Phycogenic')
        ..initialize()
        ..setDeltasToTextWithMetadata(),
    ]),
  ];

  static MultipleChoiceAssessmentOperation getMCQuestions(int index) =>
      MultipleChoiceAssessmentOperation(
        id: (index + 1).toString(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        question: NoteDocument.from([
          TextEditorController(
            text: '_________ system of classification were based on natural '
                'affinities among the organisms.',
          )
            ..initialize()
            ..setDeltasToTextWithMetadata(),
        ]),
        answer: 1,
        marks: 1,
        options: mcqOptions,
      );

  static TheoryAssessmentOperation getTheoryQuestions(int index) =>
      TheoryAssessmentOperation(
        id: (index + 1).toString(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        question: NoteDocument.from([
          TextEditorController(
            text: '_________ system of classification were based on natural '
                'affinities among the organisms.',
          )
            ..initialize()
            ..setDeltasToTextWithMetadata(),
        ]),
        answer: [],
        marks: 1,
      );

  static List<MultipleChoiceAssessmentOperation> generateMCQs() {
    return List.generate(10, (index) => getMCQuestions(index));
  }

  static List<TheoryAssessmentOperation> generateTheoryOperations() {
    return List.generate(3, (index) => getTheoryQuestions(index));
  }

  static List<AssessmentOperation> generateAssessmentOperationsBy(
    PaperType paperType,
  ) {
    return switch (paperType) {
      PaperType.theory => generateTheoryOperations(),
      PaperType.multipleChoice => generateMCQs(),
      _ => throw UnimplementedError(),
    };
  }
}
