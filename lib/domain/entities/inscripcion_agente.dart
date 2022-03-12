

import 'package:inmobiliariaapp/domain/entities/usuario.dart';

class InscripcionAgente{
  String id;
  String fechaSolicitud;
  String fechaRespuesta;
  String linkRespaldoSolicitud;
  String respuesta;
  String observaciones;
  bool respuestaEntregada;
  Usuario usuarioSolicitante;
  Usuario usuarioRespondedor;
  InscripcionAgente({
    required this.id,
    required this.fechaSolicitud,
    required this.fechaRespuesta,
    required this.linkRespaldoSolicitud,
    required this.respuesta,
    required this.observaciones,
    required this.respuestaEntregada,
    required this.usuarioSolicitante,
    required this.usuarioRespondedor
  });
  factory InscripcionAgente.vacio(){
    return InscripcionAgente(
      id: "", 
      fechaSolicitud: "", 
      fechaRespuesta: "", 
      linkRespaldoSolicitud: "", 
      respuesta: "", 
      observaciones: "",
      respuestaEntregada: false,
      usuarioSolicitante: Usuario.vacio(),
      usuarioRespondedor: Usuario.vacio()
    );
  }
  factory InscripcionAgente.fromMap(Map<String,dynamic> map){
    return InscripcionAgente(
      id: map["id"]??"",
      fechaSolicitud: map["fecha_solicitud"]??"",
      fechaRespuesta: map["fecha_respuesta"]??"",
      linkRespaldoSolicitud: map["link_respaldo_solicitud"]??"",
      respuesta: map["respuesta"]??"",
      observaciones: map["observaciones"]??"",
      respuestaEntregada: map["respuesta_entregada"]??false,
      usuarioSolicitante:map["usuario_solicitante"]!=null?Usuario.fromMap(map["usuario_solicitante"]):Usuario.vacio(),
      usuarioRespondedor: map["usuario_respondendor"]!=null?Usuario.fromMap(map["usuario_respondendor"]):Usuario.vacio()
    );
  }
  factory InscripcionAgente.copyWith(InscripcionAgente i){
    return InscripcionAgente(
      id: i.id, 
      fechaSolicitud: i.fechaSolicitud, fechaRespuesta: i.fechaRespuesta, 
      linkRespaldoSolicitud: i.linkRespaldoSolicitud, respuesta: i.respuesta, 
      observaciones: i.observaciones, respuestaEntregada: i.respuestaEntregada, 
      usuarioSolicitante: Usuario.copyWith(i.usuarioSolicitante), 
      usuarioRespondedor: Usuario.copyWith(i.usuarioRespondedor)
    );
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "link_respaldo_solicitud":this.linkRespaldoSolicitud,
      "respuesta":this.respuesta,
      "observaciones":this.observaciones,
      "respuesta_entregada":this.respuestaEntregada,
      "ciudad":this.usuarioSolicitante.ciudad,
      "web":this.usuarioSolicitante.web,
      "agencia":this.usuarioSolicitante.nombreAgencia,
      "telefono":this.usuarioSolicitante.numeroTelefono,
      "id_usuario_solicitante":this.usuarioSolicitante.id,
      "id_usuario_respondedor":this.usuarioRespondedor.id,
    };
  }
}