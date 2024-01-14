import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:greenmate/data/services/PlantSqlLiteService.dart';
import 'package:greenmate/features/models/Plant.dart';
import 'package:greenmate/features/screens/MyPlantsDetails.dart';
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
          builder: (context) => MyPlantsDetails(result: widget.activePlant)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
                backgroundColor: Colors.red.shade600,
                icon: Icons.delete_forever,
                label: 'Delete',
                borderRadius: BorderRadius.circular(10),
                onPressed: (context) async {
                  PlantSqlLiteService plantSqlLiteService =
                      PlantSqlLiteService();
                  widget.callBackFunc();
                  await plantSqlLiteService
                      .deletePlant(widget.activePlant.userPlantId);
                  widget.endFunc();
                })
          ],
        ),
        child: MaterialButton(
          onPressed: onPress,
          elevation: 4,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade100, width: 1),
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(widget.activePlant.userImage),
                    width: 130,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 130,
                      child: Text(widget.activePlant.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          )),
                    ),
                    Container(
                      width: 130,
                      child: Text(
                        widget.activePlant.latinName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 13, fontStyle: FontStyle.italic),
                      ),
                    ),
                    Text(
                      widget.activePlant.maintenance[0].type,
                      textAlign: TextAlign.left,
                    )
                  ],
                ))
              ],
            ),
          ),
        ));
  }
}
