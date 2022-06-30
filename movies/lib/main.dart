import 'package:flutter/material.dart';
import 'package:flutter_json_list/myModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String url =
      "https://raw.githubusercontent.com/nitishk72/flutter_json_list/master/json_example.json";

  List<myModel> myAllData = [];

  @override
  void initState() {
    loadData();
  }

  loadData() async {
    var response = await http.get(url, headers: {"Aceept": "application/json"});
    if (response.statusCode == 200) {
      String responeBody = response.body;
      var jsonBody = json.decode(responeBody);
      for (var data in jsonBody) {
        myAllData.add(new myModel(
            data['title'], data['authorName'], data['categoryName'], data['address']));
      }
      setState(() {});
      myAllData.forEach((someData) => print("Title : ${someData.title}"));
    } else {
      print('Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
      appBar: new AppBar(
        title: new Text('List'),
      ),
      body: myAllData.length == 0
          ? new Center(
              child: new CircularProgressIndicator(),
            )
          : showMyUI(),
    ));
  }

  Widget showMyUI() {
    return new ListView.builder(
        itemCount: myAllData.length,
        itemBuilder: (_, index) {
          return new Container(
            margin: new EdgeInsets.symmetric(vertical: 2.0,horizontal: 8.0),
            child: new Card(
              elevation: 10.0,
              child: new Container(
                padding: new EdgeInsets.all(12.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Padding(padding: new EdgeInsets.symmetric(vertical: 3.0)),
                    new Text('title : ${myAllData[index].title}'),
                    new Padding(padding: new EdgeInsets.symmetric(vertical: 3.0)),
                    new Text('Author Name : ${myAllData[index].authorName}'),
                    new Padding(padding: new EdgeInsets.symmetric(vertical: 3.0)),
                    new Text('categoryName : ${myAllData[index].categoryName}'),
                    new Padding(padding: new EdgeInsets.symmetric(vertical: 3.0)),
                    // new Text('Address : ${myAllData[index].address}'),
                    // new Padding(padding: new EdgeInsets.symmetric(vertical: 3.0)),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
