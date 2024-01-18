import 'package:flutter/material.dart';
import 'package:greenmate/data/services/GetPlantsList.dart';
import 'package:greenmate/features/models/Plant.dart';
import 'package:greenmate/features/screens/PlantDetails.dart';

class PlantsGridView extends StatefulWidget {
  const PlantsGridView({
    Key? key,
  }) : super(key: key);

  @override
  State<PlantsGridView> createState() => _PlantsGridViewState();
}

class _PlantsGridViewState extends State<PlantsGridView> {
  bool _isLoading = true;

  late List<Plant> plantsList;

  Future<void> _getPlants() async {
    plantsList = await GetPlantsList().getAllPlants();
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getPlants();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ?
    // ini kalau masih loading
    Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.only(top: 30),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen.shade400),
        ),
      ),
    )
        :
    // List of plants
    GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 3.0, // Spacing between columns
        mainAxisSpacing: 8.0, // Spacing between rows
      ),
      itemCount: plantsList.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _buildPlantContainer(plantsList[index], plantsList[index].defaultImage, context);
      },
    )
    ;
  }
}

Widget _buildPlantContainer(Plant plant, String imagePath, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlantDetails(result: plant),
        ),
      );
    },
    child: Container(
      width: 145,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imagePath,
              width: 145,
              height: 105,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 1),
          Container(
            width: 145,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    plant.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Container(
                  child: Text(
                    plant.latinName,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.black.withOpacity(0.5)),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


