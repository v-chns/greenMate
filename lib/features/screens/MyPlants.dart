import 'package:flutter/material.dart';
import 'package:greenmate/common/widgets/MyPlantWidget.dart';
import 'package:greenmate/features/models/Plant.dart';

class MyPlants extends StatefulWidget {
  final List<Plant> plants = <Plant>[
    new Plant(
        plantClass: "Aglaonema",
        name: "Aglaonema",
        latinName: "Aglaonema",
        family: "Aglaonema",
        kingdom: "Aglaonema",
        maintenance: [
          new Maintenance(type: "Aglaonema", description: "Aglaonema"),
          new Maintenance(type: "Aglaonema", description: "Aglaonema")
        ]),
    new Plant(
        plantClass: "Aglaonema",
        name: "Aglaonema",
        latinName: "Aglaonema",
        family: "Aglaonema",
        kingdom: "Aglaonema",
        maintenance: [
          new Maintenance(type: "Aglaonema", description: "Aglaonema"),
          new Maintenance(type: "Aglaonema", description: "Aglaonema")
        ])
  ];

  @override
  _MyPlantsState createState() => _MyPlantsState();
}

class _MyPlantsState extends State<MyPlants> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('My Plants')),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [Tab(text: "My Plants"), Tab(text: "Saved Tutorials")],
            ),
            title: const Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "MyPlant",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
          body: Padding(
              padding: const EdgeInsets.all(20),
              child: TabBarView(
                children: [
                  ListView.builder(
                    itemCount: widget.plants.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: MyPlantWidget(
                            name: widget.plants[index].name,
                            action: widget.plants[index].kingdom,
                            latinName: widget.plants[index].latinName),
                      );
                    },
                  ),
                  Text("Ini saved tutorials")
                ],
              )),
        ),
      ),
    );
  }
}
