import 'package:flutter/material.dart';
import 'package:greenmate/common/widgets/MyPlantWidget.dart';
import 'package:greenmate/features/models/MyPlant.dart';
import 'package:greenmate/features/models/Plant.dart';

class MyPlants extends StatefulWidget {
  // final List<Plant> plants = <Plant>[
  //   new Plant(
  //       plantClass: "Aglaonema",
  //       name: "Aglaonema",
  //       latinName: "Aglaonema",
  //       family: "Aglaonema",
  //       kingdom: "Aglaonema",
  //       maintenance: [
  //         new Maintenance(type: "Aglaonema", description: "Aglaonema"),
  //         new Maintenance(type: "Aglaonema", description: "Aglaonema")
  //       ], defaultImage: "temp"),
  //   new Plant(
  //       plantClass: "Aglaonema",
  //       name: "Aglaonema",
  //       latinName: "Aglaonema",
  //       family: "Aglaonema",
  //       kingdom: "Aglaonema",
  //       maintenance: [
  //         new Maintenance(type: "Aglaonema", description: "Aglaonema"),
  //         new Maintenance(type: "Aglaonema", description: "Aglaonema")
  //       ], defaultImage: "temp")
  // ];

  final List<Plant> plants = MyPlant.myPlants;

  @override
  _MyPlantsState createState() => _MyPlantsState();
}

class _MyPlantsState extends State<MyPlants> {
  List<Plant> myplants = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      myplants = widget.plants;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('My Plants')),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(child: Text(
                'My Plants',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),),
                Tab(child: Text(
                  'Saved Tutorials',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),)
              ],
                indicatorColor: Colors.amber,
                indicatorWeight: 5.0,
                indicatorSize: TabBarIndicatorSize.label
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "MyPlants",
                style: Theme.of(context).textTheme.titleLarge
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
                            latinName: widget.plants[index].latinName,
                            image: widget.plants[index].userImage),
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
