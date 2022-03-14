
import 'package:inmobiliariaapp/domain/entities/usuario.dart';

class SolicitudAdministrador{
  String id;
  Usuario usuarioRespondedor;
  String fechaSolicitud;
  String fechaRespuesta;
  String tipoSolicitud;
  String respuesta;
  String observaciones;
  String linkRespaldoSolicitud;
  String linkRespaldoRespuesta;
  bool solicitudTerminada;
  bool respuestaEntregada;
  Usuario superUsuario;
  String fechaSolicitudSuperUsuario;
  String fechaRespuestaSuperUsuario;
  String respuestaSuperUsuario;
  String observacionesSuperUsuario;
  bool solicitudTerminadaSuperUsuario;
  InmuebleDarBaja inmuebleDarBaja;
  InmuebleVendido inmuebleVendido;
  SolicitudAdministrador({
    required this.id,
    required this.usuarioRespondedor,
    required this.fechaSolicitud,
    required this.fechaRespuesta,
    required this.tipoSolicitud,
    required this.respuesta,
    required this.observaciones,
    required this.linkRespaldoSolicitud,
    required this.linkRespaldoRespuesta,
    required this.solicitudTerminada,
    required this.respuestaEntregada,
    required this.superUsuario,
    required this.fechaSolicitudSuperUsuario,
    required this.fechaRespuestaSuperUsuario,
    required this.respuestaSuperUsuario,
    required this.observacionesSuperUsuario,
    required this.solicitudTerminadaSuperUsuario,
    required this.inmuebleDarBaja,
    required this.inmuebleVendido
  });
  factory SolicitudAdministrador.fromMap(Map<String,dynamic> mapData){
    //print("respondedor ${mapData.toString()}");
    return SolicitudAdministrador(
      id: mapData["id"]??"",
      usuarioRespondedor: mapData["usuario_respondedor"]!=null?Usuario.fromMap(mapData["usuario_respondedor"]):Usuario.vacio(), 
      fechaSolicitud: mapData["fecha_solicitud"]??"", 
      fechaRespuesta: mapData["fecha_respuesta"]??"", 
      tipoSolicitud: mapData["tipo_solicitud"]??"",
      respuesta: mapData["respuesta"]??"", observaciones: mapData["observaciones"]??"", 
      linkRespaldoSolicitud: mapData["link_respaldo_solicitud"]!=null?mapData["link_respaldo_solicitud"]:"", 
      linkRespaldoRespuesta: mapData["link_respaldo_respuesta"]!=null?mapData["link_respaldo_respuesta"]:"", 
      solicitudTerminada: mapData["solicitud_terminada"]??false,
      respuestaEntregada: mapData["respuesta_entregada"]??false,
      superUsuario:  mapData["super_usuario"]!=null?Usuario.fromMap(mapData["super_usuario"]):Usuario.vacio(), 
      fechaSolicitudSuperUsuario: mapData["fecha_solicitud_super_usuario"]!=null?mapData["fecha_solicitud_super_usuario"]:"", 
      fechaRespuestaSuperUsuario: mapData["fecha_respuesta_super_usuario"]!=null?mapData["fecha_respuesta_super_usuario"]:"",
      observacionesSuperUsuario: mapData["observaciones_super_usuario"]!=null?mapData["observaciones_super_usuario"]:"",
      respuestaSuperUsuario: mapData["respuesta_super_usuario"]!=null?mapData["respuesta_super_usuario"]:"",
      solicitudTerminadaSuperUsuario: mapData["solicitud_terminada_super_usuario"]!=null?mapData["solicitud_terminada_super_usuario"]:false,
      inmuebleDarBaja: mapData["inmueble_dar_baja"]!=null?InmuebleDarBaja.fromMap(mapData["inmueble_dar_baja"]):InmuebleDarBaja.vacio(),
      inmuebleVendido: mapData["inmueble_vendido"]!=null?InmuebleVendido.fromMap(mapData["inmueble_vendido"]):InmuebleVendido.vacio()
    );
  }
  factory SolicitudAdministrador.vacio(){
    return SolicitudAdministrador(
      id: "", usuarioRespondedor:Usuario.vacio(), 
      fechaSolicitud: "", fechaRespuesta: "", 
      tipoSolicitud: "", respuesta: "", observaciones: "", 
      linkRespaldoSolicitud: "",linkRespaldoRespuesta: "", solicitudTerminada: false,
      respuestaEntregada: false,
      superUsuario: Usuario.vacio(),fechaSolicitudSuperUsuario: "",
      fechaRespuestaSuperUsuario: "",observacionesSuperUsuario: "",
      respuestaSuperUsuario: "",solicitudTerminadaSuperUsuario: false,
      inmuebleDarBaja: InmuebleDarBaja.vacio(),
      inmuebleVendido: InmuebleVendido.vacio()
    );
  }
  factory SolicitudAdministrador.copyWith(SolicitudAdministrador sa){
    return SolicitudAdministrador(
      id: sa.id, usuarioRespondedor: Usuario.copyWith(sa.usuarioRespondedor), fechaSolicitud: sa.fechaSolicitud, 
      fechaRespuesta: sa.fechaRespuesta, tipoSolicitud: sa.tipoSolicitud, respuesta: sa.respuesta, 
      observaciones: sa.observaciones, linkRespaldoSolicitud: sa.linkRespaldoSolicitud, 
      linkRespaldoRespuesta: sa.linkRespaldoRespuesta, solicitudTerminada: sa.solicitudTerminada,
      respuestaEntregada: sa.respuestaEntregada,
      superUsuario: Usuario.copyWith(sa.superUsuario),fechaSolicitudSuperUsuario: sa.fechaSolicitudSuperUsuario,
      fechaRespuestaSuperUsuario: sa.fechaRespuestaSuperUsuario,observacionesSuperUsuario: sa.observacionesSuperUsuario,
      respuestaSuperUsuario: sa.respuestaSuperUsuario,solicitudTerminadaSuperUsuario: sa.solicitudTerminadaSuperUsuario,
      inmuebleDarBaja: InmuebleDarBaja.copyWith(sa.inmuebleDarBaja),inmuebleVendido: InmuebleVendido.copyWith(sa.inmuebleVendido)
    );
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id_solicitud":this.id,
      "id_respondedor":this.usuarioRespondedor.id,
      "tipo_solicitud":this.tipoSolicitud,
      "respuesta":this.respuesta,
      "observaciones":this.observaciones,
      "link_respaldo_solicitud":this.linkRespaldoSolicitud,
      "link_respaldo_respueta":this.linkRespaldoRespuesta,
      "solicitud_terminada":this.solicitudTerminada
    };
  }
}

class InmuebleDarBaja{
String id="";
bool limiteContrato;
bool cancelacionContrato;
dynamic imagenDocumentoPropiedad;
InmuebleDarBaja({
  required this.id,
  required this.limiteContrato,
  required this.cancelacionContrato,
  required this.imagenDocumentoPropiedad
});
  factory InmuebleDarBaja.fromMap(Map<String,dynamic> map){
    return InmuebleDarBaja(
      id: map["id"], 
      limiteContrato: map["limite_contrato"], 
      cancelacionContrato: map["cancelacion_contrato"], 
      imagenDocumentoPropiedad: map["imagen_documento_propiedad"]
    );
  }
  factory InmuebleDarBaja.vacio(){
    return InmuebleDarBaja(
      id: "", limiteContrato: false, 
      cancelacionContrato: false, 
      imagenDocumentoPropiedad: ""
    );
  }
  factory InmuebleDarBaja.copyWith(InmuebleDarBaja idb){
    return InmuebleDarBaja(
      id: idb.id, 
      limiteContrato: idb.limiteContrato, 
      cancelacionContrato: idb.cancelacionContrato, 
      imagenDocumentoPropiedad: idb.imagenDocumentoPropiedad
    );
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "limite_contrato":this.limiteContrato,
      "cancelacion_contrato":this.cancelacionContrato,
      "imagen_documento_propiedad":this.imagenDocumentoPropiedad
    };
  }
}
class InmuebleVendido{
  String id;
  String nroTestimonio;
  Usuario usuarioComprador;
  InmuebleVendido({
    required this.id,
    required this.nroTestimonio,
    required this.usuarioComprador
  });
  factory InmuebleVendido.fromMap(Map<String,dynamic> map){
    return InmuebleVendido(
      id: map["id"], 
      nroTestimonio: map["numero_testimonio"], 
      usuarioComprador: Usuario.fromMap(map["usuario_comprador"])
    );
  }
  factory InmuebleVendido.vacio(){
    return InmuebleVendido(
      id: "", nroTestimonio: "", usuarioComprador: Usuario.vacio()
    );
  }
  factory InmuebleVendido.copyWith(InmuebleVendido iv){
    return InmuebleVendido(
      id: iv.id, nroTestimonio: iv.nroTestimonio, usuarioComprador: Usuario.copyWith(iv.usuarioComprador)
    );
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "numero_testimonio":this.nroTestimonio,
      "id_comprador":this.usuarioComprador.id
    };
  }
}