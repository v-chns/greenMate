import 'package:flutter/material.dart';
import 'package:greenmate/features/models/Plant.dart';

class PlantAbout extends StatefulWidget {
  final Plant result;
  const PlantAbout({Key? key, required this.result}) : super(key: key);

  @override
  State<PlantAbout> createState() => _PlantCareState();
}

class _PlantCareState extends State<PlantAbout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Card(
            elevation: 4.0,
            color: Colors.green.shade800.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              children: [
                // bg color overlay
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                // bgimage
                ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  child: Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage("assets/images/dummyplant.jpg"),
                        fit: BoxFit.none,
                        opacity: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                // content
                Container(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Monstera, or Monstera deliciosa, is a trendy tropical plant with iconic perforated leaves native to Central America. Its adaptable nature and unique, glossy foliage have made it a popular and low-maintenance choice for indoor decor, earning it the nickname "Swiss cheese plant" among enthusiasts worldwide.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
