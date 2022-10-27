

import 'package:inmobiliariaapp/domain/entities/user.dart';

class AgentRegistration{
  String id;
  String requestDate;
  String responseDate;
  String requestBackupLink;
  String response;
  String observations;
  bool deliveredResponse;
  User userRequest;
  User userResponding;
  AgentRegistration({
    required this.id,
    required this.requestDate,
    required this.responseDate,
    required this.requestBackupLink,
    required this.response,
    required this.observations,
    required this.deliveredResponse,
    required this.userRequest,
    required this.userResponding
  });
  factory AgentRegistration.empty(){
    return AgentRegistration(
      id: "", 
      requestDate: "", 
      responseDate: "", 
      requestBackupLink: "", 
      response: "", 
      observations: "",
      deliveredResponse: false,
      userRequest: User.empty(),
      userResponding: User.empty()
    );
  }
  factory AgentRegistration.fromMap(Map<String,dynamic> map){
    return AgentRegistration(
      id: map["id"]??"",
      requestDate: map["fecha_solicitud"]??"",
      responseDate: map["fecha_respuesta"]??"",
      requestBackupLink: map["link_respaldo_solicitud"]??"",
      response: map["respuesta"]??"",
      observations: map["observaciones"]??"",
      deliveredResponse: map["respuesta_entregada"]??false,
      userRequest:map["usuario_solicitante"]!=null?User.fromMap(map["usuario_solicitante"]):User.empty(),
      userResponding: map["usuario_respondendor"]!=null?User.fromMap(map["usuario_respondendor"]):User.empty()
    );
  }
  factory AgentRegistration.copyWith(AgentRegistration ra){
    return AgentRegistration(
      id: ra.id, 
      requestDate: ra.requestDate, responseDate: ra.responseDate, 
      requestBackupLink: ra.requestBackupLink, response: ra.response, 
      observations: ra.observations, deliveredResponse: ra.deliveredResponse, 
      userRequest: User.copyWith(ra.userRequest), 
      userResponding: User.copyWith(ra.userResponding)
    );
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "link_respaldo_solicitud":this.requestBackupLink,
      "respuesta":this.response,
      "observaciones":this.observations,
      "respuesta_entregada":this.deliveredResponse,
      "ciudad":this.userRequest.city,
      "web":this.userRequest.web,
      "agencia":this.userRequest.agencyName,
      "telefono":this.userRequest.phoneNumber,
      "id_usuario_solicitante":this.userRequest.id,
      "id_usuario_respondedor":this.userResponding.id,
    };
  }
}