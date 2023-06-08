import 'package:flutter/material.dart';
import 'package:jar_vis/main.dart';
import 'functions.dart';

class entrypage extends StatefulWidget {
  const entrypage({super.key});

  @override
  State<entrypage> createState() => _entrypageState();
}

class _entrypageState extends State<entrypage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome \n here continue with login if your a user",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white70),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => ScreenA()),
                      (route) => false);
                },
                child: Text("LOGIN")),
            Divider(
              height: 10,
            ),
            Text(
              "NEW USER.....!\n HERE please sign up yourself",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.redAccent),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => signup()),
                      (route) => false);
                },
                child: Text("Sign UP"))
          ],
        ),
      ),
    );
  }
}

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  String name = "";
  String pass1 = "";
  String pass2 = "";
  String pin = "";
  final functions func = functions();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            height: 300,
            width: 300,
            child: Column(
              children: [
                Text(
                  "Please fill the details",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Enter your name"),
                  onChanged: (value) => name = value,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Enter your password"),
                  onChanged: (value) => pass1 = value,
                  obscureText: true,
                ),
                TextField(
                  decoration:
                      InputDecoration(labelText: "Re-Enter your password"),
                  onChanged: (value) => pass2 = value,
                  obscureText: true,
                ),
                TextField(
                  decoration:
                      InputDecoration(labelText: "Set a confirmation PIN"),
                  onChanged: (value) => pin = value,
                ),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                void checking(name, pass1, pass2, pin) {
                  if (pass1 == pass2) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: Text("Sign up Success"),
                              content: Text("Your sign up is sucessfull"),
                              actions: <Widget>[
                                ElevatedButton(
                                    onPressed: () {
                                      func.insertuser(name, pass1, pin);
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  entrypage()),
                                          (route) => false);
                                    },
                                    child: Text("ok"))
                              ]);
                        });
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text("the Passwords doesnt match"),
                          actions: <Widget>[
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                }

                checking(name, pass1, pass2, pin);
              },
              child: Text("Sign up"))
        ]),
      ),
    );
  }
}
