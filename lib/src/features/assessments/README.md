# Assessment feature

This feature covers everything concerning a student taking assessment in NoBooks.
<br>
Things to note:

- The term `Assessment` represents either `Test` or `Exam` or both `TestAndExam` semantically
- Assignment feature may come into this feature as a subfeature during refactoring (after feature completion)

Requirements:

- [x] foundational model
- [x] foundational fake data
- [x] foundational structure
- [ ] Fake data
- [ ] Models
- [ ] Assessment listings
    - [ ] Ui
        - [ ] Presentation
        - [ ] State management (should depend on assessment data layer)
    - [ ] Data
        - [ ] Repository (should store the list of assessments)
        - [ ] Data source
- [ ] Assessment detail
    - [ ] UI
        - [ ] Presentation
        - [ ] State management (should depend on assessment data layer)
    - [ ] Data
        - [ ] Data source

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

