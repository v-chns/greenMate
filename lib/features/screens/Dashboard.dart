import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:greenmate/common/widgets/Calendar.dart';
import 'package:greenmate/common/widgets/HomeCalendarWidget.dart';
import 'package:greenmate/common/widgets/PlantCarouselItemWidget.dart';
import 'package:greenmate/features/models/Plant.dart';

late List<Plant> allPlants;

class Dashboard extends StatefulWidget {
  final List<Plant> plants = allPlants;

  Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<Plant> plants = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      plants.addAll(widget.plants);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text(""),
        // ),
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      "Good Morning",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
                                  fit: BoxFit.cover,
                                  opacity: 0.3),
                              // color: Colors.black,
                              borderRadius: BorderRadius.circular(15)),
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
                  const Text("Todo-List",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Calendar(),
                  const SizedBox(height: 20.0),
                  const Text("Plant Recommendation For You",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  CarouselSlider.builder(
                    itemCount: plants.length,
                    itemBuilder: (BuildContext context, int itemIndex,
                        int pageViewIndex) {
                      return PlantCarouselItemWidget(plant: plants[itemIndex]);
                    },
                    options: CarouselOptions(
                      // height: 200,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.5,
                      initialPage: 0 + Random().nextInt(plants.length - 0 + 0),
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      // onPageChanged: callbackFunction,
                      scrollDirection: Axis.horizontal,

                    ),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    ));
  }
}
