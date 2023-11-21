import 'package:Urban_Solutions/ui/Process%20Operator/operator_card.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'QRView.dart';
import 'login.dart';
import 'model.dart';
class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {

  final Box _boxLogin = Hive.box("login");
  String? dropdownValue;
  Future<List<String>> fetchData() async {
    final response = await http.get(Uri.parse('http://13.232.115.150:8000/manufacture/'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<String> manufactureData = List<String>.from(data['manufacture_data']);
      return manufactureData;
    } else {
      throw Exception('Failed to load data');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const Login();
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.logout_rounded),
              ),
            ),
          )
        ],
      ),
      //backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child :Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                'Search Work Order No.',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    child: FutureBuilder<List<String>>(
                      future: fetchData(),
                      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                        if (snapshot.hasData) {
                          return DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            items: snapshot.data?.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                dropdownValue = newValue;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Operator_card(selectedValue: dropdownValue)),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }

                        // By default, show a loading spinner.
                        return CircularProgressIndicator();
                      },
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 10),
              Center(child: Text('or')),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QRViewExample()),
                  );
                },
                child: const Text("Scan work order QR code"),
              ),

              const SizedBox(height: 10),
              // Text("Recent Work Orders"),
              // Container(
              //   height: 300,
              //   child: ListView.builder(
              //     itemCount: 5,
              //     itemBuilder: (BuildContext context, int index){
              //       return Container(
              //         height: 150,
              //         child: GestureDetector(
              //           onTap: () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(builder: (context) => Operator_card(selectedValue: dropdownValue)),
              //             );
              //           },
              //           child: Card(
              //             elevation: 9,
              //             child: Row(
              //               children: <Widget>[
              //                 Image.asset(
              //                   'lib/assets/model.png',
              //                   width: 150,
              //                   height: 150,
              //                 ),
              //                 Expanded(
              //                   child: Padding(
              //                     padding: EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0, bottom: 10.0),
              //                     child: Column(
              //                       crossAxisAlignment: CrossAxisAlignment.start,
              //                       children: <Widget>[
              //                         Text(
              //                           'Model: S-10',
              //                           style: TextStyle(
              //                             fontSize: 19,
              //                             fontWeight: FontWeight.bold,
              //                           ),
              //                         ),
              //                         Text( 'Processing capacity 10kg of wet waste',
              //                           style: TextStyle(
              //                             fontSize: 15,
              //                           ),
              //                           softWrap: true,
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       );
              //
              //     }
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
            ],
          ),
        ),
      ),
    );
  }
}

//IconButton(
//   icon: Icon(Icons.filter_list),
//   onPressed: () {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//             return AlertDialog(
//                 title: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Text('Filters'),
//                     GestureDetector(
//                       onTap: () {
//                         // Add your logic here to clear all the data in the text fields
//                       },
//                       child: Text(
//                         'Remove Filters',
//                         style: TextStyle(
//                           color: Colors.blue,
//                           fontSize: 12,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 content: SingleChildScrollView(
//                   child: ConstrainedBox(
//                     constraints: BoxConstraints(
//                       maxWidth: 600,  // Set this to your desired width
//                     ),
//                     child: ListBody(
//                       children: <Widget>[
//                         Text("Start Date"),
//                         TextFormField(
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             isDense: true,
//                             suffixIcon: IconButton(
//                               onPressed: () async {
//                                 FocusScope.of(context).requestFocus(new FocusNode());
//                                 final DateTime? picked = await showDatePicker(
//                                   context: context,
//                                   initialDate: DateTime.now(),
//                                   firstDate: DateTime(2000),
//                                   lastDate: DateTime(2100),
//                                 );
//                                 if (picked != null) {
//                                   // handle the picked date
//                                 }
//                               },
//                               icon: Icon(Icons.calendar_today),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 10), // add some spacing
//                         Text("Model No."),
//                         DropdownButtonFormField<String>(
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             isDense: true,
//                           ),
//                           items: <String>['Model 1', 'Model 2', 'Model 3'].map((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value),
//                             );
//                           }).toList(),
//                           onChanged: (_) {},
//                         ),
//                         SizedBox(height: 10), // add some spacing
//                         Text("Status"),
//                         DropdownButtonFormField<String>(
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             isDense: true,
//                           ),
//                           items: <String>['Status 1', 'Status 2', 'Status 3'].map((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value),
//                             );
//                           }).toList(),
//                           onChanged: (_) {},
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 actions: <Widget>[
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly, // This will evenly space the buttons
//                     children: <Widget>[
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0), // Add some padding around the button
//                           child: TextButton(
//                             style: TextButton.styleFrom(
//                               primary: Colors.green, // This sets the text color
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20),
//                                 side: BorderSide(color: Colors.green), // This sets the border color
//                               ),
//                             ),
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: const Text("Cancel"),
//                           )
//
//                         ),
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0), // Add some padding around the button
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               minimumSize: const Size.fromHeight(37),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               backgroundColor: Colors.green,
//                             ),
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: const Text("Apply"),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ]
//
//             );
//           },
//     );
//   },
// )
