import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  void updateResultText(String newText) {
    setState(() {
      resultText = newText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: EdgeInsets.only(top: 15.0),
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
          // hasil image detection
          Padding(
            padding: resultText.isEmpty ? EdgeInsets.zero : EdgeInsets.all(20.0),
            child: Text(resultText, style: Theme.of(context).textTheme.headlineMedium,), // Display the result text
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search plants...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child:
            Text("Plant Picks for You", style: Theme.of(context).textTheme.headlineMedium,),
          ),
          // List of plants
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: [
                // First Column
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        _buildPlantContainer('Plant 1', 'Snake Plant', 'assets/images/plant_dummy.jpg'),
                        _buildPlantContainer('Plant 2', 'Fiddle Leaf Fig', 'assets/images/plant_dummy.jpg'),
                        // Add more plants as needed
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16.0), // Spacer between columns
                // Second Column
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        _buildPlantContainer('Plant 3', 'Spider Plant', 'assets/images/plant_dummy.jpg'),
                        _buildPlantContainer('Plant 4', 'Monstera', 'assets/images/plant_dummy.jpg'),
                        // Add more plants as needed
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      );
  }

}

Widget _buildPlantContainer(String plantName, String plantClassName, String imagePath) {
  return Container(
    margin: EdgeInsets.only(bottom: 16.0),
    child: Row(
      children: [
        Container(
          height: 80.0, // Adjust the height of the picture container as needed
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Column(
          children: [
            Text(plantName, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Text(plantClassName, style: TextStyle(fontSize: 14.0)),
          ],
        ),

      ],
    ),
  );
}