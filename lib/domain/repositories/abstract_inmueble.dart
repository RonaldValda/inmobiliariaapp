import 'package:inmobiliariaapp/domain/entities/inmueble_reportado.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/domain/entities/solicitud_administrador.dart';
import 'package:inmobiliariaapp/domain/entities/usuario.dart';
import 'package:inmobiliariaapp/domain/entities/usuarios_inmuebles_favoritos.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AbstractInmuebleRepository{
  Future<Map<String,dynamic>> listarInmuebles(Usuario usuario,String tipoSesion,String ciudad,);
  Future<bool> registrarFavoritos(Usuario usuario,InmuebleTotal inmuebleTotal);
}
abstract class AbstractInmuebleVentaRepository{
  Future<bool> modificarEstadoInmueble(InmuebleTotal inmuebleTotal,String tipoAccion);
  Future<Map<String,dynamic>> registrarInmuebleQueja(InmuebleQueja inmuebleQueja);
  Future<Map<String,dynamic>> obtenerNotificacionesAccionesVendedor(String idInmueble);
  Future<Map<String,dynamic>> actualizarPrecioInmueble(String id,int precio);
}
abstract class AbstractInmuebleBaseRepository{
  Future<bool> actualizarFechaInmuebleBase(String id,String fecha);
  Future<void> registrarInmuebleBase(List<UsuarioInmuebleBase> usuarioInmuebleBases,Future<SharedPreferences> _prefs);
  Future<Map<String,dynamic>> buscarInmuebleBaseShared(Future<SharedPreferences> _prefs);
}
abstract class AbstractInmuebleReportadoRepository{
  Future<bool> reportarInmueble(InmuebleReportado reportado);
  Future<List<SolicitudAdministrador>> obtenerReportesInmueble(Usuario usuario,InmuebleTotal inmuebleTotal,bool estado1,bool estado2);
}