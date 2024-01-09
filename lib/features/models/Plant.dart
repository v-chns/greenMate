class Plant {
  final String plantClass;
  final String name;
  final String latinName;
  final String family;
  final String kingdom;
  final List<Maintenance> maintenance;

  Plant({
    required this.plantClass,
    required this.name,
    required this.latinName,
    required this.family,
    required this.kingdom,
    required this.maintenance,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      plantClass: json['data']['class'],
      name: json['data']['name'],
      latinName: json['data']['latinName'],
      family: json['data']['family'],
      kingdom: json['data']['kingdom'],
      maintenance: List<Maintenance>.from(json['data']['maintenance'].map((maintenanceJson) => Maintenance.fromJson(maintenanceJson))),
    );
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
