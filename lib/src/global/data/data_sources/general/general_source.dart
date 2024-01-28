import 'package:dio/dio.dart';
import 'package:nobook/src/utils/constants/constants_barrel.dart';

abstract class GeneralSource {
  Future<void> uploadMockData();
}

class GeneralSourceImpl implements GeneralSource {
  final Dio _dio;

  GeneralSourceImpl(this._dio);

  @override
  Future<void> uploadMockData() async {
    const String requestPath = '${ApiPaths.baseUrl}/addmockdata';

    await _dio.post(
      requestPath,
      data: mockData,
      options: Options(contentType: Headers.jsonContentType),
    );
  }
}

const String mockData = '''{
  "classField": {
    "name": "Class A",
    "classCaptain": 101,
    "assistantClassCaptain": 102,
    "classteacher_id": 201,
    "school_id": 301
  },
  "subjects": {
    "code": "ENG101",
    "name": "English",
    "color": "Blue",
    "classes_id": 1
  },
  "subjectTeacher": {
    "subject_id": 1,
    "teacher_id": 201
  },
  "school": {
    "name": "XYZ School",
    "shortName": "XYZS",
    "email": "info@xyzschool.com",
    "contactNumber": "+123456789",
    "address": "123 Main Street, Cityville",
    "logo": "school_logo.jpg",
    "motto": "Educating for a Bright Future",
    "vision": "To be a leading educational institution",
    "mission": "Empowering students for lifelong success"
  },
  "timetable": {
    "classes": 1,
    "school_id": 301
  },
  "timeTablePeriods": {
    "periodname": "First Period",
    "duration": 60,
    "day": "Monday",
    "timetable_id": 1,
    "subject_id": 1
  },
  "timeOfDay": {
    "hour": 9,
    "minute": 0,
    "timetableperiod_id": 1
  },
  "teacher": {
    "email": "john.doe@xyzschool.com",
    "firstname": "John",
    "lastname": "Doe",
    "uid": "39999708-d947-452d-93c9-2bf018822b9d",
    "profilePhoto": "john_doe_photo.jpg",
    "gender": 1,
    "dob": "1990-05-15",
    "phoneNumber": "+987654321",
    "password": "hashed_password",
    "school_id": 301
  },
  "student": {
    "email": "jane.smith@xyzschool.com",
    "student_id": "STU001",
    "school_id": 301,
    "classes_id": 1,
    "formerClassId": [],
    "firstname": "Jane",
    "lastname": "Smith",
    "uid": "4e913793-6f31-4312-85e4-ed5708575c4c",
    "profilePhoto": "jane_smith_photo.jpg",
    "gender": 0,
    "dob": "1995-08-20",
    "phoneNumber": "+876543210",
    "password": "hashed_password"
  },
  "noteDocument": {
    "topic": "Introduction to Shakespeare",
    "noteBody": "William Shakespeare was an English playwright...",
    "note_id": 1
  },
  "note": {
    "subject_id": 1,
    "student_id": 1,
    "class_id": 1,
    "updatedAt": "2024-01-27",
    "created_at": "2024-01-25"
  },
  "subOperations": {
    "question": "What is the capital of France?",
    "answer": "Paris",
    "marks": 10,
    "assesment_operation_id": 1
  },
  "testAssesmentInstruction": {
    "test_assesment_id": 1,
    "topic": "Mathematics Test",
    "noteBody": "Please solve the following problems within the given time."
  },
  "testAssesmentConduct": {
    "test_assesment_id": 1,
    "topic": "Mathematics Test",
    "noteBody": "Follow the instructions carefully and maintain silence during the test."
  },
  "testStudentDeclaration": {
    "test_assesment_id": 1,
    "topic": "Mathematics Test",
    "noteBody": "I declare that I will not engage in any form of cheating during the test."
  },
  "testAssessmentOperation": {
    "question": "Solve the quadratic equation: x^2 + 2x + 1 = 0",
    "answer": "x = -1",
    "marks": 15,
    "test_assesment_id": 1
  },
  "testAssessment": {
    "duration": 90,
    "start_time": "2024-02-01 09:00:00",
    "end_time": "2024-02-01 10:30:00",
    "session": "Morning",
    "assesment_number": 1,
    "submitted": true,
    "subject": 1,
    "classes": 1,
    "paperType": 1,
    "assessment_type": 1,
    "term": 1,
    "student_id": 1
  },
  "examAssesmentInstruction": {
    "exam_assesment_id": 1,
    "topic": "Final Exam",
    "noteBody": "Prepare well for the upcoming final exam."
  },
  "examAssesmentConduct": {
    "exam_assesment_id": 1,
    "topic": "Final Exam",
    "noteBody": "Read the instructions on the question paper carefully."
  },
  "examStudentDeclaration": {
    "exam_assesment_id": 1,
    "topic": "Final Exam",
    "noteBody": "I understand the rules and regulations of the final exam."
  },
  "examAssessmentOperation": {
    "question": "What is the capital of Spain?",
    "answer": "Madrid",
    "marks": 20,
    "exam_assesment_id": 1
  },
  "examAssessment": {
    "duration": 120,
    "start_time": "2024-05-15 10:00:00",
    "end_time": "2024-05-15 12:00:00",
    "session": "Morning",
    "assesment_number": 2,
    "submitted": true,
    "subject": 1,
    "classes": 1,
    "paperType": 2,
    "assessment_type": 2,
    "term": 2,
    "student_id": 1
  },
  "assignmentOperations": {
    "questions": "Write an essay on 'The Importance of Education'",
    "created_at": "2024-01-20",
    "updated_at": "2024-01-25",
    "assignment_id": 1
  },
  "assignments": {
    "topic": "Essay Assignment",
    "created_at": "2024-01-20",
    "submission_date": "2024-02-10",
    "subject_id": 1,
    "teacher_id": 201,
    "classes": 1
  },
  "grade": {
    "term": 1,
    "myclass": "Class A",
    "subject_id": 1,
    "student_id": 1,
    "exams_score": 85,
    "exam_percent": 70,
    "ca_scores": [
      90,
      88,
      92
    ]
  }
}''';
