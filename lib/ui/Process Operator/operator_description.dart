import 'package:flutter/material.dart';

class Operator_description extends StatelessWidget {
  Operator_description({super.key});


  @override
  Widget build(BuildContext context) {
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
              'Description',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey
              ),
            ),
            const SizedBox(height: 10),
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, nunc at pellentesque aliquet, mi risus tristique massa, eget egestas libero dui id orci. Praesent at ultricies sem, at interdum diam. Donec in metus sit amet risus feugiat lacinia non quis ante. Sed vitae mi auctor, aliquam erat in, lacinia dolor. Vivamus fermentum, sem sit amet convallis bibendum, mauris ipsum porta nisi, non pharetra enim turpis eget velit. Nulla facilisi. Sed congue, mauris nec auctor dapibus, justo ex cursus ex, sit amet pellentesque turpis sem a nisl. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Sed at massa non nulla placerat ultricies. Donec sed augue at erat mollis consectetur."),
          ],
        ),
      ),
    );
  }
}