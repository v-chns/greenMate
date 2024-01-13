import 'package:flutter/material.dart';
import 'package:greenmate/common/widgets/HomeCalendarWidget.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      // body: HomeCalendarWidget(),
    );
  }
}