import "package:http/http.dart" as http;
import 'dart:convert';
import 'data_hold.dart';

class functions {
  //variables
  bool condition = false;
  var ifisit;
  var test = "";
  String v = "";
  String mailid = '';
  String mess = '';
  Map user_pass = {
    "Abinav": "abinav@123",
    "Sumathi": "sumathi@123",
    "user-dead": "user@gmail.com"
  };
  String quotes = "";

  //drawer mail and username setting
  // void valuessetting(username) {
  //   v = username;
  //   Map mails = {
  //     "Abinav": "abinav10102@gmail.com",
  //     "Sumathi": "sumathi2004@gmail.com",
  //     "user-dead": "user@gmail.com"
  //   };
  //   mailid = mails[v];
  // }

  //local user and password check
  bool hello1(user, pass1) {
    var users = user_pass.keys;
    if (users.contains(user)) {
      if (user_pass[user] == pass1) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  //pythonanywhere api call for username and password check
  Future<bool> apicall1(String user, String pass) async {
    var client = http.Client();
    var param = {"message": user, "pass": pass};
    var url = Uri.parse("http://abinav19.pythonanywhere.com/ptch")
        .replace(queryParameters: param);
    var response = await client.get(url);
    var callresponse = json.decode(response.body) as List;
    print(callresponse);
    if (callresponse.isNotEmpty) {
      print(callresponse);
      return true;
    } else {
      return false;
    }
  }

  // new user
  void insertuser(name, pass, pin) async {
    //var param = {"message": name, "pass": pass, "pin": pin};
    // final Url = Uri.parse("http://abinav19.pythonanywhere.com/insert")
    //     .replace(queryParameters: param);
    // final response = await http.get(Url);
    // print("done");
  }

  //body qoutes

  //list item reader
  void listitems() {
    for (int i = 0; i < d1.length; i++) {
      print(d1[i].entries);
    }
  }

  void todolistadd(Elements) async {
    var client = http.Client();
    var Element = {"addtodo": Elements};
    var url = Uri.parse("http://abinav19.pythonanywhere.com/todo/add")
        .replace(queryParameters: Element);
    var response = await client.get(url);
    var ree = json.decode(response.body);
    print(ree);
  }

  void mongodbcall() async {
    var client = http.Client();
    var url = Uri.parse("https://psg-scapes-backend.onrender.com/api/students");
    var response = await client.get(url);
    var body = json.decode(response.body) as List;
    if (body.isEmpty) {
      print("no user found");
    } else {
      print("user found");
    }
  }
}
