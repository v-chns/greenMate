import 'dart:io';

import 'package:flutter/material.dart';
import 'package:greenmate/data/services/PlantSqlLiteService.dart';
import 'package:greenmate/features/models/Plant.dart';
import 'package:greenmate/features/screens/PlantDetails.dart';

class MyPlantWidget extends StatefulWidget {
  // final ScrollController controller;
  // final String name;
  // final String latinName;
  // final String action;
  // final String image;
  // final int id;

  final Plant activePlant;
  final void Function() callBackFunc;
  final void Function() endFunc;

  const MyPlantWidget(
      {Key? key,
      required this.activePlant,
      required this.callBackFunc,
      required this.endFunc})
      : super(key: key);

  @override
  _MyPlantWidgetState createState() => _MyPlantWidgetState();
}

class _MyPlantWidgetState extends State<MyPlantWidget> {
  void onPress() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PlantDetails(result: widget.activePlant)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.file(
              File(widget.activePlant.userImage),
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
                Text(widget.activePlant.name.length > 15 ? widget.activePlant.name.substring(0, 15 - 3) + '...' : widget.activePlant.name,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    )),
                Text(
                  widget.activePlant.latinName.length > 15 ? widget.activePlant.latinName.substring(0, 15 - 3) + '...' : widget.activePlant.latinName,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: 12, fontStyle: FontStyle.italic),
                ),
                Text(
                  widget.activePlant.maintenance[0].type,
                  textAlign: TextAlign.left,
                )
              ],
            )),
          ),
          Positioned(
            top: 0,
            right: 0,
            child:
                IconButton(icon: Icon(Icons.delete_forever), onPressed: () async {
                  PlantSqlLiteService plantSqlLiteService = PlantSqlLiteService();
                  
                  widget.callBackFunc();
                  await plantSqlLiteService.deletePlant(widget.activePlant.userPlantId);
                  widget.endFunc();
                }),
          )
        ],
      ),
    );
  }
}
