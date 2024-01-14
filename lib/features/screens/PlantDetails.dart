import 'dart:io';

import 'package:flutter/material.dart';
import 'package:greenmate/common/widgets/PlantOverview.dart';
import 'package:greenmate/common/widgets/PlantTutorial.dart';
import 'package:greenmate/data/services/GetPlantsList.dart';
import 'package:greenmate/data/services/TutorialSqlLiteService.dart';
import 'package:greenmate/data/services/NetworkImageDownloader.dart';
import 'package:greenmate/data/services/PlantSqlLiteService.dart';
import 'package:greenmate/features/models/MyPlant.dart';
import 'package:greenmate/features/models/MyTutorial.dart';
import 'package:greenmate/features/models/Plant.dart';
import 'package:greenmate/features/screens/Dashboard.dart';
import 'package:greenmate/features/screens/MyPlants.dart';
import 'package:image_picker/image_picker.dart';

class PlantDetails extends StatefulWidget {
  final Plant result;
  final XFile? image;

  const PlantDetails({Key? key, required this.result, this.image})
      : super(key: key);

  @override
  State<PlantDetails> createState() => _PlantDetailsState();
}

class _PlantDetailsState extends State<PlantDetails>
    with SingleTickerProviderStateMixin {
  int currentTab = 0;
  late Widget currentScreen;
  final PageStorageBucket bucket = PageStorageBucket();
  bool isBookmarked = false;
  late final String imgUrl;
  XFile? localImage;
  bool activePage = false;
  late TabController _tabController;
  bool isTutorialGenerated = false;
  String activeTutorial = "";

  @override
  void initState() {
    super.initState();
    currentScreen = PlantOverview(result: widget.result);
    imgUrl = widget.result.defaultImage;
    if (widget.image != null) {
      localImage = widget.image!;
    }

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if(_tabController.index==0){
        setState(() {
          activePage = false;
        });
      }
      else if(_tabController.index==1){
        setState(() {
          activePage = true;
        });
      }
    });

    // print(widget.result.maintenance);
  }

  @override
  void dispose() {
    // Dispose of the TabController when the widget is disposed
    _tabController.dispose();
    super.dispose();
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
          // Positioned(
          //   top: 30,
          //   right: 20.0,
          //   child: IconButton(
          //     icon: Icon(
          //         isBookmarked ? Icons.bookmark : Icons.bookmark_add_outlined,
          //         color: Colors.white,
          //         size: 30.0),
          //     onPressed: ()
          //         // Handle bookmark -> ini buat save tutorials
          //         async {
          //       if (!isBookmarked) {
          //         TutorialSqlLiteService tutorialService =
          //             TutorialSqlLiteService();
          //         await tutorialService.addTutorialToLocalDB(widget.result);
          //         MyTutorial.myTutorials =
          //             await TutorialSqlLiteService().getMyTutorials();
          //       } else {
          //         TutorialSqlLiteService tutorialService =
          //             TutorialSqlLiteService();
          //         await tutorialService
          //             .deleteTutorial(widget.result.userTutorialId);
          //         MyTutorial.myTutorials =
          //             await TutorialSqlLiteService().getMyTutorials();
          //       }
          //       setState(() {
          //         isBookmarked = !isBookmarked;
          //       });
          //     },
          //   ),
          // ),
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
                TabBar(
                  controller: _tabController,
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
                      controller: _tabController,
                      children: [
                        PlantOverview(result: widget.result),
                        PlantTutorial(result: widget.result, callBackFunc: (res){
                          setState(() {
                            isTutorialGenerated = true;
                            activeTutorial = res;
                          });
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Add Plant Button
        widget.result.userPlantId == 0
            ? !activePage
                ? Positioned(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 115)),
                          onPressed: () async {
                            // Handle button press
                            if (localImage == null) {
                              // final imageStream = NetworkImage(widget.result.defaultImage);
                              // final imgStream = await imageStream.resolve(ImageConfiguration.empty);
                              //  final byteData = await imageStream.loadImage(key, (buffer, {getTargetSize}) => null);
                              // final bytes = byteData!.buffer.asUint8List();
                              XFile netImage = await NetworkImageDownloader
                                  .getImageXFileByUrl(
                                      widget.result.defaultImage);
                              PlantSqlLiteService plantSqlLiteService =
                                  PlantSqlLiteService();
                              await plantSqlLiteService.addPlantToLocalDB(
                                  widget.result, netImage);
                              MyPlant.myPlants =
                                  await PlantSqlLiteService().getMyPlants();
                              // GetPlantsList getPlantsList = GetPlantsList();
                              // allPlants = await getPlantsList.getAllPlants();
                            } else {
                              PlantSqlLiteService plantSqlLiteService =
                                  PlantSqlLiteService();
                              await plantSqlLiteService.addPlantToLocalDB(
                                  widget.result, localImage!);
                            }
                            await showConfirmationDialog(context);
                          },
                          child: Text('Add Plant'),
                        ),
                      ),
                    ),
                  )
                : isTutorialGenerated ? Positioned(
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
                              backgroundColor: Colors.yellow.shade700,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 115)),
                          onPressed: () async {
                            TutorialSqlLiteService tutorialService =
                                TutorialSqlLiteService();
                            await tutorialService
                                .addTutorialToLocalDB(widget.result, activeTutorial);
                            MyTutorial.myTutorials =
                                await TutorialSqlLiteService().getMyTutorials();
                          },
                          child: Text(
                            'Save Tutorial',
                            style: TextStyle(color: Colors.green.shade900),
                          ),
                        ),
                      ),
                    ),
                  ) : Container()
            : Container(),
      ],
    ));
  }

  Future<void> showConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/myplants.png', height: 120),
                SizedBox(height: 10),
                Text('Happy Planting!',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.amber),
                    textAlign: TextAlign.center),
                SizedBox(height: 10),
                Text(
                  'Your plant has been added to MyGreen.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyPlants()),
                    );
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
