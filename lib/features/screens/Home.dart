import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenmate/features/screens/Dashboard.dart';
import 'package:greenmate/features/screens/EcoGuide.dart';
import 'package:greenmate/features/screens/MyPlants.dart';
import 'package:greenmate/features/screens/Profile.dart';
import 'package:greenmate/features/screens/Tutorial.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int currentTab = 0;
  final List<Widget> screens = [
    Dashboard(),
    MyPlants(),
    Profile(),
    Tutorial(),
    EcoGuide()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Dashboard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(
          side: BorderSide(color: Colors.white, width: 3.0, style: BorderStyle.solid)
        ),
        onPressed: (){}, // ini redirect ke kamera
        backgroundColor: Colors.lightGreen[100],
        child: SvgPicture.asset('assets/icons/Camera_icon.svg',
        width: 27,
        height: 27,
        ),
        elevation: 0,
      ),

      bottomNavigationBar: BottomAppBar(
        notchMargin: 5.0,
        shape: CircularNotchedRectangle(),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget> [
            // Home
            MaterialButton(
              minWidth: 50,
              padding: EdgeInsets.zero,
              onPressed: (){
                setState(() {
                  currentScreen = Dashboard();
                  currentTab = 0;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('assets/icons/Home_icon.svg',
                    width: 27,
                    height: 27,
                    color: currentTab == 0 ? Colors.green[800] : Colors.grey,
                  ),
                  Text(
                    "Home",
                    style: TextStyle(color: currentTab == 0 ? Colors.green[800] : Colors.grey ,
                    fontSize: 12),
                  )
                ],
              ),
            ),

            // MyPlants
            MaterialButton(
              minWidth: 50,
              padding: EdgeInsets.only(right: 3.0),
              onPressed: (){
                setState(() {
                  currentScreen = MyPlants();
                  currentTab = 1;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('assets/icons/MyPlants_icon.svg',
                    width: 27,
                    height: 27,
                    color: currentTab == 1 ? Colors.green[800] : Colors.grey,
                  ),
                  Text(
                    "MyPlants",
                    style: TextStyle(color: currentTab == 1 ? Colors.green[800] : Colors.grey , fontSize: 12),
                  )
                ],
              ),
            ),
            // EcoGuide
            MaterialButton(
              minWidth: 50,
              padding: EdgeInsets.only(left: 3.0),
              onPressed: (){
                setState(() {
                  currentScreen = EcoGuide();
                  currentTab = 2;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('assets/icons/GreenGuru_icon.svg',
                    width: 27,
                    height: 27,
                    color: currentTab == 2 ? Colors.green[800] : Colors.grey,
                  ),
                  Text(
                    "EcoGuide",
                    style: TextStyle(color: currentTab == 2 ? Colors.green[800] : Colors.grey, fontSize: 12),
                  )
                ],
              ),
            ),
            // Profile
            MaterialButton(
              minWidth: 50,
              padding: EdgeInsets.zero,
              onPressed: (){
                setState(() {
                  currentScreen = Profile();
                  currentTab = 3;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('assets/icons/Profile_icon.svg',
                    width: 27,
                    height: 27,
                    color: currentTab == 3 ? Colors.green[800] : Colors.grey,
                  ),
                  Text(
                    "Profile",
                    style: TextStyle(color: currentTab == 3 ? Colors.green[800] : Colors.grey, fontSize: 12),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}