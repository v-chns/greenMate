import 'package:flutter/material.dart';
import 'package:greenmate/features/models/Plant.dart';

class PlantTutorial extends StatefulWidget {
  final Plant result;
  const PlantTutorial({Key? key, required this.result}) : super(key: key);

  @override
  State<PlantTutorial> createState() => _PlantTutorialState();
}

class _PlantTutorialState extends State<PlantTutorial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
        Text("ini tutorial"),
      ),
    );
  }
}
