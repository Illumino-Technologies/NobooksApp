# Assignment feature

## Feature completion milestones

- [x] foundational model(s) and fake data
- [x] foundational structure
- [x] documentation
- [ ] Assignments (assignments listing)
    - [ ] ui
    - [ ] data layer
- [ ] Assignment (assignment details)
    - [ ] ui layer
    - [ ] domain layer
        - [ ] `cache manager`
    - [ ] data layer
        - [ ] caching api
        - [ ] `Data Transfer` api

## Introduction

This feature covers everything related to students and viewing, taking and submitting their
assignments.

## Architecture

The structure of this feature is as follows:

- `data` - the data layer
    - `data_sources` if any
    - `repositories` if any
- `domain`
    - `models`
    - `fakes`
    - `logic` feature wide business logic (if any)
- `ui`
    - `view`
        - `widgets` if any
    - `state_mgmt`
        - `providers`, `notitiers` etc, if any
        - `state_models` if any

Take a look at the `assignment_model.dart` and `fake_assignments.dart`
<br>

## Flow

* student clicks assignment tab and views the `AssignmentsPage`,
* student clicks on an assignment and views the `AssignmentScreen`, student can then proceed to
  answer the questions
    * questions are `read-only` `NoteDocument`/`note`s
    * answers are `NoteDocument`/`note`s
    * student answers will be cached by the `AssignmentCacheManager` offline, if edited.
    * students can submit the answers when done.

