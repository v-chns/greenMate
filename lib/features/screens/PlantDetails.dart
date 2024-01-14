import 'dart:io';

import 'package:flutter/material.dart';
import 'package:greenmate/common/widgets/PlantOverview.dart';
import 'package:greenmate/common/widgets/PlantTutorial.dart';
import 'package:greenmate/data/services/GetPlantsList.dart';
import 'package:greenmate/data/services/NetworkImageDownloader.dart';
import 'package:greenmate/data/services/PlantSqlLiteService.dart';
import 'package:greenmate/features/models/MyPlant.dart';
import 'package:greenmate/features/models/Plant.dart';
import 'package:greenmate/features/screens/Dashboard.dart';
import 'package:image_picker/image_picker.dart';

class PlantDetails extends StatefulWidget {
  final Plant result;
  final XFile? image;

  const PlantDetails({Key? key, required this.result, this.image})
      : super(key: key);

  @override
  State<PlantDetails> createState() => _PlantDetailsState();
}

class _PlantDetailsState extends State<PlantDetails> {
  int currentTab = 0;
  late Widget currentScreen;
  final PageStorageBucket bucket = PageStorageBucket();
  bool isBookmarked = false;
  late final String imgUrl;
  XFile? localImage;

  @override
  void initState() {
    super.initState();
    currentScreen = PlantOverview(result: widget.result);
    imgUrl = widget.result.defaultImage;
    if (widget.image != null) {
      localImage = widget.image!;
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
            height: MediaQuery.of(context).size.height * 0.27,
            decoration: localImage == null
                ? BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imgUrl),
                      fit: BoxFit.cover,
                    ),
                  )
                : BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(File(localImage!.path)),
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

          // Bookmark button
          Positioned(
            top: 30,
            right: 20.0,
            child: IconButton(
              icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_add_outlined,
                  color: Colors.white,
                  size: 30.0),
              onPressed: () {
                // Handle bookmark
                setState(() {
                  isBookmarked = !isBookmarked;
                });
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
                        'Overview',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Tutorial',
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
                        PlantOverview(result: widget.result),
                        PlantTutorial(result: widget.result),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Add Plant Button
        widget.result.userPlantId == 0 ? 
        Positioned(
          bottom: 0,
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 100)),
                onPressed: () async {
                  // Handle button press
                  if (localImage == null) {
                    // final imageStream = NetworkImage(widget.result.defaultImage);
                    // final imgStream = await imageStream.resolve(ImageConfiguration.empty);
                    //  final byteData = await imageStream.loadImage(key, (buffer, {getTargetSize}) => null);
                    // final bytes = byteData!.buffer.asUint8List();
                    XFile netImage =
                        await NetworkImageDownloader.getImageXFileByUrl(
                            widget.result.defaultImage);
                    PlantSqlLiteService plantSqlLiteService =
                        PlantSqlLiteService();
                    await plantSqlLiteService.addPlantToLocalDB(
                        widget.result, netImage);
                        MyPlant.myPlants = await PlantSqlLiteService().getMyPlants();
                        // GetPlantsList getPlantsList = GetPlantsList();
                        // allPlants = await getPlantsList.getAllPlants();
                  } else {
                    PlantSqlLiteService plantSqlLiteService =
                        PlantSqlLiteService();
                    await plantSqlLiteService.addPlantToLocalDB(
                        widget.result, localImage!);
                  }
                },
                child: Text('Add Plant'),
              ),
            ),
          ),
        ) : Container(),
      ],
    ));
  }
}
