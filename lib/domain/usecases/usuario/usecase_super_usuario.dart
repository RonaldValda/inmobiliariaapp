import 'package:inmobiliariaapp/data/repositories/usuario/super_usuario_repository.dart';
import 'package:inmobiliariaapp/domain/entities/banco.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_reportado.dart';
import 'package:inmobiliariaapp/domain/entities/membresia_pago.dart';
import 'package:inmobiliariaapp/domain/entities/membresia_planes_pago.dart';
import 'package:inmobiliariaapp/domain/entities/planes_pago_publicacion.dart';
import 'package:inmobiliariaapp/domain/entities/publicidad.dart';
import 'package:inmobiliariaapp/domain/entities/usuario.dart';

class UseCaseSuperUsuario{
  SuperUsuarioRepository superUsuarioRepository=SuperUsuarioRepository();
  
  Future<Map<String,dynamic>> obtenerNotificacionesSuperUsuario(Usuario usuario,String tipoSesion){
    return superUsuarioRepository.obtenerNotificacionesSuperUsuario(usuario,tipoSesion);
  }
  Future<Map<String,dynamic>> obtenerAdministradores(){
    return superUsuarioRepository.obtenerAdministradores();
  }
  Future<Map<String,dynamic>> obtenerNotificacionesExisteSuperUsuario(Usuario usuario){
    return superUsuarioRepository.obtenerNotificacionesExisteSuperUsuario(usuario);
  }
  
  
  Future<bool> responderReporteInmueble(InmuebleReportado reportado){
    return superUsuarioRepository.responderReporteInmueble(reportado);
  }
  Future<bool> responderInmuebleQueja(InmuebleQueja queja,String idSuperUsuario){
    return superUsuarioRepository.responderInmuebleQueja(queja,idSuperUsuario);
  }
  Future<bool> responderMembresiaPagoSuperUsuario(MembresiaPago membresia,String idSuperUsuario){
    return superUsuarioRepository.responderMembresiaPagoSuperUsuario(membresia,idSuperUsuario);
  }
  Future<bool> inhabilitarAdministradores(String idUsuario){
    return superUsuarioRepository.inhabilitarAdministradores(idUsuario);
  }
  Future<bool> habilitarAdministradores(String idUsuario){
    return superUsuarioRepository.habilitarAdministradores(idUsuario);
  }
  Future<Map<String,dynamic>> asignarAdministradorZona(String idAdministrador,String idZona){
    return superUsuarioRepository.asignarAdministradorZona(idAdministrador,idZona);
  }
  Future<bool> quitarAdministradorZona(String id){
    return superUsuarioRepository.quitarAdministradorZona(id);
  }
  
  Future<Map<String,dynamic>> obtenerUsuariosInmueblesBuscadosCiudad(String ciudad){
    return superUsuarioRepository.obtenerUsuariosInmueblesBuscadosCiudad(ciudad);
  }
  Future<Map<String,dynamic>> obtenerSolicitudesAdministradoresSuperUsuario(String id){
    return superUsuarioRepository.obtenerSolicitudesAdministradoresSuperUsuario(id);
  }
}