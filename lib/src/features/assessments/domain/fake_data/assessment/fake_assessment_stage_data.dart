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
        question: NoteDocument.from([
          TextEditorController(
            text: '_________ system of classification were based on natural '
                'affinities among the organisms.',
          )
            ..initialize()
            ..setDeltasToTextWithMetadata(),
        ]),
        answer: null,
        marks: 1,
        options: mcqOptions,
      );

  static TheoryAssessmentOperation getTheoryQuestions(int index) =>
      TheoryAssessmentOperation(
        id: (index + 1).toString(),
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
        subOperations: subOperations,
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

  static final List<TheoryAssessmentOperationLeaf> subOperations = [
    TheoryAssessmentOperationLeaf(
      id: UniqueKey().toString(),
      question: theoryQuestion0,
      answer: [],
      marks: 8,
    ),
    ...List.generate(
      2,
      (index) => TheoryAssessmentOperationLeaf(
        id: UniqueKey().toString(),
        question: theoryQuestion1,
        answer: [],
        marks: 8,
      ),
    ),
  ];

  static final NoteDocument theoryQuestion0 = [
    TextEditorController(
      text:
          'A 30kg iron block is suspended using supports A and B as shown in the figure above. What is the tension in both ropes? [Take g=10m/s2]',
    )
      ..initialize()
      ..setDeltasToTextWithMetadata(),
  ];

  static final NoteDocument theoryQuestion1 = [
    TextEditorController(
      text: 'u=-2i+5j and v=i+j, find, to the nearest degree, the angle between'
          ' u and v.',
    )
      ..initialize()
      ..setDeltasToTextWithMetadata(),
  ];
}
