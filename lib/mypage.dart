import 'package:flutter/material.dart';
import 'package:jar_vis/functions.dart';
import 'data_hold.dart';
import 'dart:convert';
import 'package:http/http.dart';

class mypage extends StatefulWidget {
  const mypage({super.key});

  @override
  State<mypage> createState() => _mypageState();
}

class _mypageState extends State<mypage> {
  //TextEditingController _textEditingController = TextEditingController();
  final functions func = functions();

  String insert = "";
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: datas.length,
        itemBuilder: ((context, i) => Column(
              children: [
                Divider(height: 10),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        d1[i].entries,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}

class qoutes extends StatefulWidget {
  const qoutes({super.key});

  @override
  State<qoutes> createState() => _qoutesState();
}

class _qoutesState extends State<qoutes> {
  String c = "";
  final functions func = functions();
  String quotes1 = "";
  var i = 1;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          quotes1,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
        ),
        Divider(
          height: 2,
        ),
        ElevatedButton(
          onPressed: () async {
            void quotesfun() async {
              i++;
              var http = Client();
              final url = Uri.parse("https://type.fit/api/quotes");
              final call = await http.get(url);
              final response = json.decode(call.body)[i]["text"];
              print(response);
              setState(() {
                quotes1 = response;
              });
            }

            quotesfun();
          },
          child: Text("click me...!"),
        )
      ],
    ));
  }
}
