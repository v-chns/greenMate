import 'package:flutter/material.dart';
import 'package:greenmate/common/widgets/PlantsGridView.dart';
import 'package:greenmate/data/services/GetPlantsList.dart';
import 'package:greenmate/features/models/Plant.dart';

class PanelWidget extends StatefulWidget {
  final ScrollController controller;

  const PanelWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _PanelWidgetState createState() => _PanelWidgetState();

}

class _PanelWidgetState extends State<PanelWidget>{

  String resultText = '';


  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0, bottom: 15.0),
        controller: widget.controller,
        children:  [
          // Drag handler (garis abu)
          Center(
            child: Container(
              width: 80,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          // dahlah ini jadiin space aja wkwk karena jadinya bagus
          Padding(
            padding: resultText.isEmpty ? EdgeInsets.zero : EdgeInsets.all(5.0),
            child: Text(resultText, style: Theme.of(context).textTheme.bodySmall,), // Display the result text
          ),
          Container(
            child: TextField(
              style: Theme.of(context).textTheme.titleMedium,
              decoration: InputDecoration(
                hintText: 'Search Plant',
                prefixIcon: Icon(Icons.search, size: 24.0, color: Colors.black54),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none, // Removes the border side
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child:
            Text("Plant Picks for You", style: Theme.of(context).textTheme.headlineSmall,),
          ),
          // List of plants
          Container(
            height: MediaQuery.of(context).size.height * 30,
            child: PlantsGridView(),
          ),
        ],
      );
  }

}