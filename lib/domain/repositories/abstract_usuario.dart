import 'package:inmobiliariaapp/domain/entities/inmueble_reportado.dart';
import 'package:inmobiliariaapp/domain/entities/inscripcion_agente.dart';
import 'package:inmobiliariaapp/domain/entities/membresia_pago.dart';
import 'package:inmobiliariaapp/domain/entities/solicitud_administrador.dart';
import 'package:inmobiliariaapp/domain/entities/usuario.dart';
import 'package:inmobiliariaapp/domain/entities/usuarios_inmuebles_favoritos.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AbstractUsuario{
  Future<Map<String,dynamic>> crearModificarUsuario(Usuario usuario,String actividad);
  Future<Map<String,dynamic>> autenticarUsuario(Usuario usuario);
  Future<bool> modificarUsuario(Usuario usuario);
  Future<Map<String,dynamic>> obtenerUsuarioEmail(String email);
  Future<Map<String,dynamic>> obtenerUsuarioSolicitudes();
  Future<Map<String,dynamic>> responderSolicitudUsuarioCalificacion(String id,int calificacion);
  Future<Map<String,dynamic>> obtenerMembresiaPagos(String id);
  Future<Map<String,dynamic>> registrarMembresiaPago(MembresiaPago membresiaPago);
  Future<Map<String,dynamic>> registrarEmailClaveVerificaciones(String email,String actividad);
  Future<Map<String,dynamic>> obtenerEmailClaveVerificaciones(String email,int clave);
  Future<Map<String,dynamic>> autenticarUsuarioAutomatico(String email,String imeiNo, UsuarioInmuebleBase baseVisto,UsuarioInmuebleBase baseDobleVisto, UsuarioInmuebleBase baseFavorito);
  Future<Map<String,dynamic>> buscarUsuarioEmail(String email);
  Future<Map<String,dynamic>> registrarUsuarioInmuebleBuscado(String nombreConfiguracion,String numeroTelefono,Usuario usuario,Map<String,dynamic> mapInmuebleBuscado);
  Future<Map<String,dynamic>> modificarUsuarioInmuebleBuscado(UsuarioInmuebleBuscado buscado,Map<String,dynamic> mapInmuebleBuscado);
  Future<bool> modificarUsuarioInmueblesBuscadosPersonales(UsuarioInmuebleBuscado buscado);
  Future<Map<String,dynamic>> obtenerUsuarioInmueblesBuscados(Usuario usuario);
  Future<Map<String,dynamic>> registrarSolicitudInscripcionAgente(InscripcionAgente inscripcionAgente);
  Future<Map<String,dynamic>> obtenerAgentesCiudad(String ciudad);
  Future<bool> registrarUsuarioInmuebleBase(String idUsuario,UsuarioInmuebleBase baseVisto,UsuarioInmuebleBase baseDobleVisto,UsuarioInmuebleBase baseFavorito);
  Future<void> registrarUsuarioShared(Usuario usuario,Future<SharedPreferences> _prefs);
  
   
}
abstract class AbstractSuperUsuarioRepository{
  Future<Map<String,dynamic>> obtenerNotificacionesSuperUsuario(Usuario usuario,String tipoSesion);
  Future<Map<String,dynamic>> obtenerAdministradores();
  Future<Map<String,dynamic>> obtenerNotificacionesExisteSuperUsuario(Usuario usuario);
  
  Future<bool> responderReporteInmueble(InmuebleReportado reportado);
  Future<bool> responderInmuebleQueja(InmuebleQueja queja,String idSuperUsuario);
  Future<bool> responderMembresiaPagoSuperUsuario(MembresiaPago membresia,String idSuperUsuario);
  Future<bool> inhabilitarAdministradores(String idUsuario);
  Future<bool> habilitarAdministradores(String idUsuario);
  Future<Map<String,dynamic>> asignarAdministradorZona(String idAdministrador,String idZona);
  Future<bool> quitarAdministradorZona(String id);
  Future<Map<String,dynamic>> obtenerUsuariosInmueblesBuscadosCiudad(String ciudad);
  Future<Map<String,dynamic>> obtenerSolicitudesAdministradoresSuperUsuario(String id);
}
abstract class AbstractAdministradorRepository{
  Future<Map<String,dynamic>> responderSolicitudAdministrador(Usuario usuario,SolicitudAdministrador administradorInmueble,SolicitudAdministrador solicitudAdministrador);
  Future<Map<String,dynamic>> obtenerAdministradorZonas(String idAdministrador);
  Future<Map<String,dynamic>> obtenerNotificacionesAdministrador(String idAdministrador);
  Future<Map<String,dynamic>> responderSolicitudInscripcionAgente(InscripcionAgente inscripcionAgente);
  Future<Map<String,dynamic>>  obtenerSolicitudesAdministradores(String id);
}