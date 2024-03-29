# Assignment feature

## Feature completion milestones

- [x] foundational model(s) and fake data
- [x] foundational structure
- [x] documentation
- [x] Assignments (assignments listing)
    - [x] ui
    - [x] data layer
- [x] Assignment (assignment details)
    - [x] ui layer
    - [x] domain layer
        - [x] `cache manager`
    - [x] data layer
        - [x] caching api
        - [x] `Data Transfer` api
- [ ] integrate with backend

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

