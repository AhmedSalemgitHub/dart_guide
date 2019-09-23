import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  
  Home({this.user});

  final user ;
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    
    print(widget.user);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "test"
        ),
      ),
      body: Container(
        child: Text("welcome"),
      ),
    );
  }
}