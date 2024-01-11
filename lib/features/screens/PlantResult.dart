import 'dart:io';

import 'package:flutter/material.dart';
import 'package:greenmate/common/widgets/ResultPanelWidget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PlantResult extends StatefulWidget {
  final String path;
  const PlantResult({Key? key, required this.path}) : super(key: key);

  @override
  _PlantResult createState() => _PlantResult();
}

class _PlantResult extends State<PlantResult> {


  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SlidingUpPanel(
        minHeight: MediaQuery.of(context).size.height * 0.3,
        maxHeight: MediaQuery.of(context).size.height,
        parallaxEnabled: true,
        parallaxOffset: 0.5,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
        panelBuilder: (controller) => ResultPanelWidget(
        controller: controller,
        path: widget.path,),
        body: Stack(
            children: [
              // Hasil foto
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height * 0.2,
                child: Image.file(
                  File(widget.path),
                  fit: BoxFit.cover,
                ) ,
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
          ],
        ),
      ),
    );
  }
}