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
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                "assets/images/dummyplant.jpg",
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.8),
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),
          // Content
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(0),
              child: Card(
                elevation: 4.0,
                color: Colors.green.shade900.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}