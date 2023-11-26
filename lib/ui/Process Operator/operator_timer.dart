import 'dart:async';
import 'dart:convert';
import 'package:Urban_Solutions/ui/Process%20Operator/operator_graphs.dart';
import 'package:http/http.dart' as http;
import 'package:Urban_Solutions/ui/Process%20Operator/operator_description.dart';
import 'package:Urban_Solutions/ui/Process%20Operator/operator_raiseissue.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:developer';
import 'package:intl/intl.dart';


import 'operator_details.dart';

class StopWatch extends Stopwatch{
  int _starterMilliseconds = 0;

  StopWatch();

  get elapsedDuration{
    return Duration(
        microseconds:
        this.elapsedMicroseconds + (this._starterMilliseconds * 1000)
    );
  }

  get elapsedMillis{
    return this.elapsedMilliseconds + this._starterMilliseconds;
  }

  set milliseconds(int timeInMilliseconds){
    this._starterMilliseconds = timeInMilliseconds;
  }

}

class Operator_timer extends StatefulWidget {
  final String? processName;
  final int? pId;
  final int? mId;
  Operator_timer({this.processName,this.pId, this.mId}) ;

  @override
  _Operator_timerState createState() => _Operator_timerState();
}

class _Operator_timerState extends State<Operator_timer> {
  String? processName;
  int? pId;
  int? mId;

  final Box _boxLogin = Hive.box("login");
  String _status = 'On Going';
  Future<void> updateProcess() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    print('Updating process with the following data:');
    print('m_id: ${widget.mId}');
    print('p_id: ${widget.pId}');
    print('start_date: $formattedDate');
    print('end_date: ${_isRunning ? '1111-11-11' : formattedDate}');
    print('time: ${_isRunning ? '00:00:00' : _stopwatch.elapsedDuration.inHours.remainder(60).toString().padLeft(2, '0')} : ${_stopwatch.elapsedDuration.inMinutes.remainder(60).toString().padLeft(2, '0')} : ${_stopwatch.elapsedDuration.inSeconds.remainder(60).toString().padLeft(2, '0')}');
    print('issues: issue raised');
    print('status: $_status');

    final response = await http.put(
      Uri.parse('http://13.232.115.150:8000/start_stop_process/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'm_id': '${widget.mId}',
        'p_id': '${widget.pId}',
        'start_date': formattedDate,
        'end_date': _isRunning ? '1111-11-11' : formattedDate,
        'time': _isRunning
            ? '00:00:00'
            : '${_stopwatch.elapsedDuration.inHours.remainder(60).toString().padLeft(2, '0')} : ${_stopwatch.elapsedDuration.inMinutes.remainder(60).toString().padLeft(2, '0')} : ${_stopwatch.elapsedDuration.inSeconds.remainder(60).toString().padLeft(2, '0')}',
        'issues': 'issue raised',
        'status': _status,
      }),
    );

    if (response.statusCode == 200) {
      print('Process updated successfully, mId: ${widget.mId}, pId: ${widget.pId}');
    } else {
      print('Failed to update process. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to update process.');
    }
  }



  bool _isRunning = false;

  var _stopwatch = new StopWatch();
  void _toggleTimer() {
    setState(() {
      _isRunning = !_isRunning;
      _status = _isRunning ? 'On Going' : 'Completed';
      if (_isRunning) {
        _stopwatch.start();
        _stopwatch.milliseconds = 10000;

        Timer.periodic(Duration(seconds: 1), (Timer t) {
          if (_isRunning) {
            setState(() {});
          } else {
            t.cancel();
            updateProcess();
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
        title: Text('${widget.processName}'),
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
                            title: Text("Graphs"),
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
                            MaterialPageRoute(builder: (context) => Operator_details(mId: widget.mId, pId: widget.pId)),
                          );
                          break;
                        case 2:
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Operator_graphs(mId:widget.mId,pId:widget.pId)),
                          );
                          break;
                        case 3:
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Operator_description(mId: widget.mId, pId: widget.pId)),
                          );
                          break;
                        case 4:
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Operator_raiseissue(widget.mId,widget.pId)),
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
                          '${_stopwatch.elapsedDuration.inHours.remainder(60).toString().padLeft(2, '0')} : ${_stopwatch.elapsedDuration.inMinutes.remainder(60).toString().padLeft(2, '0')} : ${_stopwatch.elapsedDuration.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                        )

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
                      onPressed: () {
                        _toggleTimer();
                        updateProcess();
                      },
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