import 'package:dart_guide/UI/login.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'UI/home.dart';
import 'UI/register.dart';

main (){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  static GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/register': (context) => Register(cardKey),
        '/login': (context) => Login(cardKey),
        '/home': (context) => Home(),
      },
      initialRoute: 'login',
      debugShowCheckedModeBanner: false,
      home:FlipCard (
        key: cardKey,
        direction: FlipDirection.HORIZONTAL,
        front: Login(cardKey),
        back: Register(cardKey),
        flipOnTouch: false,

      ),
      
      
      theme: ThemeData(
        accentColor: Colors.white,
        primarySwatch: Colors.green
      ),
    );
  }

}

