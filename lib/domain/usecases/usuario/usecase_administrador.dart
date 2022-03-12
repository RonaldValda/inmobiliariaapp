import 'package:inmobiliariaapp/data/repositories/usuario/administrador_repository.dart';
import 'package:inmobiliariaapp/domain/entities/inscripcion_agente.dart';
import 'package:inmobiliariaapp/domain/entities/solicitud_administrador.dart';
import 'package:inmobiliariaapp/domain/entities/usuario.dart';

class UseCaseAdministrador{
  AdministradorRepository administradorRepository=AdministradorRepository();
  Future<Map<String,dynamic>> responderSolicitudAdministrador(Usuario usuario,SolicitudAdministrador administradorInmueble,SolicitudAdministrador solicitudAdministrador){
    return administradorRepository.responderSolicitudAdministrador(usuario,administradorInmueble,solicitudAdministrador);
  }
  Future<Map<String,dynamic>> obtenerAdministradorZonas(String idAdministrador){
    return administradorRepository.obtenerAdministradorZonas(idAdministrador);
  }
  Future<Map<String,dynamic>> obtenerNotificacionesAdministrador(String idAdministrador){
    return administradorRepository.obtenerNotificacionesAdministrador(idAdministrador);
  }
  Future<Map<String,dynamic>> responderSolicitudInscripcionAgente(InscripcionAgente inscripcionAgente){
    return administradorRepository.responderSolicitudInscripcionAgente(inscripcionAgente);
  }
  Future<Map<String,dynamic>> obtenerSolicitudesAdministradores(String id){
    return administradorRepository.obtenerSolicitudesAdministradores(id);
  }
}