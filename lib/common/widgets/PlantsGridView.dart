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
    setState(() {
      _isLoading = false;
    });
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
        crossAxisSpacing: 5.0, // Spacing between columns
        mainAxisSpacing: 10.0, // Spacing between rows
      ),
      itemCount: plantsList.length,
      itemBuilder: (context, index) {
        return _buildPlantContainer(plantsList[index], 'assets/images/dummyplant.jpg', context);
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
      width: 140,
      child: Column(
        children: [
          Container(
            height: 110,
            width: 140,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 1),
          Container(
            width: 140,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    plant.name,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Container(
                  child: Text(
                    plant.latinName,
                    style: Theme.of(context).textTheme.labelMedium,
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


