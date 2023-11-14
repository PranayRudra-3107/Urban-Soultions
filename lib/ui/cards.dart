import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'home.dart';
import 'login.dart';

class All extends StatelessWidget {
  All({super.key});

  final Box _boxLogin = Hive.box("login");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).colorScheme.primary,
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
                Container(
                  height: 165,
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
                                        Icon(Icons.check, color: Colors.green),
                                        Text('Completed'),
                                      ],
                                    ),
                                    Icon(Icons.chevron_right),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'BOM Generation',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text("Start Date : 21/02/2023"),
                                    Text("Time: 1hr 24min")
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text("Complete Date: 24/03/2023"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 145,
                  margin: EdgeInsets.only(top: 10.0),
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
                                        Icon(Icons.circle_rounded, color: Colors.green),
                                        Text('On Going'),
                                      ],
                                    ),
                                    Icon(Icons.chevron_right),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Work Order Generation',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text("Start Date : 21/02/2023"),
                                    Text("Time: 1hr 24min")
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 125,
                  margin: EdgeInsets.only(top: 10.0),
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
                                        Icon(Icons.circle_rounded, color: Colors.grey),
                                        Text(' Not Started'),
                                      ],
                                    ),
                                    Icon(Icons.chevron_right),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Purchase as per BOM',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 125,
                  margin: EdgeInsets.only(top: 10.0),
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
                                        Icon(Icons.circle_rounded, color: Colors.grey),
                                        Text(' Not Started'),
                                      ],
                                    ),
                                    Icon(Icons.chevron_right),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Manufacturing of Tank',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
      ),
    );
  }
}
