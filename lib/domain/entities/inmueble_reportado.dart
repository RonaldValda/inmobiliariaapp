
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/domain/entities/usuario.dart';

class InmuebleReportado{
  String id;
  Usuario usuarioSolicitante,usuarioRespondedor;
  InmuebleTotal inmueble;
  bool vendidoMultiplesLugares,contenidoFalsoImagen,contenidoFalsoTexto,contenidoInapropiado,otro;
  String observacionesSolicitud,fechaSolicitud,fechaRespuesta,observacionesRespuesta;
  String respuesta;
  bool respuestaEntregada;
  InmuebleReportado({
    required this.id,required this.usuarioSolicitante,required this.usuarioRespondedor,
    required this.inmueble, required this.vendidoMultiplesLugares,required this.contenidoFalsoImagen,
    required this.contenidoFalsoTexto,required this.contenidoInapropiado,required this.otro,
    required this.observacionesSolicitud,required this.fechaSolicitud,
    required this.fechaRespuesta,required this.respuesta,required this.observacionesRespuesta,
    required this.respuestaEntregada
  });
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "id_solicitante":this.usuarioSolicitante.id,
      "id_respondedor":this.usuarioRespondedor.id,
      "id_inmueble":this.inmueble.inmueble.id,
      "vendido_multiples_lugares":this.vendidoMultiplesLugares,
      "contenido_falso_imagen":this.contenidoFalsoImagen,
      "contenido_falso_texto":this.contenidoFalsoTexto,
      "contenido_inapropiado":this.contenidoInapropiado,
      "otro":this.otro,
      "observaciones_solicitud":this.observacionesSolicitud,
      "fecha_solicitud":this.fechaSolicitud,
      "fecha_respuesta":this.fechaRespuesta,
      "respuesta":this.respuesta,
      "observaciones_respuesta":this.observacionesRespuesta,
      "respuesta_entregada":this.respuestaEntregada
    };
  }
  factory InmuebleReportado.vacio(){
    return InmuebleReportado(
      id: "", 
      usuarioSolicitante: Usuario.vacio(), usuarioRespondedor: Usuario.vacio(), 
      inmueble: InmuebleTotal.vacio(), 
      vendidoMultiplesLugares: false, contenidoFalsoImagen: false, 
      contenidoFalsoTexto: false, contenidoInapropiado: false, otro: false, 
      observacionesSolicitud: "", fechaSolicitud: "", fechaRespuesta: "", 
      respuesta: "", observacionesRespuesta: "", respuestaEntregada: false
    );
  }
  factory InmuebleReportado.fromMap(Map<String,dynamic> map,String tipoSesion){
    return InmuebleReportado(
      id: map["id"], usuarioSolicitante: map["usuario_solicitante"]!=null?Usuario.fromMap(map["usuario_solicitante"]):Usuario.vacio(), 
      usuarioRespondedor: map["usuario_respondedor"]!=null?Usuario.fromMap(map["usuario_respondedor"]):Usuario.vacio(), 
      inmueble: map["inmueble"]!=null?InmuebleTotal.fromMap(tipoSesion, map):InmuebleTotal.vacio(),
      vendidoMultiplesLugares: map["vendido_multiples_lugares"]??false,
      contenidoFalsoImagen: map["contenido_falso_imagen"]??false, 
      contenidoFalsoTexto: map["contenido_falso_texto"]??false, 
      contenidoInapropiado: map["contenido_inapropiado"]??false, 
      otro: map["otro"]??false, 
      observacionesSolicitud: map["observaciones_solicitud"]??"", 
      fechaSolicitud: map["fecha_solicitud"]??"", fechaRespuesta: map["fecha_respuesta"]??"", 
      respuesta: map["respuesta"]??"", observacionesRespuesta: map["observaciones_respuesta"]??"", 
      respuestaEntregada: map["respuesta_entregada"]??false
    );
  }
}
class InmuebleQueja{
  String id;
  Usuario usuarioRespondedor;
  InmuebleTotal inmueble;
  bool sinRespuesta;
  bool rechazadoSinJustificacion;
  bool otro;
  String observacionesSolicitud;
  String fechaSolicitud;
  String fechaRespuesta;
  String respuesta;
  String observacionesRespuesta;
  bool respuestaEntregada;
  InmuebleQueja({
    required this.id, required this.usuarioRespondedor,
    required this.inmueble, required this.sinRespuesta,
    required this.rechazadoSinJustificacion, required this.otro,
    required this.observacionesSolicitud, required this.fechaSolicitud,
    required this.fechaRespuesta, required this.respuesta,
    required this.observacionesRespuesta, required this.respuestaEntregada
  });
  factory InmuebleQueja.vacio(){
    return InmuebleQueja(
      id: "", usuarioRespondedor: Usuario.vacio(), 
      inmueble: InmuebleTotal.vacio(),
      sinRespuesta: false, rechazadoSinJustificacion: false, otro: false, 
      observacionesSolicitud: "", fechaSolicitud: "", fechaRespuesta:"", 
      respuesta: "", observacionesRespuesta: "", respuestaEntregada: false
    );
  }
  factory InmuebleQueja.fromMap(Map<String,dynamic> map){
    return InmuebleQueja(
      id: map["id"]??"", 
      usuarioRespondedor: map["usuario_respondedor"]!=null?Usuario.fromMap(map["usuario_respondedor"]):Usuario.vacio(),
      inmueble: map["inmueble"]!=null?InmuebleTotal.fromMap("Vender", map["inmueble"]):InmuebleTotal.vacio(), 
      sinRespuesta: map["sin_respuesta"]??false, 
      rechazadoSinJustificacion: map["rechazado_sin_justificacion"]??false, 
      otro: map["otro"]??false, 
      observacionesSolicitud: map["observaciones_solicitud"]??"",
      fechaSolicitud: map["fecha_solicitud"]??"", 
      fechaRespuesta: map["fecha_respuesta"]??"", 
      respuesta: map["respuesta"]??"", 
      observacionesRespuesta: map["observaciones_respuesta"]??"", 
      respuestaEntregada: map["respuesta_entregada"]??false
    );
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "usuario_respondedor":this.usuarioRespondedor.id,
      "id_inmueble":this.inmueble.inmueble.id,
      "sin_respuesta":this.sinRespuesta,
      "rechazado_sin_justificacion":this.rechazadoSinJustificacion,
      "otro":this.otro,
      "observaciones_solicitud":this.observacionesSolicitud,
      "fecha_solicitud":this.fechaSolicitud,
      "fecha_respuesta":this.fechaRespuesta,
      "respuesta":this.respuesta,
      "observaciones_respuesta":this.observacionesRespuesta,
      "respuesta_entregada":this.respuestaEntregada
    };
  }
}