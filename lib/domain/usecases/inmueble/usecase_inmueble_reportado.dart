import 'package:inmobiliariaapp/data/repositories/inmueble/inmueble_reportado_repository.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_reportado.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/domain/entities/solicitud_administrador.dart';
import 'package:inmobiliariaapp/domain/entities/usuario.dart';

class UseCaseInmuebleReportado{
  InmuebleReportadoRepository inmuebleReportadoRepository=InmuebleReportadoRepository();
  Future<List<SolicitudAdministrador>> obtenerReportesInmueble(Usuario usuario,InmuebleTotal inmuebleTotal,bool estado1,bool estado2){
    return inmuebleReportadoRepository.obtenerReportesInmueble(usuario,inmuebleTotal,estado1,estado2);
  }
  Future<bool> reportarInmueble(InmuebleReportado reportado){
    return inmuebleReportadoRepository.reportarInmueble(reportado);
  }
}