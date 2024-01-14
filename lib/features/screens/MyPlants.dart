import 'package:flutter/material.dart';
import 'package:greenmate/common/widgets/MyPlantWidget.dart';
import 'package:greenmate/data/services/PlantSqlListService.dart';
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
    // print("babi init");
    super.initState();
    setState(() {
      myplants = widget.plants;
    });
  }

  bool _shouldRefresh = false;

  // Function to trigger a refresh
  void _triggerRefresh() {
    setState(() {
      _shouldRefresh = true;
    });
  }

  // Function to handle the refresh
  Future<void> _handleRefresh() async {
    // Your refresh logic here
    // await Future.delayed(Duration(seconds: 2));
    List<Plant> temp = await PlantSqlLiteService().getMyPlants();
    // Reset the variable after refreshing
    setState(() {
      _shouldRefresh = false;
      myplants = temp;
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
                  Tab(
                    child: Text(
                      'My Plants',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Saved Tutorials',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  )
                ],
                indicatorColor: Colors.amber,
                indicatorWeight: 5.0,
                indicatorSize: TabBarIndicatorSize.label),
            title: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("MyPlants",
                  style: Theme.of(context).textTheme.titleLarge),
            ),
          ),
          body: Padding(
              padding: const EdgeInsets.all(20),
              child: TabBarView(
                children: [
                  RefreshIndicator(
                      child: _shouldRefresh
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              itemCount: myplants.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: MyPlantWidget(
                                      activePlant: myplants[index],
                                      callBackFunc: ()async{
                                        _triggerRefresh();
                                        await _handleRefresh();
                                      }
                                      ),
                                );
                              },
                            ),
                      onRefresh: _handleRefresh),
                  Text("Ini saved tutorials")
                ],
              )),
        ),
      ),
    );
  }
}
