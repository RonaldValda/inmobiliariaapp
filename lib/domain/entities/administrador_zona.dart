import 'package:inmobiliariaapp/domain/entities/generales.dart';
import 'package:inmobiliariaapp/domain/entities/usuario.dart';

class AdministradorZona{
  String id;
  Usuario administrador;
  Zona zona;
  AdministradorZona({
    required this.id,
    required this.administrador,
    required this.zona
  });
  factory AdministradorZona.vacio(){
    return AdministradorZona(id: "", administrador: Usuario.vacio(), zona: Zona.vacio());
  }
  factory AdministradorZona.fromMap(Map<String,dynamic> map){
    return AdministradorZona(
      id: map["id"]??"", 
      administrador: map["administrador"]!=null?Usuario.fromMap(map["administrador"]):Usuario.vacio(), 
      zona: map["zona"]!=null?Zona.fromMap(map["zona"]):Zona.vacio()
    );
  }
}