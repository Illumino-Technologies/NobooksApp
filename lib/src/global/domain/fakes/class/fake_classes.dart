import 'package:nobook/src/global/domain/fakes/fakes_barrel.dart';
import 'package:nobook/src/global/domain/models/models_barrel.dart';

abstract class FakeClasses {
  static const Class ss2 = Class(
    id: 'uniqueString-x',
    name: 'SS 3',
    subjects: FakeSubjects.subjects,
  );

  static const Class ss3 = Class(
    id: 'uniqueString-x-ss3',
    name: 'SS 3',
    subjects: FakeSubjects.subjects,
  );
}
