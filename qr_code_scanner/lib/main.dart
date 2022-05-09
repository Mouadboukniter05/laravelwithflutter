import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:qrcodescanner/login.dart';
import 'package:qrcodescanner/Firstpage.dart';
import 'package:flutter/rendering.dart';

void main() async => runApp(new MaterialApp(
  home: new MyApp(),
));
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      routes:<String,WidgetBuilder>{
        '/Login' : (BuildContext context) => new Login(),
        '/First' : (BuildContext context) => new First(),
      },
      home: Login(),
    );
  }
}



