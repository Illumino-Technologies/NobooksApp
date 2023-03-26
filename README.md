
# No'Book

```Ensure to read through```<br>
Link
to [design file ->](https://www.figma.com/file/qlhO5tA7U1wy8SWkePOb4t/No'Books?node-id=343%3A21602&t=hSkBxTqtgx4BfD5m-0)

## Feature Specifications

### Student

Features:

- Note-taking
  - Personal notes (create, update, read, delete)
  - Teacher’s notes (read, make annotations which saves to their account)
- Assignment (read, submit)
- Tests (read, submit)
- Exams (read, submit)
- Timetable
  - Personal timetable (create, update, read, delete) - currently unavailable in MVP
  - School timetable (read only)
- Records (read only)

## Teacher

Features:

- Note-taking
- Lesson notes (create, update, read, delete)
- Audio recording (create, delete)
- Assignment (create, read, update, delete)
- Tests (create, read, update, delete)
- Exams (create, read, update, delete)
- Marking guide (create, read, update, delete)
- Students scripts (read, append, publish)
- Records (create, read, update)

## School

Features:

- Notes (create, update, read, delete)
- Staff (create, read, update, delete)
- Student (create, read, update, delete)
- Assignment (read)
- Subject (create, read, update, delete)
- Class/Arm (create, read, update, delete)
- Tests (create, read, update, delete)
- Exams (create, read, update, delete)
- Grading system (create, read, update)
- Messaging - news & info (create, send)
- Timetable (create, read, update, delete)
- Records (read, update, delete)
- Student report (update)

# Development Guidelines

## Folder Structure

Project folder structure follows the ```Feature first``` approach.<br>
Layers are:

- Data<br>
  *Everything concerning external data transfer apis are contained here*
    - **Data sources**<br> *Fetches data from external sources through custom Apis for the ```Repository```*
    - **Repositories**<br> *Fetches data from ```Data source(s)``` and transforms it into more feature specific usable
      objects*
- Domain<br> *Contains all Feature specific business logic (```Managers```, ```State```, etc) and ```data models```*
    - business logic
    - models
- Ui<br> *Contains everything relating to User interface*
    - **View**
    - **State Manager**<br> *Everything concerning state management (Notifiers, Providers, States)*
    - **Model**<br> *Ui specific models* usually optional

### Note:

- All reusable utility code should be put in a ```utils``` folder relative to the current scope and if the scope is a
  global scope it should be put in the [global utils](lib/src/utils) folder
- Should there be a feature specific reusable component in a scope that is found to be needed in an outer scope, such
  reusable component
  should 'lifted' to an outer scope (like lifting state up in flutter 🙂).
- Corollary to the above, all global feature specific components are in the [global folder](lib/src/global)

# Code conventions

### Basic

- All file/named imports names MUST be in snake_case
- All class/mixin/interface/Enum/Extension names MUST be in PascalCase
- All function/variable names must be in camelCase
- Always add Types your code (including LHS of variable assignments 🙂)
- DO NOT ```//ignore for file: $lint_rule``` lint rules in your code
- ALWAYS use import barrels
- Use ErrorHandlers (create one if none) instead of ```try - catch``` block where the catch block contents is repeated
- Always use the [Failure](lib/src/utils/error_handling/failure.dart) class for holding error data
- Use abstract ```{FeatureName}UtilFunctions``` classes to hold feature specific reusable functions (top-level)
- Use mixins to encapsulate reusable methods/logic
- Encourage the use private ```_Private``` widgets first before public.
- _Corollary to the above_, Encourage the use of ```part directive``` to enable access to private classes/functions in
  other files (wisely 🙂)
- Encourage the use of ```super enum``` and the new ```record``` over custom classes

### UI guidelines
- The package flutter_screenutil is being used for responsiveness, and you should make use of it's methods appropriately in **ALL** your files
- To emphasize on the above, use the methods provided by screenutil literally **EVERYWHERE** you are to specify size in the UI
- The package gorouter_flow is being used for navigation, and you should make use of it **ALL** through your code when handling navigation
- Use the text styles from ```TextStyles``` class in [text_styles.dart](lib/src/global/ui/text/text_styles.dart) and the extension methods on TextStyles in [text_style_extension.dart](lib/src/utils/function/extensions/text_style_extension.dart)
- Use the ```AppColors``` in the [app_colors.dart](lib/src/global/ui/colors/app_colors.dart) for design colors.
- _Corollary to the above_, Update and **REPORT** any colors you see in the ui template that wasn't already in the file.


### Version Control/Git

- Always format your code ```dart format .``` before making a commit
- Commit messages should always clearly state the commit intent
- Commit regularly
- PRs should be sent to ```dev``` branch unless when publishing
- PR messages should always clearly state the PR intent
- Avoid checking out pushing commented code
- DO NOT send a PR with commented code in it

# Project Guide/Tips

- Go through the [utils](lib/src/utils) and [global](lib/src/global) folder before working on this codebase
- Understand how dart mixins, extensions, super enums, and the new recors, work to make so you can flow easily with the
  project. 
