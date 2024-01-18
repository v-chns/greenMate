import 'dart:io';

import 'package:flutter/material.dart';
import 'package:greenmate/common/widgets/PlantOverview.dart';
import 'package:greenmate/common/widgets/PlantTutorial.dart';
import 'package:greenmate/data/services/NetworkImageDownloader.dart';
import 'package:greenmate/data/services/PlantSqlLiteService.dart';
import 'package:greenmate/features/models/MyPlant.dart';
import 'package:greenmate/features/models/Plant.dart';
import 'package:greenmate/features/screens/PlantAbout.dart';
import 'package:greenmate/features/screens/PlantCare.dart';
import 'package:image_picker/image_picker.dart';

class MyPlantsDetails extends StatefulWidget {
  final Plant result;
  final XFile? image;

  const MyPlantsDetails({Key? key, required this.result, this.image})
      : super(key: key);

  @override
  State<MyPlantsDetails> createState() => _PlantDetailsState();
}

class _PlantDetailsState extends State<MyPlantsDetails> {
  int currentTab = 0;
  late Widget currentScreen;
  final PageStorageBucket bucket = PageStorageBucket();
  late final String imgUrl;
  XFile? localImage;
  late String imagePath;

  @override
  void initState() {
    super.initState();
    currentScreen = PlantAbout(result: widget.result);
    imgUrl = widget.result.defaultImage;
    if (widget.result.userImage != "") {
      imagePath = widget.result.userImage;
    }

    // print(widget.result.maintenance);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Stack(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: widget.result.userImage == ""
                    ? BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imgUrl),
                    fit: BoxFit.cover,
                  ),
                )
                    : BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(File(imagePath)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Custom back button
              Positioned(
                top: 30.0,
                left: 20.0,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios,
                      color: Colors.white, size: 24.0),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ]),

            // Plant names
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.result.name}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      '${widget.result.latinName}',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Tabs
            Expanded(
              child: DefaultTabController(
                length: 2,
                initialIndex: 0,
                child: Column(
                  children: [
                    const TabBar(
                      tabs: [
                        Tab(
                          child: Text(
                            'About',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Care Schedule',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                      indicatorColor: Colors.amber,
                      indicatorWeight: 5.0,
                      indicatorSize: TabBarIndicatorSize.label,
                    ),
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height -
                            0, // Adjust someValue
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 0),
                        child: TabBarView(
                          children: [
                            PlantAbout(result: widget.result),
                            PlantCare(result: widget.result),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ));
  }
}
