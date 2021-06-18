import 'package:flutter/material.dart';
import 'package:ridesafe_app/BtnClick.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomePage.dart';
import 'LocalData.dart';

SharedPreferences prefs;

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
    prefs = await SharedPreferences.getInstance();
    String a = prefs.getString('bname') ?? null;
    int b = prefs.getInt('cc') ?? null;
    if (a != null && b != null) {
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
