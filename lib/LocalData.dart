import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ridesafe_app/BtnClick.dart';

int cc = null;
String bname = null;

class LocalData extends StatefulWidget {
  const LocalData({Key key}) : super(key: key);
  _LocalDataState createState() => _LocalDataState();
}

_save() async {
  final directory = await getApplicationDocumentsDirectory();
  final file1 = File('${directory.path}/ridesafe_app.txt');
  await file1.writeAsString(bname + "::" + cc.toString());
  print('saved');
}

class _LocalDataState extends State<LocalData> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              child: Image.asset('assets/logo.jpg'),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  children: [
                    Text('Bike Name: ',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      onChanged: (name) {
                        bname = name;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Bike Name',
                        hintText: 'Enter Your Bike Name',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Bike CC',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (c) {
                        cc = int.parse(c);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Bike CC',
                        hintText: 'Enter Bike CC',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )),
            ElevatedButton(
                onPressed: () {
                  if (cc != null && bname != null) {
                    _save();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return BtnClick();
                        },
                      ),
                    );
                  } else {
                    cc = null;
                    bname = null;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LocalData();
                        },
                      ),
                    );
                  }
                },
                child: Text('Get.Set.Go'))
          ],
        ),
      ),
    );
  }
}
