import 'package:flutter/material.dart';
import 'package:jar_vis/entrypage.dart';
import "functions.dart";
import 'package:url_launcher/url_launcher.dart';
import 'mypage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String title = 'JARVIS';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      initialRoute: '/entry_',
      routes: {
        '/entry_': (context) => entrypage(),
        '/signup': (context) => signup(),
        '/ScreenA': (context) => ScreenA(),
        '/ScreenB': (context) => ScreenB(),
        '/mail': (context) => mail(),
      },
    );
  }
}

class ScreenA extends StatefulWidget {
  @override
  State<ScreenA> createState() => _ScreenAState();
}

class _ScreenAState extends State<ScreenA> {
  String _entry = "";
  final functions func = functions();
  String _pass1 = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Login")),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Divider(
              height: 20,
            ),
            Container(
                height: 280,
                width: 250,
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          hintText: "enter your user name",
                          labelText: "user name"),
                      keyboardType: TextInputType.name,
                      maxLength: 10,
                      autocorrect: false,
                      autofillHints: [],
                      autofocus: true,
                      onChanged: (value) {
                        _entry = value;
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "enter your password",
                        labelText: "password",
                      ),
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      autocorrect: false,
                      autofillHints: [],
                      onChanged: (value) {
                        _pass1 = value;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        void bool_Check(_entry, _pass1) async {
                          bool condition = await func.apicall1(_entry, _pass1);
                          if (condition) {
                            //func.valuessetting(_entry);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ScreenB()),
                              (Route<dynamic> route) => false,
                            );
                          } else {
                            showErrorDialog(context,
                                "Please Check the username and password");
                          }
                        }

                        bool_Check(_entry, _pass1);
                      },
                      child: Text('LOGIN'),
                    ),
                  ],
                ))
          ]),
        ));
  }
}

class ScreenB extends StatefulWidget {
  @override
  State<ScreenB> createState() => _ScreenBState();
}

class _ScreenBState extends State<ScreenB> with SingleTickerProviderStateMixin {
  String c = "";
  String insert = "";
  final functions func = functions();
  void state() {
    setState(() {
      c = func.quotes;
    });
  }

  late TabController _tabController;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JARVIS'),
        actions: [
          IconButton(
              onPressed: () {
                void addone() {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Enter the element to add in todo list"),
                          content: TextField(
                            controller: _textEditingController,
                            decoration: InputDecoration(hintText: "insert it "),
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(_textEditingController.text);
                                  insert = _textEditingController.text;
                                  _textEditingController.clear();
                                  func.todolistadd(insert);
                                  //func.addtolist();
                                },
                                child: Text("ok"))
                          ],
                        );
                      });
                }

                addone();
              },
              icon: Icon(Icons.add)),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == "logout") {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => entrypage()),
                    (Route<dynamic> route) => false);
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: "logout",
                  child: Text("Logout"),
                )
              ];
            },
          ),
        ],
        bottom: TabBar(controller: _tabController, tabs: <Widget>[
          Tab(
            icon: Icon(Icons.chat),
          ),
          Tab(text: "qoutes")
        ]),
      ),
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[mypage(), qoutes()],
      ),
      drawer: Drawer(
        child: Column(children: [
          UserAccountsDrawerHeader(
              accountName: Text(func.v),
              accountEmail: Text(func.mailid),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text("AP"),
              )),
          Divider(
            height: 10,
          ),
          ListTile(
            title: Text(
              "IV DOCUMENTS",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => mail(),
                  ));
            },
          ),
          Divider(
            height: 10,
          ),
          ListTile(
            title: Text(""),
          )
        ]),
      ),
    );
  }
}

void showErrorDialog(BuildContext context, String errorMessage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text(errorMessage),
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

class mail extends StatefulWidget {
  const mail({super.key});

  @override
  State<mail> createState() => _mailState();
}

class _mailState extends State<mail> {
  final functions func = functions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exam details"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
            child: Text("Exam timetable"),
            onPressed: () {
              launchUrl(Uri.parse(
                  'https://drive.google.com/file/d/1IcCtOJhaLlzHjNorr5D2kBMdTMaPtRtq/view?usp=share_link'));
            },
          ),
          ElevatedButton(
              onPressed: () {
                func.mongodbcall();
              },
              child: Text("test"))
        ]),
      ),
    );
  }
}



//https://p4tamilans.blogspot.com/2021/03/jackie-chan-adventures-season-1-in-tamil.html