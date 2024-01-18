import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:greenmate/common/widgets/Calendar.dart';
import 'package:greenmate/common/widgets/HomeCalendarWidget.dart';
import 'package:greenmate/common/widgets/PlantCarouselItemWidget.dart';
import 'package:greenmate/data/services/GetPlantsList.dart';
import 'package:greenmate/features/models/Plant.dart';
import 'package:loading_indicator/loading_indicator.dart';

List<Plant> allPlants = [];

class Dashboard extends StatefulWidget {
  // List<Plant> plants = [];

  Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<Plant> plants = [];

  @override
  void initState() {
    super.initState();
    if (allPlants.isEmpty) {
      _triggerRefresh();
    } else {
      setState(() {
        plants.addAll(allPlants);
      });
    }
  }

  bool _shouldRefresh = false;

  // Function to trigger a refresh
  void _triggerRefresh() async {
    setState(() {
      _shouldRefresh = true;
    });
    await _handleRefresh();
  }

  // Function to handle the refresh
  Future<void> _handleRefresh() async {
    List<Plant> temp = await GetPlantsList().getAllPlants();
    // Your refresh logic here
    setState(() {
      plants.addAll(temp);
      allPlants.addAll(temp);
    });

    // Reset the variable after refreshing
    setState(() {
      _shouldRefresh = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String getGreeting() {
      var hour = DateTime.now().hour;

      if (hour >= 6 && hour < 12) {
        return "Good Morning ⛅";
      } else if (hour >= 12 && hour < 18) {
        return "Good Afternoon 🌅";
      } else if (hour >= 18 && hour < 22) {
        return "Good Evening 🌆";
      } else {
        return "Good Night 🌙";
      }
    }

    return Scaffold(
        // appBar: AppBar(
        //   title: Text(""),
        // ),
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      getGreeting(),
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Card(
                    elevation: 4.0,
                    color: Colors.green.shade800,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Stack(
                      children: [
                        // bg color overlay
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        // bgimage
                        Container(
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/images/dummyplant.jpg"),
                                  fit: BoxFit.none,
                                  opacity: 0.3),
                              // color: Colors.black,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        //content
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Your Carbon Savings",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "56.7",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "kg CO2",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.normal),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              Text(
                                "Daily Absorption Rate : 2.3 kg CO2/day",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Text("To-do List",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Calendar(),
                  const SizedBox(height: 20.0),
                  const Text("Plant Recommendation For You",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20.0),
                  RefreshIndicator(
                      child: _shouldRefresh
                          ? Container(
                              child: Center(
                                child: LoadingIndicator(
                                    indicatorType: Indicator.lineScaleParty),
                              ),
                              height: 100,
                            )
                          : CarouselSlider.builder(
                              itemCount: plants.length,
                              itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) {
                                return PlantCarouselItemWidget(
                                    plant: plants[itemIndex]);
                              },
                              options: CarouselOptions(
                                // height: 200,
                                aspectRatio: 16 / 9,
                                viewportFraction: 0.5,
                                initialPage:
                                    0 + Random().nextInt(plants.length - 0 + 0),
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                enlargeFactor: 0.3,
                                // onPageChanged: callbackFunction,
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                      onRefresh: _handleRefresh)
                ],
              ))
            ],
          ),
        ),
      ),
    ));
  }
}
