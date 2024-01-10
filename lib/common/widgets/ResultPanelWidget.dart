import 'package:flutter/material.dart';
import 'package:greenmate/data/services/PlantDetectionService.dart';
import 'package:greenmate/features/models/Plant.dart';

class ResultPanelWidget extends StatefulWidget {
  final ScrollController controller;
  final String path;

  const ResultPanelWidget({
    Key? key,
    required this.controller,
    required this.path,
  }) : super(key: key);

  @override
  _ResultPanelWidgetState createState() => _ResultPanelWidgetState();

}

class _ResultPanelWidgetState extends State<ResultPanelWidget>{
  late Plant? _result;
  bool _isDisposed = false;
  bool _isLoading = true;


  @override
  void initState() {
    super.initState();
    _loadResult();
  }

  // @override
  // void dispose() {
  //   _isDisposed = true;
  //   super.dispose();
  // }

  Future<void> _loadResult() async {
    _result = await PlantDetectionService.detectPlant(widget.path);
      setState(() {
        _isLoading = false;
      });
  }


  @override
  Widget build(BuildContext context) {
    return _isLoading ?
    Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
      Padding(
        padding: EdgeInsets.only(top: 25.0), // Adjust the value as needed
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen.shade400),
          ),
        ),
      ),
    ]
    )
        : ListView(
      padding: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0, bottom: 20.0),
      controller: widget.controller,
      children:  [
        // Drag handler (garis abu)
        Center(
        child: Container(
          width: 80,
          height: 5,
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        // Plant detection result
        if (_result == null) ...[
          // if (!_isDisposed) ...[
          //   CircularProgressIndicator(), // Loading state
          // ],
          Expanded(
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.red.shade100,
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: 15.0),
                  SizedBox(width: 3.5),
                  Text(
                    'Plant Not Found',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
        ] else ...[
          PlantInfoContainer(result: _result!),
        ],
      ],
    );
  }
}

class PlantInfoContainer extends StatelessWidget {
  final Plant result;

  const PlantInfoContainer({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade100),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset('assets/images/dummyplant.jpg', height: 90.0, width: 100.0, fit: BoxFit.cover),
          ),
          SizedBox(width: 8.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.00),
                  color: Colors.blue.shade100,
                ),
                child: Row(
                  children: [
                    Icon(Icons.thumb_up, color: Colors.blue, size: 15.0),
                    SizedBox(width: 3.5),
                    Text(
                      'Match Found!',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.blue),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              Text('${result.name}', style: Theme.of(context).textTheme.titleLarge,),
              Text('${result.latinName}', style: Theme.of(context).textTheme.bodySmall,),
            ],
          ),
        ],
      ),
    );
  }
}