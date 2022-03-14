

import 'package:inmobiliariaapp/domain/entities/membresia_planes_pago.dart';
import 'package:inmobiliariaapp/domain/entities/usuario.dart';
import 'package:inmobiliariaapp/domain/entities/banco.dart';

class MembresiaPago{
  String id;
  String fechaSolicitud;
  String medioPago;
  int montoPago;
  MembresiaPlanesPago membresiaPlanesPago;
  String numeroTransaccion;
  CuentaBanco cuentaBanco;
  String nombreDepositante;
  dynamic linkImagenDeposito;
  String autorizacion;
  String observaciones;
  bool respuestaEntregada;
  String fechaSolicitudSuperUsuario;
  String fechaRespuestaSuperUsuario;
  String autorizacionSuperUsuario;
  bool respuestaEntregadaSuperUsuario;
  String observacionesSuperUsuario;
  String fechaInicio;
  String fechaFinal;
  bool activo;
  String fechaCancelacion;
  String motivoCancelacion;
  Usuario usuario;
  Usuario administrador;
  Usuario superUsuario;
  MembresiaPago({
    required this.id,
    required this.fechaSolicitud,
    required this.medioPago,required this.montoPago,
    required this.membresiaPlanesPago,required this.numeroTransaccion,
    required this.cuentaBanco,required this.nombreDepositante,
    required this.linkImagenDeposito,required this.autorizacion,
    required this.observaciones,required this.respuestaEntregada,
    required this.fechaSolicitudSuperUsuario,required this.fechaRespuestaSuperUsuario,
    required this.autorizacionSuperUsuario, required this.respuestaEntregadaSuperUsuario,
    required this.observacionesSuperUsuario,
    required this.fechaInicio,required this.fechaFinal, required this.activo,
    required this.fechaCancelacion,required this.motivoCancelacion,
    required this.usuario,required this.administrador,required this.superUsuario
  });
  factory MembresiaPago.vacio(){
    return MembresiaPago(
      id:"",
      fechaSolicitud: "",
      medioPago: "", montoPago: 0, 
      membresiaPlanesPago:MembresiaPlanesPago.vacio(), numeroTransaccion: "",
      cuentaBanco: CuentaBanco.vacio(),nombreDepositante: "",
      linkImagenDeposito: "",autorizacion: "",
      observaciones: "",respuestaEntregada: false,
      fechaSolicitudSuperUsuario: "",fechaRespuestaSuperUsuario: "",
      autorizacionSuperUsuario: "",observacionesSuperUsuario: "",
      respuestaEntregadaSuperUsuario: false,
      fechaInicio: "",fechaFinal: "",activo: false,
      fechaCancelacion: "",motivoCancelacion: "",
      usuario: Usuario.vacio(),administrador: Usuario.vacio(),
      superUsuario: Usuario.vacio()
    );
  }
  factory MembresiaPago.fromMap(Map<String,dynamic> map){
    return MembresiaPago(
      id: map["id"],
      fechaSolicitud: map["fecha_solicitud"],
      medioPago: map["medio_pago"],montoPago: map["monto_pago"],
      membresiaPlanesPago: map["membresia_planes_pago"]!=null?MembresiaPlanesPago.fromMap(map["membresia_planes_pago"]):MembresiaPlanesPago.vacio(),numeroTransaccion: map["numero_transaccion"],
      cuentaBanco: CuentaBanco.fromMap(map["cuenta_banco"]),nombreDepositante: map["nombre_depositante"],
      linkImagenDeposito: map["link_imagen_deposito"],autorizacion: map["autorizacion"],
      observaciones: map["observaciones"],respuestaEntregada: map["respuesta_entregada"],
      fechaSolicitudSuperUsuario: map["fecha_solicitud_super_usuario"]??"",
      fechaRespuestaSuperUsuario: map["fecha_respuesta_super_usuario"]??"",
      autorizacionSuperUsuario: map["autorizacion_super_usuario"]??"",
      observacionesSuperUsuario: map["observaciones_super_usuario"]??"",
      respuestaEntregadaSuperUsuario: map["respuesta_entregada_super_usuario"]??false,
      fechaInicio: map["fecha_inicio"]!=null?map["fecha_inicio"]:"",
      fechaFinal: map["fecha_final"]!=null?map["fecha_final"]:"",
      activo: map["activo"]??false,fechaCancelacion: map["fecha_cancelacion"]!=null?map["fecha_cancelacion"]:"",
      motivoCancelacion: map["motivo_cancelacion"]!=null?map["motivo_cancelacion"]:"",
      usuario: Usuario.fromMap(map["usuario"]),
      administrador: map["administrador"]!=null?Usuario.fromMap(map["administrador"]):Usuario.vacio(),
      superUsuario: map["super_usuario"]!=null?Usuario.fromMap(map["super_usuario"]):Usuario.vacio()
    );
  }
  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":this.id,
      "medio_pago":this.medioPago,
      "monto_pago":this.montoPago,
      "membresia_planes_pago":this.membresiaPlanesPago.id,
      "numero_transaccion":this.numeroTransaccion,
      "cuenta_banco":this.cuentaBanco.id,
      "nombre_depositante":this.nombreDepositante,
      "link_imagen_deposito":this.linkImagenDeposito,
      "observaciones":this.observaciones,
      "usuario":this.usuario.id,
      "observaciones_super_usuario":this.observacionesSuperUsuario,
      "autorizacion_super_usuario":this.autorizacionSuperUsuario
    };
  }
  void membresiaPagoCopy(MembresiaPago mp){
    this.id=mp.id;
    this.activo=mp.activo;
    this.administrador=Usuario.copyWith(mp.administrador);
    this.usuario=Usuario.copyWith(mp.usuario);
    this.superUsuario=Usuario.copyWith(mp.superUsuario);
    this.autorizacion=mp.autorizacion;
    this.cuentaBanco=mp.cuentaBanco;
    this.fechaCancelacion=mp.fechaCancelacion;
    this.fechaInicio=mp.fechaInicio;
    this.fechaSolicitud=mp.fechaSolicitud;
    this.linkImagenDeposito=mp.linkImagenDeposito;
    this.medioPago=mp.medioPago;
    this.montoPago=mp.montoPago;
    this.motivoCancelacion=mp.motivoCancelacion;
    this.nombreDepositante=mp.nombreDepositante;
    this.numeroTransaccion=mp.numeroTransaccion;
    this.observaciones=mp.observaciones;
    this.membresiaPlanesPago=MembresiaPlanesPago.copyWith(mp.membresiaPlanesPago);
    this.respuestaEntregada=mp.respuestaEntregada;
    this.fechaSolicitudSuperUsuario=mp.fechaSolicitudSuperUsuario;
    this.fechaRespuestaSuperUsuario=mp.fechaRespuestaSuperUsuario;
    this.autorizacionSuperUsuario=mp.autorizacionSuperUsuario;
    this.observacionesSuperUsuario=mp.observacionesSuperUsuario;
    this.respuestaEntregadaSuperUsuario=mp.respuestaEntregadaSuperUsuario;
  }
}