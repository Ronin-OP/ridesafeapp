import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ridesafe_app/BtnClick.dart';
import 'package:shared_preferences/shared_preferences.dart';

int cc = null;
String bname = null;
SharedPreferences prefs;

class LocalData extends StatefulWidget {
  const LocalData({Key key}) : super(key: key);
  _LocalDataState createState() => _LocalDataState();
}

_save() async {
  final directory = await getApplicationDocumentsDirectory();
  final file1 = File('${directory.path}/my_bname.txt');
  await file1.writeAsString(bname);
  final file2 = File('${directory.path}/my_bCC.txt');
  await file2.writeAsString(cc.toString());
  print('saved');
}

void setData() async {
  print('1');
  print('2');
  prefs = await SharedPreferences.getInstance();
  print('1');
  print('2');
  prefs.setInt('cc', cc);
  print('1');
  print('2');
  prefs.setString('bname', bname);
  print('1');
  print('2');
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
            Text('Bike Name: '),
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
            Text('Bike CC'),
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
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  if (cc != null && bname != null) {
                    _save();
                    setData();
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

class DataShow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Hada $prefs');
    String a = prefs.getString('bname') ?? null;
    int b = prefs.getInt('cc') ?? null;
    return Material(
      child: Container(
        child: Text('\n\n\n\n CC : $b \n BNAME: $a'),
      ),
    );
  }
}
