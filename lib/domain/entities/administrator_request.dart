
import 'package:inmobiliariaapp/domain/entities/property.dart';
import 'package:inmobiliariaapp/domain/entities/user.dart';

class AdministratorRequest{
  String id;
  User userResponding;
  String requestDate;
  String responseDate;
  String requestType;
  String response;
  String observations;
  String requestBackupLink;
  String responseBackupLink;
  bool requestFinished;
  bool deliveredResponse;
  User superUser;
  String requestDateSuperUser;
  String responseDateSuperUser;
  String responseSuperUser;
  String observationsSuperUser;
  bool requestFinishedSuperUser;
  PropertyVoucher propertyVoucher;
  AdministratorRequest({
    required this.id,
    required this.userResponding,
    required this.requestDate,
    required this.responseDate,
    required this.requestType,
    required this.response,
    required this.observations,
    required this.requestBackupLink,
    required this.responseBackupLink,
    required this.requestFinished,
    required this.deliveredResponse,
    required this.superUser,
    required this.requestDateSuperUser,
    required this.responseDateSuperUser,
    required this.responseSuperUser,
    required this.observationsSuperUser,
    required this.requestFinishedSuperUser,
    required this.propertyVoucher
  });
  factory AdministratorRequest.fromMap(Map<String,dynamic> mapData){
    return AdministratorRequest(
      id: mapData["id"]??"",
      userResponding: mapData["usuario_respondedor"]!=null?User.fromMap(mapData["usuario_respondedor"]):User.empty(), 
      requestDate: mapData["fecha_solicitud"]??"", 
      responseDate: mapData["fecha_respuesta"]??"", 
      requestType: mapData["tipo_solicitud"]??"",
      response: mapData["respuesta"]??"", observations: mapData["observaciones"]??"", 
      requestBackupLink: mapData["link_respaldo_solicitud"]!=null?mapData["link_respaldo_solicitud"]:"", 
      responseBackupLink: mapData["link_respaldo_respuesta"]!=null?mapData["link_respaldo_respuesta"]:"", 
      requestFinished: mapData["solicitud_terminada"]??false,
      deliveredResponse: mapData["respuesta_entregada"]??false,
      superUser:  mapData["super_usuario"]!=null?User.fromMap(mapData["super_usuario"]):User.empty(), 
      requestDateSuperUser: mapData["fecha_solicitud_super_usuario"]!=null?mapData["fecha_solicitud_super_usuario"]:"", 
      responseDateSuperUser: mapData["fecha_respuesta_super_usuario"]!=null?mapData["fecha_respuesta_super_usuario"]:"",
      observationsSuperUser: mapData["observaciones_super_usuario"]!=null?mapData["observaciones_super_usuario"]:"",
      responseSuperUser: mapData["respuesta_super_usuario"]!=null?mapData["respuesta_super_usuario"]:"",
      requestFinishedSuperUser: mapData["solicitud_terminada_super_usuario"]!=null?mapData["solicitud_terminada_super_usuario"]:false,
      propertyVoucher: mapData["comprobante"]!=null?PropertyVoucher.fromMap(mapData["comprobante"]):PropertyVoucher.empty()
    );
  }
  factory AdministratorRequest.empty(){
    return AdministratorRequest(
      id: "", userResponding:User.empty(), 
      requestDate: "", responseDate: "", 
      requestType: "", response: "", observations: "", 
      requestBackupLink: "",responseBackupLink: "", requestFinished: false,
      deliveredResponse: false,
      superUser: User.empty(),requestDateSuperUser: "",
      responseDateSuperUser: "",observationsSuperUser: "",
      responseSuperUser: "",requestFinishedSuperUser: false,
      propertyVoucher: PropertyVoucher.empty()
    );
  }
  factory AdministratorRequest.copyWith(AdministratorRequest ar){
    return AdministratorRequest(
      id: ar.id, userResponding: User.copyWith(ar.userResponding), requestDate: ar.requestDate, 
      responseDate: ar.responseDate, requestType: ar.requestType, response: ar.response, 
      observations: ar.observations, requestBackupLink: ar.requestBackupLink, 
      responseBackupLink: ar.responseBackupLink, requestFinished: ar.requestFinished,
      deliveredResponse: ar.deliveredResponse,
      superUser: User.copyWith(ar.superUser),requestDateSuperUser: ar.requestDateSuperUser,
      responseDateSuperUser: ar.responseDateSuperUser, observationsSuperUser: ar.observationsSuperUser, 
      responseSuperUser: ar.responseSuperUser,requestFinishedSuperUser: ar.requestFinishedSuperUser,
      propertyVoucher: PropertyVoucher.copyWith(ar.propertyVoucher)
    );
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id_solicitud":this.id,
      "id_respondedor":this.userResponding.id,
      "tipo_solicitud":this.requestType,
      "respuesta":this.response,
      "observaciones":this.observations,
      "link_respaldo_solicitud":this.requestBackupLink,
      "link_respaldo_respueta":this.responseBackupLink,
      "solicitud_terminada":this.requestFinished
    };
  }
}