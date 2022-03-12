
class Departamento{
  String id;
  String nombreDepartamento;
  Departamento({
    required this.id,
    required this.nombreDepartamento
  });
  factory Departamento.fromMap(Map<String,dynamic> map){
    return Departamento(
      id: map["id"]??"",
      nombreDepartamento: map["nombre_departamento"]??""
    );
  }
  factory Departamento.vacio(){
    return Departamento(id: "", nombreDepartamento: "");
  }
}
class Ciudad{
  String id;
  String nombreCiudad;
  Ciudad({
    required this.id,
    required this.nombreCiudad
  });
  factory Ciudad.fromMap(Map<String,dynamic> map){
    return Ciudad(
      id: map["id"]??"", 
      nombreCiudad: map["nombre_ciudad"]??""
    );
  }
  factory Ciudad.vacio(){
    return Ciudad(
      id: "",
      nombreCiudad: ""
    );
  }
  factory Ciudad.copyWith(Ciudad c){
    return Ciudad(id: c.id,nombreCiudad: c.nombreCiudad);
  }
}
class Zona{
  String id;
  String nombreZona;
  List<List<dynamic>> area;
  String idCiudad;
  Zona({
    required this.id,
    required this.nombreZona,
    required this.area,
    required this.idCiudad
  });
  factory Zona.vacio(){
    return Zona(
      id:"",nombreZona:"",area:[[0.0,0.0],[0.0,0.0]],
      idCiudad: ""
    );
  }
  factory Zona.fromMap(Map<String,dynamic> map){
    return Zona(
      id:map["id"],
      nombreZona:map["nombre_zona"],
      area:[[map["coordenadas"][0],map["coordenadas"][1]],[map["coordenadas"][2],map["coordenadas"][3]]],
      idCiudad: map["ciudad"]??""
    );
  }
  factory Zona.copia(Zona zona){
    return Zona(
      id: zona.id,
      nombreZona:zona.nombreZona,
      area: zona.area,
      idCiudad: zona.idCiudad
    );
  }
  void zonaCopy(Zona zona){
    this.id="";
    this.nombreZona=zona.nombreZona;
    this.area=zona.area;
  }
}