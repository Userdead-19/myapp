import 'dart:convert';
import 'dart:isolate';
import 'package:http/http.dart' as http;

class Course {
  final String coursetitle;
  final String coursecode;

  Course(this.coursetitle, this.coursecode);
}

List<Course> courses = [];

void main() {
  timetableparse();
  Isolate.spawn<IsolateModel>(heavytask, IsolateModel(35000));
}

void timetableparse() async {
  var url = Uri.parse(
      "https://psg-scapes-backend.onrender.com/api/timetable/schedule/week/22Z2");
  var response = await http.get(url);
  var data = jsonDecode(response.body);
  for (int i = 0; i < 8; i++) {
    courses.add(new Course(
        data[0]["periods"][i]["course"], data[0]["periods"][i]["roomCode"]));
  }
}

void heavytask(IsolateModel model) {
  print(model.iteration);
}

class IsolateModel {
  IsolateModel(this.iteration);

  final int iteration;
}
