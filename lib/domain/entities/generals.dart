
class Departament{
  String id;
  String departamentName;
  Departament({
    required this.id,
    required this.departamentName
  });
  factory Departament.fromMap(Map<String,dynamic> map){
    return Departament(
      id: map["id"]??"",
      departamentName: map["nombre_departamento"]??""
    );
  }
  factory Departament.empty(){
    return Departament(id: "", departamentName: "");
  }
  factory Departament.copyWith(Departament departament){
    return Departament(id: departament.id, departamentName: departament.departamentName);
  }
}
class City{
  String id;
  String cityName;
  City({
    required this.id,
    required this.cityName
  });
  factory City.fromMap(Map<String,dynamic> map){
    return City(
      id: map["id"]??"", 
      cityName: map["nombre_ciudad"]??""
    );
  }
  factory City.empty(){
    return City(
      id: "",
      cityName: ""
    );
  }
  factory City.copyWith(City c){
    return City(id: c.id,cityName: c.cityName);
  }
}
class Zone{
  String id;
  String zoneName;
  List<List<dynamic>> area;
  String cityId;
  Zone({
    required this.id,
    required this.zoneName,
    required this.area,
    required this.cityId
  });
  factory Zone.empty(){
    return Zone(
      id:"",zoneName:"",area:[[0.0,0.0],[0.0,0.0]],
      cityId: ""
    );
  }
  factory Zone.fromMap(Map<String,dynamic> map){
    return Zone(
      id:map["id"],
      zoneName:map["nombre_zona"],
      area:[[map["coordenadas"][0],map["coordenadas"][1]],[map["coordenadas"][2],map["coordenadas"][3]]],
      cityId: map["ciudad"]??""
    );
  }
  factory Zone.copyWith(Zone zone){
    return Zone(
      id: zone.id,
      zoneName:zone.zoneName,
      area: zone.area,
      cityId: zone.cityId
    );
  }
}