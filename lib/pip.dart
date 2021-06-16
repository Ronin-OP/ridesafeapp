import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pip_view/pip_view.dart';

class Pip extends StatefulWidget {
  @override
  _MyScreen createState() => new _MyScreen();
}

class _MyScreen extends State<Pip> {
  @override
  Widget build(BuildContext context) {
    return PIPView(
      builder: (context, isFloating) {
        return Scaffold(
          body: Column(
            children: [
              Text('This is the screen that will float!'),
              MaterialButton(
                child: Text('Start floating'),
                onPressed: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}
