import 'package:flutter/material.dart';
import 'package:ridesafe_app/BtnClick.dart';

import 'HomePage.dart';

void main() => runApp(MaterialApp(initialRoute: '/', routes: {
      '/': (context) => MainApp(),
      '/btConnect': (context) => BtnClick(),
      '/home': (context) => HomePage()
    }));

class MainApp extends StatefulWidget {
  // This widget is the root of your application.
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
    await Future.delayed(const Duration(seconds: 1), () {});
    Navigator.pushReplacementNamed(context, '/btConnect');
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
