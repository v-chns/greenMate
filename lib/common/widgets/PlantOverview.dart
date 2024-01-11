import 'package:flutter/material.dart';
import 'package:greenmate/features/models/Plant.dart';

class PlantOverview extends StatefulWidget {
  final Plant result;
  const PlantOverview({Key? key, required this.result}) : super(key: key);

  @override
  State<PlantOverview> createState() => _PlantOverviewState();
}

class _PlantOverviewState extends State<PlantOverview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
        Text("ini overview"),
      ),
    );
  }
}

