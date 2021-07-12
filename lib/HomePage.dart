import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vibration/vibration.dart';

class HomePage extends StatefulWidget {
  final BluetoothDevice server;
  const HomePage({this.server});

  @override
  _HomePageState createState() => new _HomePageState();
}

int temp = 0;
int perc = 0;
String align = "";
SpinKitRing cir;
SpinKitFadingCube facu;
SpinKitFoldingCube focu;
String bname;
String bcc;
List<String> r;

enum CheckModes { eco, sports }

int opt;

List a;
var f1, f2;
String btStatus = "ON";
int i = 0;
int count = 0;
BluetoothDevice device;
CheckModes _chk;
String conStatus = "Not Connected";

class _Message {
  int whom;
  String text;
  _Message(this.whom, this.text);
}

String t = "";

class _HomePageState extends State<HomePage> {
  static final clientID = 0;
  BluetoothConnection connection;
  List<_Message> messages = List<_Message>();
  String _messageBuffer = '';
  bool isConnecting = true;
  bool get isConnected => connection != null && connection.isConnected;
  bool isDisconnecting = false;

  @override
  void initState() {
    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });
      connection.input.listen(_onDataReceived).onDone(() {
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
        if (this.mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, Exception Occured');
      print(error);
    });
    super.initState();
  }

  @override
  void dispose() {
    if (isConnected) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isConnected == false) {
      FlutterBluetoothSerial.instance.requestEnable();
    }
    if (_chk == CheckModes.eco && count == 1) {
      if (count == 1) {
        t.trim();
        f1 = int.parse(t);
      } else {
        if (count != 1) {
          t.trim();
          f2 = int.parse(t);
          if (f1 - f2 > 10 || f2 - f1 > 10) {
            Vibration.vibrate(pattern: [500, 1000, 500, 2000]);
          }
        }
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Safe Ride!")),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(height: 30.0),
              Text('Bluetooth Status: $btStatus'),
              SizedBox(height: 40.0),
              Text('Connection Status : $conStatus'),
              SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () {
                  _sendMessage("1");
                  showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
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
                              if (_chk == CheckModes.eco) {
                                count++;
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
                onPressed: () {
                  _sendMessage("2");
                  showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        Future.delayed(Duration(seconds: 10), () {
                          Navigator.of(context).pop(true);
                          fun2(2);
                        });
                        return AlertDialog(
                          title: Text(''),
                          content: SingleChildScrollView(
                            child: Row(
                              children: [
                                focu = SpinKitFoldingCube(
                                  color: Colors.deepOrangeAccent,
                                  size: 50.0,
                                ),
                                Text('    Checking'),
                              ],
                            ),
                          ),
                          actions: [
                            Text(''),
                          ],
                        );
                      });
                },
                child: Text(
                  'Battery Percentage',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () {
                  _sendMessage("3");
                  showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        Future.delayed(Duration(seconds: 10), () {
                          Navigator.of(context).pop(true);
                          fun2(3);
                        });
                        return AlertDialog(
                          title: Text(''),
                          content: SingleChildScrollView(
                            child: Row(
                              children: [
                                facu = SpinKitFadingCube(
                                  color: Colors.blueAccent,
                                  size: 50.0,
                                ),
                                Text('    Checking'),
                              ],
                            ),
                          ),
                          actions: [
                            Text(''),
                          ],
                        );
                      });
                },
                child: Text(
                  'Check Wheel Align',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () {
                  _sendMessage("4");
                  showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        Future.delayed(Duration(seconds: 10), () {
                          Navigator.of(context).pop(true);
                          fun2(4);
                        });
                        return AlertDialog(
                          title: Text(''),
                          content: SingleChildScrollView(
                            child: Row(
                              children: [
                                cir = SpinKitRing(
                                  color: Colors.grey,
                                  size: 50.0,
                                ),
                                Text('    Checking'),
                              ],
                            ),
                          ),
                          actions: [
                            Text(''),
                          ],
                        );
                      });
                },
                child: Text(
                  'Check Engine Temperature',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 40.0),
              ElevatedButton(
                  onPressed: () {
                    _read();
                    showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          Future.delayed(Duration(seconds: 10), () {
                            Navigator.of(context).pop(true);
                            fun2(5);
                            // Navigator.of(context).push(new MaterialPageRoute(
                            //     builder: (BuildContext context) =>
                            //         DataShown()));
                          });
                          return AlertDialog(
                            title: Text(''),
                            content: SingleChildScrollView(
                              child: Row(
                                children: [
                                  cir = SpinKitRing(
                                    color: Colors.grey,
                                    size: 50.0,
                                  ),
                                  Text('    Checking'),
                                ],
                              ),
                            ),
                            actions: [
                              Text(''),
                            ],
                          );
                        });
                  },
                  child: Text(' Local DAta Cache')),
            ],
          ),
        ],
      ),
    );
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
      print('Uint8List $data');
      a = data;
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {
        messages.add(
          _Message(
            1,
            backspacesCounter > 0
                ? _messageBuffer.substring(
                    0, _messageBuffer.length - backspacesCounter)
                : _messageBuffer + dataString.substring(0, index),
          ),
        );
        _messageBuffer = dataString.substring(index);
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
    print('String $dataString');
    t = t + dataString;
    t.trim();
  }

  void _sendMessage(String text) async {
    text = text.trim();
    if (text.length > 0) {
      try {
        connection.output.add(utf8.encode(text + "\r\n"));
        await connection.output.allSent;

        setState(() {
          messages.add(_Message(clientID, text));
        });

        Future.delayed(Duration(milliseconds: 333)).then((_) {});
      } catch (e) {
        setState(() {});
      }
    }
  }

  Widget fun2(int no) {
    String join = "";
    String heading = "";
    if (no == 2) {
      heading = "Battery Percentage";
    } else if (no == 3) {
      heading = "Wheel Alignment";
    } else if (no == 4) {
      heading = "Engine Temperature";
    } else if (no == 5) {
      heading = "Data Cache";
      join = "BName : " + r[0] + " CC : " + r[1];
    }
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$heading'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '$t $join',
                  style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                t = "";
                Navigator.of(context).pop();
                setState(() {
                  _HomePageState();
                });
              },
            ),
          ],
        );
      },
    );
  }

  void fun1() {
    sleep(Duration(seconds: 10));
  }
}

class MyBackgroundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('This is my background screen!'),
    );
  }
}

_read() async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file1 = File('${directory.path}/ridesafe_app.txt');
    bname = await file1.readAsString();
    r = bname.split('::');
  } catch (e) {
    print("Couldn't read file");
  }
}
