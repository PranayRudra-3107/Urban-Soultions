import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:developer';


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
              onPressed: () {
                _boxLogin.clear();
                _boxLogin.put("loginStatus", false);
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return const Login();
                //     },
                //   ),
                // );
              },
              icon: const Icon(Icons.more_vert),
            ),
          )
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
