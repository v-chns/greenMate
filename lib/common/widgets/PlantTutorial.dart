import 'package:flutter/material.dart';
import 'package:greenmate/data/services/PlantTutorialService.dart';
import 'package:greenmate/features/models/Plant.dart';

class PlantTutorial extends StatefulWidget {
  final Plant result;
  const PlantTutorial({Key? key, required this.result}) : super(key: key);

  @override
  State<PlantTutorial> createState() => _PlantTutorialState();
}

class _PlantTutorialState extends State<PlantTutorial> {
  late String _tutorial;
  bool _isLoading = true;
  bool _isTutorialInitialized = false;
  late List<Instruction> instructions;

  @override
  void initState() {
    super.initState();
    if(widget.result.instructions.first.content == "" || widget.result.instructions.first.title == ""){
      _generateTutorial();
    } else{
      _isLoading = false;
      _isTutorialInitialized = true;
    }
  }

  Future<void> _generateTutorial() async {
    _tutorial = await PlantTutorialService.generatePlantTutorial(widget.result.name);
    instructions = parseInstructions(_tutorial);
    widget.result.instructions = instructions;
    for (Instruction instruction in instructions) {
      print('Title: ${instruction.title}');
      print('Content: ${instruction.content}');
    }
    setState(() {
      _isLoading = false;
      _isTutorialInitialized = true;
    });
  }

  double _calculateVerticalBarHeight(Instruction instruction) {
    return instruction.content.split('\n').length * 10;
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ?
    // ini kalo masi loading
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
    // Ini klau udah selesai loading
    Scaffold(
      body: ListView.builder(
        itemCount: widget.result.instructions.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 16.0),
                  child: Column(
                    children: [
                      Container(
                        width: 25.0,
                        height: 25.0,
                        child: Icon(
                          Icons.circle_outlined,
                          color: Colors.green.shade800,
                          size: 25,
                        ),
                      ),
                      Container(
                        width: 2.0,
                        height: 100,
                        color: Colors.green.shade800,
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child:
                    Container (
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.result.instructions[index].title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            widget.result.instructions[index].content,
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ],
                      ),
                    )

                ),
              ],
            ),
          );
        },
      ),
    )

    ;
  }
}

List<Instruction> parseInstructions(String response) {
  List<Instruction> instructions = [];

  List<String> steps = response.split('\n');

  for (String step in steps) {
    step = step.trim();
    if (step.isNotEmpty) {
      int dotIndex = step.indexOf('.');
      int colonIndex = step.indexOf(':');
      int noteIndex = step.indexOf('Note:');
      if (dotIndex != -1 && dotIndex <= 3) {
        String title = step.substring(dotIndex+2, colonIndex).trim();
        String content = step.substring(colonIndex+2).trim();
        instructions.add(Instruction(title, content));
      }
      else if (noteIndex != -1){
        String title = "Notes";
        String content = step.substring(noteIndex + 5).trim();
        instructions.add(Instruction(title, content));
      }
    }
  }

  return instructions;
}
