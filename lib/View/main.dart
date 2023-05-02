import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:corpus_ls/View/inscription.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title : 'Flutter demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:se_connecter(),
    );
  }
}
