import 'package:flutter/material.dart';

class MyPlants extends StatefulWidget {
  @override
  _MyPlantsState createState() => _MyPlantsState();
}

class _MyPlantsState extends State<MyPlants> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('My Plants')),
    );
  }
}