import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
class AgenciaInmobiliaria{
  String id="";
  String nombreAgencia="";
  String nombrePropietario="";
  String telefono="";
  String web="";
  AgenciaInmobiliaria({
    required this.id,
    required this.nombreAgencia,
    required this.nombrePropietario,
    required this.telefono,
    required this.web});
  get getId=>this.id;
  get getNombreAgencia=>this.nombreAgencia;
  get getNombrePropietario=>this.nombrePropietario;
  get getTelefono=>this.telefono;
  get getWeb=>this.web;
  void setId(String id)=>this.id;
  void setNombreAgencia(String nombreAgencia)=>this.nombreAgencia;
  void setNombrePropietario(String nombrePropietario)=>this.nombrePropietario;
  void setTelefono(String telefono)=>this.telefono;
  void setWeb(String web)=>this.web;
  AgenciaInmobiliaria.map(dynamic obj){
    this.nombreAgencia=obj["nombre_agencia"];
    this.nombrePropietario=obj["nombre_propietario"];
    this.telefono=obj["telefono"];
    this.web=obj["web"];
  }
  AgenciaInmobiliaria.fromSnapshot(DataSnapshot snapshot){
    id=snapshot.key!;
    nombreAgencia=snapshot.value["nombre_agencia"];
    nombrePropietario=snapshot.value["nombre_propietario"];
    telefono=snapshot.value["telefono"];
    web=snapshot.value["web"];
  }
  factory AgenciaInmobiliaria.fromFireStore(DocumentSnapshot snapshot){
    return AgenciaInmobiliaria(
      id: snapshot.id,
      nombreAgencia: snapshot["nombre_agencia"],
      nombrePropietario: snapshot["propietario"],
      telefono: snapshot["telefono"],
      web: snapshot["web"]
    );
  }
  factory AgenciaInmobiliaria.fromMap(Map<String,dynamic> snapshot){
    return AgenciaInmobiliaria(
      id: snapshot["id"],
      nombreAgencia: snapshot["nombre_agencia"],
      nombrePropietario: snapshot["nombre_propietario"],
      telefono: snapshot["telefono"],
      web: snapshot["web"]
    );
  }
  factory AgenciaInmobiliaria.vacio(){
    return AgenciaInmobiliaria(id: "", nombreAgencia: "", nombrePropietario: "", telefono: "", web: "");
  }
  //AgenciaInmobiliaria.empty();
}