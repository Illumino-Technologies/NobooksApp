import 'package:flutter/foundation.dart';
import 'package:nobook/src/global/domain/fakes/timetable/fake_timetable.dart';
import 'package:nobook/src/global/domain/models/school/school.dart';
import 'package:nobook/src/utils/utils_barrel.dart';

abstract class FakeSchoolData {
  static final School school = School(
    id: UniqueKey().toString(),
    name: 'CLEMMY HIGH SCHOOL',
    shortName: 'CHS',
    email: 'clemmyhigh@school.com',
    contactNumber: '+2341224234234',
    address: 'Some random Place, Some random place',
    logo: NetworkAssets.randomLogo,
    motto: 'Education for all',
    vision: 'To be the best school in the world',
    mission: 'To provide quality education to all students',
    timetables: FakeTimetable.timetables,
  );
}
