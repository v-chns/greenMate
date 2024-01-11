import 'package:flutter/material.dart';
import 'package:greenmate/common/widgets/PlantOverview.dart';
import 'package:greenmate/common/widgets/PlantTutorial.dart';
import 'package:greenmate/features/models/Plant.dart';

class PlantDetails extends StatefulWidget {
  final Plant result;
  const PlantDetails({Key? key, required this.result}) : super(key: key);

  @override
  State<PlantDetails> createState() => _PlantDetailsState();
}

class _PlantDetailsState extends State<PlantDetails> {
  int currentTab = 0;
  late Widget currentScreen;
  final PageStorageBucket bucket = PageStorageBucket();
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    currentScreen = PlantOverview(result: widget.result);
    print(widget.result.maintenance);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column (
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.27,
                decoration:
                const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/dummyplant.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Custom back button
              Positioned(
                top: 30.0,
                left: 20.0,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 24.0),
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
            ]
          ),

          // Plant names
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('${widget.result.name}', style: Theme.of(context).textTheme.headlineSmall,),
                  SizedBox(height: 3,),
                  Text('${widget.result.latinName}', style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),),
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
                      height: MediaQuery.of(context).size.height - 0, // Adjust someValue
                      padding: EdgeInsets.all(20.0),
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
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 85)),
                  onPressed: () {
                    // Handle button press
                  },
                  child: Text('Add Plant'),
                ),
              ),
            ),
          ),

        ],
      )

    );
  }
}
