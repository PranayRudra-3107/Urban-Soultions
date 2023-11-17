import 'package:flutter/material.dart';

class Operator_details extends StatelessWidget {
  Operator_details({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
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
              )
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0, bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
                Row(
                  children: [
                    Text("Status:"),
                    Row(
                      children: <Widget>[
                        Icon(Icons.circle_rounded, color: Colors.green),
                        Text('On Going'),
                      ],
                    ),
                  ],
                ),
                Text("Type: Quality Check")
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Start Date : 21/02/2023"),
                Text("End Date : 21/02/2023")
              ],
            ),
          ],
        ),
      ),
    );
  }
}