import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:app_settings/app_settings.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

enum CheckModes { eco, sports }

class _HomePageState extends State<HomePage> {
  String stat = "";
  int i = 0;
  BluetoothDevice device;

  CheckModes _chk = CheckModes.eco;

  @override
  Widget build(BuildContext context) {
    FlutterBlue flutterBlue = FlutterBlue.instance;
    FlutterBlue.instance.state.listen((state) {
      if (state == BluetoothState.off) {
        stat = "Disabled";
        showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Bluetooth Connection Error'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Bluetooth should be Enabled for running the App'),
                    Text('Do you want to Enable Bluetooth ?'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Yes'),
                  onPressed: () {
                    i++;
                    AppSettings.openBluetoothSettings();
                    Navigator.of(context).pop();
                    setState(() {
                      _HomePageState();
                    });
                  },
                ),
                TextButton(
                  child: Text('Exit'),
                  onPressed: () {
                    //exit(0);
                  },
                ),
              ],
            );
          },
        );
      }
      if (state == BluetoothState.on) {
        if (i != 0) {
          i = 0;
          Navigator.of(context).pop();
        }
        setState(() {
          stat = "Enabled";
        });
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Safe Ride!"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(height: 30.0),
              Text('Connection Status: $stat'),
              SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () {
                  return showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Angle Check Alert',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            )),
                        content: StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListBody(
                                  children: <Widget>[
                                    Text('Select Your Mode',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 2.0,
                                        )),
                                    RadioListTile<CheckModes>(
                                      title: Text("Eco"),
                                      value: CheckModes.eco,
                                      groupValue: _chk,
                                      onChanged: (CheckModes value) {
                                        setState(() {
                                          _chk = value;
                                        });
                                      },
                                    ),
                                    RadioListTile<CheckModes>(
                                      title: Text("Sports"),
                                      value: CheckModes.sports,
                                      groupValue: _chk,
                                      onChanged: (CheckModes value) {
                                        setState(() {
                                          _chk = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('SET'),
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/btn');
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  'Alert Vehicle Angle',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Battery Percentage',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'A',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Check Engine Temperature',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
