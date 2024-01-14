import 'package:flutter/material.dart';
import 'package:greenmate/features/models/Plant.dart';

class PlantCare extends StatefulWidget {
  final Plant result;
  const PlantCare({Key? key, required this.result})
      : super(key: key);

  @override
  State<PlantCare> createState() => _PlantCareState();
}

class _PlantCareState extends State<PlantCare> {
  @override
  Widget build(BuildContext context) {
    return const Text("ini plant care");
  }
}
