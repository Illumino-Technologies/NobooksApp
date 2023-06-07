import 'package:nobook/src/global/domain/fakes/fakes_barrel.dart';
import 'package:nobook/src/global/domain/models/models_barrel.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

abstract class FakeGradingSystem {
  static final List<ClassGradingSystem> fakeGradingSystem = [
    ...FakeClasses.classes.map<ClassGradingSystem>(
      (fakeClass) => ClassGradingSystem(
        gradeClassId: fakeClass.id,
        gradings: fakeGradings,
      ),
    ),
  ];

  static Map<DoubleRange, String> fakeGradings = {
    (val1: 0, val2: 39): 'F9',
    (val1: 45, val2: 49): 'E8',
    (val1: 40, val2: 44): 'D7',
    (val1: 50, val2: 59): 'C4',
    (val1: 60, val2: 69): 'B3',
    (val1: 70, val2: 79): 'B2',
    (val1: 80, val2: 100): 'A1',
  };
}
