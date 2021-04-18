import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:app_settings/app_settings.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toast/toast.dart';

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
        int j = 0;
        // while (j < 1) {
        //   AppSettings.openBluetoothSettings();
        //   j++;
        // }
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
                  showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      int selectedRadio = 0;
                      return AlertDialog(
                        title: Text('Select Your Mode'),
                        content: StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  title: Text('Eco'),
                                  leading: Radio(
                                    value: CheckModes.eco,
                                    groupValue: _chk,
                                    onChanged: (CheckModes value) {
                                      setState(() {
                                        _chk = value;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: Text('Sports'),
                                  leading: Radio(
                                    value: CheckModes.sports,
                                    groupValue: _chk,
                                    onChanged: (CheckModes value) {
                                      setState(() {
                                        _chk = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Set'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              if (_chk == CheckModes.sports) {
                                Fluttertoast.showToast(
                                  msg: "Alert is Disabled",
                                  backgroundColor: Colors.grey,
                                );
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Alert is Enabled",
                                  backgroundColor: Colors.grey,
                                );
                              }
                              setState(() {
                                _HomePageState();
                              });
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
