import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ridesafe_app/BtnClick.dart';
import 'HomePage.dart';
import 'LocalData.dart';

String bname;
List<String> r = null;

void main() => runApp(MaterialApp(initialRoute: '/', routes: {
      '/': (context) => MainApp(),
      '/btConnect': (context) => BtnClick(),
      '/home': (context) => HomePage(),
      '/local': (context) => LocalData()
    }));

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wait();
  }

  void wait() async {
    await Future.delayed(const Duration(seconds: 16), () {});
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file1 = File('${directory.path}/my_bname.txt');
      bname = await file1.readAsString();
      r = bname.split('::');
    } catch (e) {
      print("Couldn't read file");
    }
    if (r != null) {
      Navigator.pushReplacementNamed(context, '/btConnect');
    } else {
      Navigator.pushReplacementNamed(context, '/local');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Column(
        children: [
          Container(
            child: Image.asset('assets/logo.jpg'),
          ),
          Container(
            child: Image.asset('assets/iron.gif'),
          ),
        ],
      ),
    ));
  }
}
