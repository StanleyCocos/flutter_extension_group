import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_group_data/flutter_group_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _groupData = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String groupData;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      groupData = await FlutterGroupData.groupShared("number");
    } on PlatformException {
      groupData = 'Failed to get platform version.';
    }

    //FlutterGroupData.getPushMessage()
    Map<String>

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _groupData = groupData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app '),
        ),
        body: Center(
          child: Column(
            children: <Widget>[

              Padding(padding: EdgeInsets.only(top: 100),),

              Text("当前数据: $_groupData"),

              Padding(padding: EdgeInsets.only(top: 100),),
              GestureDetector(
                onTap: (){
                  initPlatformState();
                },
                child: Container(
                  width: 100,
                  height: 40,
                  alignment: Alignment.center,
                  color: Colors.red,
                  child: Text(
                      "获取数据"
                  ),
                ),
              ),

              Padding(padding: EdgeInsets.only(top: 100),),
              GestureDetector(
                onTap: (){
                  FlutterGroupData.setGroupShared("number", "10");
                },
                child: Container(
                  width: 100,
                  height: 40,
                  alignment: Alignment.center,
                  color: Colors.yellow,
                  child: Text(
                      "设置数据"
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
