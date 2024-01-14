import 'package:flutter/material.dart';
import 'package:greenmate/features/models/Plant.dart';

class PlantAbout extends StatefulWidget {
  final Plant result;
  const PlantAbout({Key? key, required this.result})
      : super(key: key);

  @override
  State<PlantAbout> createState() => _PlantCareState();
}

class _PlantCareState extends State<PlantAbout> {
  @override
  Widget build(BuildContext context) {
    return const Text("ini plant ");
  }
}