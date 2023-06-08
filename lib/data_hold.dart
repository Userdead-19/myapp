import 'dart:isolate';

import "package:http/http.dart" as http;
import 'dart:convert';

void main() {
  var data = timetableparse();
  print(data);
}

void apicall() async {
  List<dynamic> classcodeandroomcode = [];
  var url = Uri.parse("https://psg-scapes-backend.onrender.com/api/auth/login");
  var body = jsonEncode({"message": "hello world"});
  var response = await http.post(url, body: body);
  var details = json.decode(response.body);
  print(details);
  for (int i = 1; i <= 8; i++) {
    var data1 = details["classData"][0]["$i"]["classCode"];
    var data2 = details["classData"][0]["$i"]["roomCode"];
    classcodeandroomcode.add([data1, data2]);
  }

  print(classcodeandroomcode);
  print(response);
}

void attendenceapi() async {
  List<dynamic> classdetails = [];
  var url = Uri.parse(
      "https://psg-scapes-backend.onrender.com/api/attendance-single-student/22Z201");
  var response = await http.get(url);
  var data = json.decode(response.body);
  //print(data);

  for (int i = 0; i < 7; i++) {
    var coursecode = data[i]["courseCode"];
    var totalclass = data[i]["totalClasses"];
    var totalpresent = data[i]["totalPresent"];
    classdetails.add([coursecode, totalclass, totalpresent]);
  }
  print(classdetails);
}

void datetime() {
  DateTime now = DateTime.now();
  String day = getDayOfWeek(now.weekday);
  print("the day is ${day}");
}

String getDayOfWeek(int weekday) {
  switch (weekday) {
    case 1:
      return 'Monday';
    case 2:
      return 'Tuesday';
    case 3:
      return 'Wednesday';
    case 4:
      return 'Thursday';
    case 5:
      return 'Friday';
    case 6:
      return 'Saturday';
    case 7:
      return 'Sunday';
    default:
      return 'Unknown';
  }
}

//old route
// void login() async {
//   var uri = Uri.parse("https://psg-scapes-backend.onrender.com/api/auth/login");
//   var userdetails = jsonEncode({
//     "rollnumber": "22z255",
//     "tutorcode": "1143",
//     "password": "e8mMH5EqhKliqu8+5hUtZq38Q09mx3s6"
//   });
//   var response = await http.post(uri, body: userdetails);
//   var tokenandauth = json.decode(response.body) as Map;
//   var token = tokenandauth["token"];
//   var authtext = tokenandauth["authenticationText"];
//   print("${token}:${authtext}:${tokenandauth["info"]}");
// }

void verify() async {
  var uri =
      Uri.parse("https://psg-scapes-backend.onrender.com/api/auth/verify");
  Map maps = {"rollnumber": "22Z201", "password": "1234", "accesscode": ""};

  var response = await http.post(uri, body: maps);
  print(response.statusCode);
}

void timetable() async {
  List<dynamic> timetable = [];
  var uri = Uri.parse(
      "https://psg-scapes-backend.onrender.com/api/timetable/schedule/week/22Z2");
  var response = await http.get(uri);
  var data = jsonDecode(response.body);
  for (int i = 0; i < 8; i++) {
    print(data[0]["periods"][i]["course"]);
    timetable.add(data[0]["periods"][i]["course"]);
  }
  print(timetable);
}

class data1233 {
  final List entries;

  data1233(this.entries);
}

Future<List> timetableparse() async {
  List<String> timetable = [];
  var uri = Uri.parse(
      "https://psg-scapes-backend.onrender.com/api/timetable/schedule/week/22Z2");
  var response = await http.get(uri);
  var data = jsonDecode(response.body);
  print(data);
  for (int i = 0; i < 8; i++) {
    //print(data[0]["periods"][i]["course"]);
    timetable.add(data[0]["periods"][i]["course"]);
  }

  //print(timetable);
  return timetable;
}

List<data1233> d1 = [];

