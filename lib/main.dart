import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var cmd;
  var webdata;

  executeCommand(cmd) async {
    var url = "http://192.168.29.155/cgi-bin/web.py?x=${cmd}";
    var r = await http.get(url);

    setState(() {
      webdata = r.body;
    });

    //print("Clicked");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Linux CLI"),
        backgroundColor: Colors.blueAccent.shade200,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.8,
          color: Colors.grey.shade300,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    hintText: "Enter your command",
                  ),
                  style: TextStyle(
                    height: 2,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (value) {
                    cmd = value;
                  },
                  textAlign: TextAlign.center,
                ),
              ),
              FlatButton(
                onPressed: () {
                  executeCommand(cmd);
                },
                child: Text(
                  "Run",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
              Text(
                webdata ?? "output is coming...",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
