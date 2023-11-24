import 'package:Urban_Solutions/ui/Process%20Operator/operator_timer.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Operator_card extends StatelessWidget {
  final String? selectedValue;
  Operator_card({required this.selectedValue});

  final Box _boxLogin = Hive.box("login");

  Future<List<Map<String, dynamic>>> fetchData(String selectedValue) async {
    final response = await http.get(Uri.parse('http://13.232.115.150:8000/processes/?manufacture_id=$selectedValue'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      // Extract the data you need from the response
      List<Map<String, dynamic>> processData = List<Map<String, dynamic>>.from(data['data']);
      return processData;
    } else {
      throw Exception('Failed to load data');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Model: $selectedValue'),
        elevation: 0,
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white),
              ),
              child: IconButton(
                onPressed: () {
                  _boxLogin.clear();
                  _boxLogin.put("loginStatus", false);
                },
                icon: const Icon(Icons.notifications),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(1.0),
            child :Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                const SizedBox(height: 10),
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: fetchData(selectedValue!),
                  builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: snapshot.data!.map((process) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Operator_timer(processName:process['process_name'], pId: process['p_id'], mId: process['m_id'])),
                              );
                            },
                            child: Container(
                              height: process['start_date'] != null ? 165 : 125,
                              child: Card(
                                elevation: 9,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0, bottom: 20.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      process['process_status'] == 'Completed' ? Icons.check : Icons.circle,
                                                      color: process['process_status'] == 'Not Started' ? Colors.grey : Colors.green,
                                                      size: 20.0,
                                                    ),
                                                    Text(process['process_status'] ?? 'null'),
                                                  ],
                                                ),

                                                Icon(Icons.chevron_right),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              process['process_name'] ?? 'null',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Visibility(
                                              visible: process['start_date'] != null,
                                              child: Column(
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Text("Start Date: ${process['start_date'] ?? 'null'}"),
                                                      Text("Time: ${process['time'] ?? 'null'}")
                                                    ],
                                                  ),
                                                  Visibility(
                                                      visible: process['completed_date'] != null && process['completed_date'] != '1111-11-11',
                                                      child: Column(
                                                        children: [
                                                          const SizedBox(height: 10),
                                                          Text("Complete Date: ${process['completed_date'] ?? 'null'}"),
                                                        ],
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )

                          );

                        }).toList(),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    // By default, show a loading spinner.
                    return CircularProgressIndicator();
                  },
                )






              ],
            ),
          ),
        ),
      ),
    );
  }

}


// Container(
//   height: 165,
//   child: Card(
//     elevation: 9,
//     child: Row(
//       children: <Widget>[
//         Expanded(
//           child: Padding(
//             padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0, bottom: 20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Row(
//                       children: <Widget>[
//                         Icon(Icons.check, color: Colors.green),
//                         Text('Completed'),
//                       ],
//                     ),
//                     Icon(Icons.chevron_right),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   'BOM Generation',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Text("Start Date : 21/02/2023"),
//                     Text("Time: 1hr 24min")
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 Text("Complete Date: 24/03/2023"),
//               ],
//             ),
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
//
//
// Container(
//   height: 145,
//   margin: EdgeInsets.only(top: 10.0),
//   child: GestureDetector(
//     child: Card(
//       elevation: 9,
//       child: Row(
//         children: <Widget>[
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0, bottom: 20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Row(
//                         children: <Widget>[
//                           Icon(Icons.circle_rounded, color: Colors.green),
//                           Text('On Going'),
//                         ],
//                       ),
//                       Icon(Icons.chevron_right),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     'Work Order Generation',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Text("Start Date : 21/02/2023"),
//                       Text("Time: 1hr 24min")
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//     onTap: () {
//       log ('Container is clicked', name: 'GestureDetector');
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => Operator_timer()),
//       );
//     },
//   ),
//
// ),
// Container(
//   height: 125,
//   margin: EdgeInsets.only(top: 10.0),
//   child: Card(
//     elevation: 9,
//     child: Row(
//       children: <Widget>[
//         Expanded(
//           child: Padding(
//             padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0, bottom: 20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Row(
//                       children: <Widget>[
//                         Icon(Icons.circle_rounded, color: Colors.grey),
//                         Text(' Not Started'),
//                       ],
//                     ),
//                     Icon(Icons.chevron_right),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   'Purchase as per BOM',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//
//               ],
//             ),
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
// Container(
//   height: 125,
//   margin: EdgeInsets.only(top: 10.0),
//   child: Card(
//     elevation: 9,
//     child: Row(
//       children: <Widget>[
//         Expanded(
//           child: Padding(
//             padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0, bottom: 20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Row(
//                       children: <Widget>[
//                         Icon(Icons.circle_rounded, color: Colors.grey),
//                         Text(' Not Started'),
//                       ],
//                     ),
//                     Icon(Icons.chevron_right),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   'Manufacturing of Tank',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//
//               ],
//             ),
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
// Text(
//   "Welcome 🎉",
//   style: Theme.of(context).textTheme.bodyLarge,
// ),
// const SizedBox(height: 10),
// Text(
//   _boxLogin.get("userName"),
//   style: Theme.of(context).textTheme.headlineLarge,
// ),
