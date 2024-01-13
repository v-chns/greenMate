import 'package:flutter/material.dart';
import 'package:greenmate/features/models/Plant.dart';
import 'package:greenmate/features/screens/PlantDetails.dart';

class PlantCarouselItemWidget extends StatefulWidget {
  final Plant plant;

  PlantCarouselItemWidget({required this.plant});

  @override
  _PlantCarouselItemWidget createState() => _PlantCarouselItemWidget();
}

class _PlantCarouselItemWidget extends State<PlantCarouselItemWidget> {
  late final Plant activePlant;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      activePlant = widget.plant;
    });
  }

  void onTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PlantDetails(result: activePlant)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
        maxHeight: double.infinity,
        // maxWidth: double.infinity,
        child: GestureDetector(
          onTap: onTap,
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      activePlant.defaultImage,
                      width: 140,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Positioned(
                      top: 10.0,
                      right: 10.0,
                      child: Icon(Icons.bookmark_outline, color: Colors.white))
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(children: [
                  Text(
                    activePlant.name.length > 15 ? activePlant.name.substring(0, 15 - 3) + '...' : activePlant.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(activePlant.latinName.length > 15 ? activePlant.latinName.substring(0, 15 - 3) + '...' : activePlant.latinName,
                  textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 16, fontStyle: FontStyle.italic))
                ]),
              )
            ],
          ),
        ));
  }
}
