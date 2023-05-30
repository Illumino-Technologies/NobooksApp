part of 'fake_assessments_data.dart';

abstract class _FakeAssessmentPreviewData {
  static final TextMetadata metadata = TextMetadata(
    fontWeight: FontWeight.w500,
    fontSize: 24.sp,
    color: AppColors.neutral600,
  );
  static NoteDocument studentConduct = [
    TextEditorController(
      text: '''By attempting this exam, I acknowledge that
      
● I agree to be bound by the school ’s rules, codes of conduct, and other policies relating to examinations
● I have read and understand the examination conduct requirements for this exam
● I am aware of the school’s rules regarding misconduct during examinations.
● I am not in possession of, nor do I have access to, any unauthorised material during this examination
● In attempting this examination and submitting an answer, candidates are undertaking that the work they submit is a result of their own unaided efforts and that they have not discussed the questions or possible answers with other persons during the examination period. Candidates who are found to have participated in any form of cooperation or collusion or any activity which could amount to academic misconduct in the answering of this examination will have their marks withdrawn and disciplinary action will be initiated.
● Vivas or other invigilated tasks may be used to verify student achievement of learning outcomes to ensure they have completed the work on their own and to assess their knowledge of the answers they have submitted.''',
    )
      ..initialize(metadata: metadata)
      ..setDeltasToTextWithMetadata(metaData: metadata),
  ];
  static NoteDocument assessmentConduct = [
    TextEditorController(
      text:
          '''You can only attempt this exam once. Any additional attempts will only be used in the event where a serious technical issue has occurred and supporting evidence supporting this will be required.
You are not permitted to have on your desk or on your person any unauthorised material during this examination. This includes but not limited to:

● Mobile phones
● Smart watches and bands
● Electronic devices (including additional monitors, earphones, headphones etc)
● Headwear (hats, hoodies excluding religious headwear)
● Draft paper (unless permitted)
● Textbooks (unless specified)
● Notes (unless specified)

You are not permitted to leave your seat during the exam. Please ensure you use the toilet before the exam starts if necessary.
You will need to be in a quiet space for the duration of your exam with no interruptions.
You will need to check all your equipment to ensure that they are set up correctly.''',
    )
      ..initialize(metadata: metadata)
      ..setDeltasToTextWithMetadata(metaData: metadata),
  ];
  static NoteDocument assessmentInstructions = [
    TextEditorController(
      text: '''The duration of this exam is 2 hours and 15 minutes.
This is a closed book exam. The following materials and provisions are provided for you:

● List of formulas
● Scientific calculator

There are 15 questions in this exam and will be presented one at a time.
Each question is worth the different marks.
The examination is worth 60% of the marks available in this subject. The contribution each question makes to the total examination mark is indicated in points or as a percentage.
During this exam you will be permitted to review previous questions.
If you have technical difficulties with your exam, contact the IT Officer of your school or the officer in charge.''',
    )
      ..initialize(metadata: metadata)
      ..setDeltasToTextWithMetadata(metaData: metadata),
  ];
}
