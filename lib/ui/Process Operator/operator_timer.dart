import 'dart:async';

import 'package:Urban_Solutions/ui/Process%20Operator/operator_raiseissue.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:developer';

import 'operator_details.dart';


class Operator_timer extends StatefulWidget {
  Operator_timer({Key? key}) : super(key: key);

  @override
  _Operator_timerState createState() => _Operator_timerState();
}

class _Operator_timerState extends State<Operator_timer> {
  final Box _boxLogin = Hive.box("login");
  bool _isRunning = false;
  Stopwatch _stopwatch = Stopwatch();

  void _toggleTimer() {
    setState(() {
      _isRunning = !_isRunning;
      if (_isRunning) {
        _stopwatch.start();
        Timer.periodic(Duration(seconds: 1), (Timer t) {
          if (_isRunning) {
            setState(() {});
          } else {
            t.cancel();
          }
        });
      } else {
        _stopwatch.stop();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Work Order Generation"),
        elevation: 0,
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            showMenu(
              context: context,
              position: RelativeRect.fromLTRB(100, 60, 0, 0), // position where you want to show the menu
              items: [
                PopupMenuItem(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: Colors.grey),
                      ),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.find_in_page_rounded),
                      title: Text("Details"),
                    ),
                  ),
                  value: 1,
                ),
                PopupMenuItem(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: Colors.grey),
                      ),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.stacked_line_chart),
                      title: Text("Graph"),
                    ),
                  ),
                  value: 2,
                ),
                PopupMenuItem(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: Colors.grey),
                      ),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.description),
                      title: Text("Description"),
                    ),
                  ),
                  value: 3,
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.report_problem),
                    title: Text("Raise issue"),
                  ),
                  value: 4,
                ),
              ],
            ).then((value) {
              if (value != null) {
                switch (value) {
                  case 1:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Operator_details()),
                    );
                    break;
                  case 2:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Operator_details()),
                    );
                    break;
                  case 3:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Operator_details()),
                    );
                    break;
                  case 4:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Operator_raiseissue()),
                    );
                    break;
                }
              }
            });
          },
        )

         ),

        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Center(
              child: _isRunning
                  ? Image.asset('lib/assets/gears2.gif')
                  : Image.asset('lib/assets/gears.png'),
            ),
          ),
          Card(
            elevation: 15,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          'Time: ',
                          style: TextStyle(fontSize: 19,color: Colors.grey),
                        ),
                        Text(
                          '${_stopwatch.elapsed.inHours.remainder(60).toString().padLeft(2, '0')}hr : ${_stopwatch.elapsed.inMinutes.remainder(60).toString().padLeft(2, '0')}min',
                          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(140, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Colors.green,
                      ),
                      onPressed: _toggleTimer,
                      child: Text(_isRunning ? 'Stop' : 'Start'),
                    ),
                  ],
                )


            ),
          ),
        ],
      ),
    );
  }
}
