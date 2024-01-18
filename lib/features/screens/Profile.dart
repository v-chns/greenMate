import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenmate/common/widgets/HomeCalendarWidget.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title:
      Text('Profile', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black),
      )
      ),
      body:Padding(
        padding: const EdgeInsets.all(20.0), // Add padding to the entire column
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Green circle with white SVG and user's name
            Row(
              children: [
                Container(
                  width: 45, // Adjust the size of the circle as needed
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF128750),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/Profile_icon.svg',
                      width: 27,
                      height: 27,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  'Guest',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            SizedBox(height: 16),
            // Divider line
            // Divider(thickness: 1, color: Colors.grey),
            // Buttons with slight lines
            buildButton('Saved tutorials'),
            buildButton('Support'),
            buildButton('About us'),
            buildButton('FAQ'),
            buildButton('Settings'),
            buildButton('Clear Cache'),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String buttonText) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey, width: 0.5),
          bottom: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      child: MaterialButton(
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              buttonText,
              style: buttonText == "Clear Cache" ? Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red) : Theme.of(context).textTheme.bodyMedium ,
            ),
          ),
        ),
      ),

    );
  }
}