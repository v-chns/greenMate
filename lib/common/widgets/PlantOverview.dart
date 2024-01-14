import 'package:flutter/material.dart';
import 'package:greenmate/features/models/Plant.dart';

class PlantOverview extends StatefulWidget {
  final Plant result;
  const PlantOverview({Key? key, required this.result}) : super(key: key);

  @override
  State<PlantOverview> createState() => _PlantOverviewState();
}

class _PlantOverviewState extends State<PlantOverview> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Monstera, or Monstera deliciosa, is a trendy tropical plant with iconic perforated leaves native to Central America. Its adaptable nature and unique, glossy foliage have made it a popular and low-maintenance choice for indoor decor, earning it the nickname "Swiss cheese plant" among enthusiasts worldwide.', // Replace with the actual description
              style: TextStyle(fontSize: 15.0),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16.0),

            // Maintenance
            Text(
              'Maintenance',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 5.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.result.maintenance
                  .map((maintenance) => MaintenanceContainer(
                type: maintenance.type,
                description: maintenance.description,
              ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class MaintenanceContainer extends StatelessWidget {
  final String type;
  final String description;

  const MaintenanceContainer({
    Key? key,
    required this.type,
    required this.description,
  }) : super(key: key);

  IconData getIcon(String type) {
    switch (type) {
      case 'Sunlight':
        return Icons.wb_sunny;
      case 'Watering':
        return Icons.water_drop;
      case 'Pruning':
        return Icons.cut;
      case 'SoilType':
        return Icons.snowing;
      case 'Temperature':
        return Icons.thermostat;
      default:
        return Icons.help;
    }
  }

  Color getColor(String type) {
    switch (type) {
      case 'Sunlight':
        return Colors.amberAccent;
      case 'Watering':
        return Colors.lightBlue.shade300;
      case 'Pruning':
        return Colors.pink.shade300;
      case 'SoilType':
        return Colors.brown.shade600;
      case 'Temperature':
        return Colors.red;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      margin: EdgeInsets.only(bottom: 10, top: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
                Container(
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: getColor(type),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Icon(
                  getIcon(type),
                  color: Colors.white,
                  size: 24.0,
                ),
              ),
              SizedBox(width: 15.0),
              Text(
                type == 'SoilType' ? 'Soil Type' : type,
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
              ),
            ],
          ),

          SizedBox(height: 10.0),
          Text(
                description,
                style: TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}

