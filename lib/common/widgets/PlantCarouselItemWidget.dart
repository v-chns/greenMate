import 'package:flutter/material.dart';
import 'package:greenmate/features/models/Plant.dart';

class PlantCarouselItemWidget extends StatefulWidget {
  final Plant plant;

  PlantCarouselItemWidget({required this.plant});

  @override
  _PlantCarouselItemWidget createState() => _PlantCarouselItemWidget();
}

class _PlantCarouselItemWidget extends State<PlantCarouselItemWidget> {
  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      maxHeight: double.infinity,
      maxWidth: double.infinity,
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    "assets/images/plant_dummy.jpg",
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
                  widget.plant.name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(widget.plant.latinName,
                    style: const TextStyle(
                        fontSize: 16, fontStyle: FontStyle.italic))
              ]),
            )
          ],
        ));
  }
}
