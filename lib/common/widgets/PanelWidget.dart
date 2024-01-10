import 'package:flutter/material.dart';

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

  final List<Map<String, String>> plantData = [
    {
      'name': 'Plant 1',
      'class': 'Class A',
      'imagePath': 'assets/images/dummyplant.jpg',
    },
    {
      'name': 'Plant 2',
      'class': 'Class B',
      'imagePath': 'assets/images/dummyplant.jpg',
    },
    // Add more plant data as needed
  ];



  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0, bottom: 20.0),
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
            padding: resultText.isEmpty ? EdgeInsets.zero : EdgeInsets.all(20.0),
            child: Text(resultText, style: Theme.of(context).textTheme.headlineMedium,), // Display the result text
          ),
          Container(
            child: TextField(
              style: Theme.of(context).textTheme.titleLarge,
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
          Padding(
            padding: EdgeInsets.zero,
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                _buildPlantContainer("coba coba", "cobalicus ancu", "assets/images/dummyplant.jpg", context),
                _buildPlantContainer("coba coba", "cobalicus ancu", "assets/images/dummyplant.jpg", context),
                _buildPlantContainer("coba coba", "cobalicus ancu", "assets/images/dummyplant.jpg", context),
                _buildPlantContainer("coba coba", "cobalicus ancu", "assets/images/dummyplant.jpg", context),
                _buildPlantContainer("coba coba", "cobalicus ancu", "assets/images/dummyplant.jpg", context),
                _buildPlantContainer("coba coba", "cobalicus ancu", "assets/images/dummyplant.jpg", context),
                _buildPlantContainer("coba coba", "cobalicus ancu", "assets/images/dummyplant.jpg", context),
                _buildPlantContainer("coba coba", "cobalicus ancu", "assets/images/dummyplant.jpg", context),
                _buildPlantContainer("coba coba", "cobalicus ancu", "assets/images/dummyplant.jpg", context),
                _buildPlantContainer("coba coba", "cobalicus ancu", "assets/images/dummyplant.jpg", context),
              ],
            ),
          ),
        ],
      );
  }

}

Widget _buildPlantContainer(String plantName, String plantClassName, String imagePath, BuildContext context) {
  return Container(
    child: Column(
      children: [
        Container(
          height: 116.0,
          width: 170,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 5.0),
        Container(
          width: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  plantName,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 1.0),
              Container(
                child: Text(
                  plantClassName,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),

      ],
    ),
  );
}