import 'package:inmobiliariaapp/domain/entities/generals.dart';
import 'package:inmobiliariaapp/domain/entities/user.dart';

class AdministratorZone{
  String id;
  User administrator;
  Zone zone;
  AdministratorZone({
    required this.id,
    required this.administrator,
    required this.zone
  });
  factory AdministratorZone.empty(){
    return AdministratorZone(id: "", administrator: User.empty(), zone: Zone.empty());
  }
  factory AdministratorZone.fromMap(Map<String,dynamic> map){
    return AdministratorZone(
      id: map["id"]??"", 
      administrator: map["administrador"]!=null?User.fromMap(map["administrador"]):User.empty(), 
      zone: map["zona"]!=null?Zone.fromMap(map["zona"]):Zone.empty()
    );
  }
}