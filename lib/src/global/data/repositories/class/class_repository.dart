import 'package:nobook/src/global/data/data_barrel.dart';
import 'package:nobook/src/global/domain/domain_barrel.dart';

part 'class_repo_interface.dart';

class ClassRepository implements ClassRepoInterface {
  final ClassSourceInterface _source;

  ClassRepository._({
    ClassSourceInterface? source,
  }) : _source = source ?? ClassSource();

  static ClassRepository _instance = ClassRepository._();

  factory ClassRepository() => _instance;

  factory ClassRepository.new_({
    ClassSourceInterface? source,
  }) =>
      ClassRepository._(source: source);

  factory ClassRepository.reset({
    ClassSourceInterface? source,
  }) {
    _instance = ClassRepository._(source: source);
    return _instance;
  }

  Class? _class;

  final Set<Class> _classes = {};

  @override
  List<Class> get classes => List.from(_classes);

  @override
  Class? get currentClass => _class;

  @override
  Future<Class> fetchCurrentClass(String studentId) async {
    final Class class_ = await _source.fetchStudentClass(studentId);
    _class = _class;
    _classes.add(class_);
    return _class!;
  }

  @override
  Future<List<Class>> fetchStudentClasses(
    String studentId, {
    bool fetchAFresh = false,
  }) async {
    if (fetchAFresh) _classes.clear();
    _classes.addAll(await _source.fetchStudentClasses(studentId));
    return _classes.toList();
  }

  @override
  Future<List<Class>> fetchClassesIfEmpty(String studentId) async {
    if (_classes.isEmpty) return await fetchStudentClasses(studentId);
    return _classes.toList();
  }
}
