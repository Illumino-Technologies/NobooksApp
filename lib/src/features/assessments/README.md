# Assessment feature

This feature covers everything concerning a student taking assessment in NoBooks.
<br>
Things to note:

- The term `Assessment` represents either `Test` or `Exam` or both `TestAndExam` semantically
- Assignment feature may come into this feature as a subfeature during refactoring (after feature completion)
- Please go through the following class code:
    - `Assessment` [link](https://github.com/Illumino-Technologies/NobooksApp/blob/feat-assessments/lib/src/features/assessments/domain/models/assessment/assessment.dart)
    - `AssessmentType` [link](https://github.com/Illumino-Technologies/NobooksApp/blob/feat-assessments/lib/src/features/assessments/domain/models/assessment_type/assessment_type.dart)
    - `AssessmentOperation` [link](https://github.com/Illumino-Technologies/NobooksApp/blob/feat-assessments/lib/src/features/assessments/domain/models/assessment/content/assessment_operation.dart)
    - `Paper` [link](https://github.com/Illumino-Technologies/NobooksApp/blob/feat-assessments/lib/src/features/assessments/domain/models/assessment/content/question_type.dart)

Requirements:

- [x] foundational model
- [x] foundational fake data
- [x] foundational structure
- [x] general Assessments data source 
- [ ]Assessment listings
    - [ ] Ui
        - [ ] Presentation
        - [ ] State management (should depend on assessment data layer)
    - [x] Data
        - [x] Repository (should store the list of assessments)
- [x] Assessment stage
    - [x] UI
    - [x] State management (should depend on assessment data layer)
       - [x] Multiple choice
          - [x] Presentation
          - [x] State management
       - [x] Theory
          - [x] Presentation
          - [x] State management
       - [x] Assessment review
          - [x] Presentation
          - [x] State management

User flow: Assessments listing

* Student opens test & exam tab
* Student views test and exams
* Student can switch between test and exams
* Student opens an exam

User flow: Assessment detail

* Student opens the exam or test
* User clicks ’start’ or ‘not ready’
* Student is able to edit questions within specific time frame
* student must be unable to exit the app while exam has started
* Student must not be able to leave the exam while it’s going on

