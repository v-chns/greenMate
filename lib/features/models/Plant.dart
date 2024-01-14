import 'dart:math';

class Plant {
  final String plantClass;
  final String name;
  final String latinName;
  final String family;
  final String kingdom;
  final String defaultImage;
  int userPlantId = 0;
  int userTutorialId = 0;
  String userImage = "";
  List<Instruction> instructions = [Instruction("", "")];
  final List<Maintenance> maintenance;

  Plant({
    required this.plantClass,
    required this.name,
    required this.latinName,
    required this.family,
    required this.kingdom,
    required this.maintenance,
    required this.defaultImage,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      plantClass: json['data']['class'],
      name: json['data']['name'],
      latinName: json['data']['latinName'],
      family: json['data']['family'],
      kingdom: json['data']['kingdom'],
      maintenance: List<Maintenance>.from(json['data']['maintenance'].map((maintenanceJson) => Maintenance.fromJson(maintenanceJson))),
      defaultImage: json['data']['defaultImage']
    );
  }

  factory Plant.fromJson1(Map<String, dynamic> json) {
    return Plant(
      plantClass: json['class'],
      name: json['name'],
      latinName: json['latinName'],
      family: json['family'],
      kingdom: json['kingdom'],
      maintenance: List<Maintenance>.from(json['maintenance'].map((maintenanceJson) => Maintenance.fromJson(maintenanceJson))),
      defaultImage: json['defaultImage']
    );
  }

  Map<String, dynamic> toDBObject(){
    return{
      'userPlantId': this.userPlantId,
      'userImage' : this.userImage,
      'class' : this.plantClass
    };
  }

  Map<String, dynamic> toDBTutorialObject(){
    return{
      'userTutorialId': this.userTutorialId,
      'class' : this.plantClass
    };
  }

  void setUserTutorialData(int id){
    this.userTutorialId = id;
  }

  void setUserData(int id, String img){
    this.userPlantId = id;
    this.userImage = img;
  }

}


class Maintenance {
  final String type;
  final String description;

  Maintenance({required this.type, required this.description});

  factory Maintenance.fromJson(Map<String, dynamic> json) {
    return Maintenance(
      type: json['type'],
      description: json['description'],
    );
  }
}

class Instruction {
  final String title;
  final String content;

  Instruction(this.title, this.content);
}
