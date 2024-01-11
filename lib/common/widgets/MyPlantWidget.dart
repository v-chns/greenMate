import 'dart:io';

import 'package:flutter/material.dart';

class MyPlantWidget extends StatefulWidget {
  // final ScrollController controller;
  final String name;
  final String latinName;
  final String action;

  const MyPlantWidget(
      {Key? key,
      required this.name,
      required this.action,
      required this.latinName})
      : super(key: key);

  @override
  _MyPlantWidgetState createState() => _MyPlantWidgetState();
}

class _MyPlantWidgetState extends State<MyPlantWidget> {
  void onPress() {
    print('babi');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              "assets/images/plant_dummy.jpg",
              width: 130,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Expanded(
                child: Column(
              children: [
                Text(widget.name,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    )),
                Text(
                  widget.latinName,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: 12, fontStyle: FontStyle.italic),
                ),
                Text(
                  widget.action,
                  textAlign: TextAlign.left,
                )
              ],
            )),
          )
        ],
      ),
    );
  }
}
