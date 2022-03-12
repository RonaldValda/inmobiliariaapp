

import 'package:inmobiliariaapp/domain/entities/usuario.dart';
class SolicitudAdministradorAgente{
  String id;
  Usuario administrador;
  String fechaSolicitud;
  String fechaRespuesta;
  String tipoSolicitud;
  String respuesta;
  String observaciones;
  String linkRespaldoSolicitud;
  String linkRespaldoRespuesta;
  bool solicitudTerminada;
  int mes;
  String medioPago;
  int numeroPlan;
  int montoPago;
  SolicitudAdministradorAgente({
    required this.id,
    required this.administrador,
    required this.fechaSolicitud,
    required this.fechaRespuesta,
    required this.tipoSolicitud,
    required this.respuesta,
    required this.observaciones,
    required this.linkRespaldoSolicitud,
    required this.linkRespaldoRespuesta,
    required this.solicitudTerminada,
    required this.mes,
    required this.medioPago,
    required this.numeroPlan,
    required this.montoPago
  });
}