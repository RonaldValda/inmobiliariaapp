import 'package:inmobiliariaapp/data/repositories/inmueble/inmueble_base_repository.dart';
import 'package:inmobiliariaapp/domain/entities/usuarios_inmuebles_favoritos.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UseCaseInmuebleBase{
  InmuebleBaseRepository inmuebleBaseRepository=InmuebleBaseRepository();
  Future<bool> actualizarFechaInmuebleBase(String id,String fecha){
    return inmuebleBaseRepository.actualizarFechaInmuebleBase(id,fecha);
  }
  Future<void> registrarInmuebleBase(List<UsuarioInmuebleBase> usuarioInmuebleBases, Future<SharedPreferences> _prefs){
    return inmuebleBaseRepository.registrarInmuebleBase(usuarioInmuebleBases,_prefs);
  }
  Future<Map<String, dynamic>> buscarInmuebleBaseShared(Future<SharedPreferences> _prefs){
    return inmuebleBaseRepository.buscarInmuebleBaseShared(_prefs);
  }
}