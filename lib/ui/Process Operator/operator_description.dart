import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Operator_description extends StatelessWidget {
  final int? mId;
  final int? pId;

  Operator_description({this.mId, this.pId});

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(Uri.parse('http://13.232.115.150:8000/about_process/?module=Description&m_id=$mId&p_id=$pId'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      // Extract the data you need from the response
      Map<String, dynamic> processData = Map<String, dynamic>.from(data['data']);
      return processData;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Description"),
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
                    snapshot.data!['process_name'],
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(snapshot.data!['description']),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
