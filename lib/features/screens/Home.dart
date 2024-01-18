import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenmate/features/screens/Dashboard.dart';
import 'package:greenmate/features/screens/EcoGuide.dart';
import 'package:greenmate/features/screens/MyPlants.dart';
import 'package:greenmate/features/screens/Profile.dart';
import 'package:greenmate/features/screens/Tutorial.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  final int currentTab;

  const Home({Key? key, this.currentTab = 0}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int currentTab = 0;

  @override
  void initState() {
    super.initState();
    currentTab = widget.currentTab;
  }

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
        bucket: bucket,
        child: currentScreen,
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 65,
        height: 65,
        child: FloatingActionButton(
          heroTag: 'Tutorial',
          shape: const CircleBorder(
            side: BorderSide(color: Colors.white, width: 3.0, style: BorderStyle.solid),
          ),
          onPressed: () => Get.toNamed('/tutorial'), // Redirect to camera
          backgroundColor: Colors.lightGreen[100],
          elevation: 0,
          child: SvgPicture.asset(
            'assets/icons/Camera_icon.svg',
            width: 33, // Adjust the width of the icon inside the button
            height: 33, // Adjust the height of the icon inside the button
          ),
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        notchMargin: 5.0,
        shape: const CircularNotchedRectangle(),
        color: Colors.white,
        elevation: 1,
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
                    color: currentTab == 0 ? Color(0xFF128750) : Colors.grey,
                  ),
                  Text(
                    "Home",
                    style: TextStyle(color: currentTab == 0 ? Color(0xFF128750) : Colors.grey ,
                    fontSize: 13, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),

            // MyPlants
            MaterialButton(
              minWidth: 50,
              padding: const EdgeInsets.only(right: 3.0),
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
                    color: currentTab == 1 ? Color(0xFF128750) : Colors.grey,
                  ),
                  Text(
                    "MyPlants",
                    style: TextStyle(color: currentTab == 1 ? Color(0xFF128750) : Colors.grey , fontSize: 13, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            // EcoGuide
            MaterialButton(
              minWidth: 50,
              padding: const EdgeInsets.only(left: 3.0),
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
                    color: currentTab == 2 ? Color(0xFF128750) : Colors.grey,
                  ),
                  Text(
                    "EcoGuide",
                    style: TextStyle(color: currentTab == 2 ? Color(0xFF128750) : Colors.grey, fontSize: 13, fontWeight: FontWeight.w500),
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
                    color: currentTab == 3 ? Color(0xFF128750) : Colors.grey,
                  ),
                  Text(
                    "Profile",
                    style: TextStyle(color: currentTab == 3 ? Color(0xFF128750) : Colors.grey, fontSize: 13, fontWeight: FontWeight.w500),
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