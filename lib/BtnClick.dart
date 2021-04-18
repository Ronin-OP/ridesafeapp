import 'package:flutter/material.dart';

class BottomAppBarDemo extends StatefulWidget {
  const BottomAppBarDemo();

  @override
  State createState() => _BottomAppBarDemoState();
}

class _BottomAppBarDemoState extends State<BottomAppBarDemo> {
  var chk;
  void chkChange(FloatingActionButtonLocation value) {
    setState(() {
      chk = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Safe Ride!"),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 90,
          ),
          Text("Select Your Mode",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                color: Colors.grey[600],
              )),
          SizedBox(
            height: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RadioListTile<FloatingActionButtonLocation>(
                title: Text("Eco"),
                value: FloatingActionButtonLocation.endDocked,
                groupValue: chk,
                onChanged: chkChange,
              ),
              RadioListTile<FloatingActionButtonLocation>(
                title: Text("Sports"),
                value: FloatingActionButtonLocation.centerDocked,
                groupValue: chk,
                onChanged: chkChange,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
