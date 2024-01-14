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
        child: MaterialButton(
          onPressed: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      activePlant.defaultImage,
                      width: 160,
                      height: 110,
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
                    activePlant.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(
                      activePlant.latinName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 15, fontStyle: FontStyle.italic))
                ]),
              )
            ],
          ),
        ));
  }
}
