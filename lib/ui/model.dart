import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'cards.dart';
import 'home.dart';
import 'login.dart';

class Model extends StatelessWidget {
  Model({super.key});

  final Box _boxLogin = Hive.box("login");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        tabBarTheme: TabBarTheme(
          labelColor: Colors.black,
          indicator: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.green, width: 3.0),
            ),
          ),
        ),
      ),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Model:S -10"),
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
          body: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Search Process',
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                  ),
                ),
                const SizedBox(height: 15),
                TabBar(
                  isScrollable: true,
                  tabs: [
                    Flexible(child: Tab(text: 'All')),
                    Flexible(child: Tab(text: 'On Going')),
                    Flexible(child: Tab(text: 'Not Started')),
                    Flexible(child: Tab(text: 'Completed')),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Center(child: All()),
                      Center(child: All()),
                      Center(child: All()),
                      Center(child: All()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
