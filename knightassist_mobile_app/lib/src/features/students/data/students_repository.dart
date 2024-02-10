import 'dart:convert';

import 'package:knightassist_mobile_app/src/exceptions/app_exception.dart';
import 'package:knightassist_mobile_app/src/features/students/domain/student_user.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'students_repository.g.dart';

class StudentsRepository {
  Future<List<StudentUser>> fetchStudentsInOrg(String orgID) async {
    Map<String, dynamic> params = {"organizationID": orgID};
    var uri = Uri.https('knightassist-43ab3aeaada9.herokuapp.com',
        '/api/loadAllStudentsInORG', params);
    var response = await http.get(uri);
    final List<dynamic> dataList = jsonDecode(response.body);
    //Map<String, dynamic> map = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        //String studentsJson = map['favorites'];
        // List<StudentUser> students = (json.decode(studentsJson) as List)
        //.map((i) => StudentUser.fromMap(i))
        //.toList();

        List<StudentUser> list = [];
        for (dynamic d in dataList) {
          Map<String, String?> params = {"userID": d['_id']};
          var uri = Uri.https('knightassist-43ab3aeaada9.herokuapp.com',
              '/api/userSearch', params);
          var response = await http.get(uri);
          final dynamic studentData = jsonDecode(response.body);

          List<String> favoritedOrganizations = [];
          List<String> eventsRSVP = [];
          List<String> eventsHistory = [];
          List<String> userStudentSemesters = [];
          List<String> tags = [];

          for (dynamic s in studentData['favoritedOrganizations']) {
            favoritedOrganizations.add(s);
          }
          for (dynamic s in studentData['eventsRSVP']) {
            eventsRSVP.add(s);
          }
          for (dynamic s in studentData['eventsHistory']) {
            eventsHistory.add(s);
          }
          for (dynamic s in studentData['userStudentSemesters']) {
            userStudentSemesters.add(s);
          }
          if (studentData['categoryTags'] != null) {
            for (dynamic s in studentData['categoryTags']) {
              tags.add(s);
            }
          }

          StudentUser s = StudentUser(
              id: studentData['_id'] ?? '',
              email: studentData['email'] ?? '',
              firstName: studentData['firstName'] ?? '',
              lastName: studentData['lastName'] ?? '',
              profilePicture: studentData['profilePicPath'] ?? '',
              favoritedOrganizations: favoritedOrganizations,
              eventsRsvp: eventsRSVP,
              eventsHistory: eventsHistory,
              totalVolunteerHours: studentData['totalVolunteerHours'],
              semesterVolunteerHourGoal:
                  studentData['semesterVolunteerHourGoal'],
              userStudentSemesters: userStudentSemesters,
              categoryTags: tags,
              recoveryToken: studentData['recoveryToken'] ?? '',
              confirmToken: studentData['confirmToken'] ?? '',
              emailToken: studentData['EmailToken'] ?? '',
              emailValidated: studentData['emailValidated'] ?? false,
              studentId: studentData['studentID'] ?? '',
              password: studentData['password'] ?? '',
              createdAt:
                  DateTime.parse(studentData['createdAt']) ?? DateTime.now(),
              updatedAt:
                  DateTime.parse(studentData['updatedAt']) ?? DateTime.now(),
              profilePicPath: studentData['profilePicPath'] ?? '',
              role: studentData['role'] ?? '',
              firstTimeLogin: studentData['firstTimeLogin'] ?? false);

          list.add(s);
        }
        return list;
      default:
        throw Exception();
    }
  }

  Future<List<StudentUser>> fetchEventAttendees(String eventID) async {
    Map<String, dynamic>? params = {"eventID": eventID};
    var uri = Uri.https('knightassist-43ab3aeaada9.herokuapp.com',
        '/api/loadAllEventAttendees', params);
    var response = await http.get(uri);
    var body = jsonDecode(response.body);
    final List<dynamic> dataList = jsonDecode(response.body);
    //print("Responsebody:");
    //print(body);
    switch (response.statusCode) {
      case 200:
        List<StudentUser> list = [];
        //for (String json in List<String>.from(body)) {
        //list.add(StudentUser.fromMap(jsonDecode(json)));
        //}
        for (dynamic d in dataList) {
          Map<String, String?> params = {"userID": d['_id']};
          var uri = Uri.https('knightassist-43ab3aeaada9.herokuapp.com',
              '/api/userSearch', params);
          var response = await http.get(uri);
          //print("Response body under searchUser");
          //print(jsonDecode(response.body));

          final dynamic studentData = jsonDecode(response.body);
          //print(studentData['firstName']);

          List<String> favoritedOrganizations = [];
          List<String> eventsRSVP = [];
          List<String> eventsHistory = [];
          List<String> userStudentSemesters = [];
          List<String> tags = [];

          for (dynamic s in studentData['favoritedOrganizations']) {
            favoritedOrganizations.add(s);
          }
          for (dynamic s in studentData['eventsRSVP']) {
            eventsRSVP.add(s);
          }
          for (dynamic s in studentData['eventsHistory']) {
            eventsHistory.add(s);
          }
          for (dynamic s in studentData['userStudentSemesters']) {
            userStudentSemesters.add(s);
          }
          if (studentData['categoryTags'] != null) {
            for (dynamic s in studentData['categoryTags']) {
              tags.add(s);
            }
          }

          StudentUser s = StudentUser(
              id: studentData['_id'] ?? '',
              email: studentData['email'] ?? '',
              firstName: studentData['firstName'] ?? '',
              lastName: studentData['lastName'] ?? '',
              profilePicture: studentData['profilePicPath'] ?? '',
              favoritedOrganizations: favoritedOrganizations,
              eventsRsvp: eventsRSVP,
              eventsHistory: eventsHistory,
              totalVolunteerHours: studentData['totalVolunteerHours'],
              semesterVolunteerHourGoal:
                  studentData['semesterVolunteerHourGoal'],
              userStudentSemesters: userStudentSemesters,
              categoryTags: tags,
              recoveryToken: studentData['recoveryToken'] ?? '',
              confirmToken: studentData['confirmToken'] ?? '',
              emailToken: studentData['EmailToken'] ?? '',
              emailValidated: studentData['emailValidated'] ?? false,
              studentId: studentData['studentID'] ?? '',
              password: studentData['password'] ?? '',
              createdAt:
                  DateTime.parse(studentData['createdAt']) ?? DateTime.now(),
              updatedAt:
                  DateTime.parse(studentData['updatedAt']) ?? DateTime.now(),
              profilePicPath: studentData['profilePicPath'] ?? '',
              role: studentData['role'] ?? '',
              firstTimeLogin: studentData['firstTimeLogin'] ?? false);

          list.add(s);
        }
        return list;
      case 404:
        throw EventNotFoundException();
      default:
        String err = body["error"];
        throw Exception(err);
    }
  }
}

@riverpod
StudentsRepository studentsRepository(StudentsRepositoryRef ref) {
  return StudentsRepository();
}
