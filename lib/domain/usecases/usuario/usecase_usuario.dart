import 'package:inmobiliariaapp/data/repositories/usuario/usuario_repository.dart';
import 'package:inmobiliariaapp/domain/entities/inscripcion_agente.dart';
import 'package:inmobiliariaapp/domain/entities/membresia_pago.dart';
import 'package:inmobiliariaapp/domain/entities/usuario.dart';
import 'package:inmobiliariaapp/domain/entities/usuarios_inmuebles_favoritos.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UseCaseUsuario{
  UsuarioRepository usuarioRepository=UsuarioRepository();
  Future<Map<String,dynamic>> auntenticarUsuario(Usuario usuario){
    return usuarioRepository.autenticarUsuario(usuario);
  }
  Future<Map<String,dynamic>> obtenerUsuarioInmueblesBuscados(Usuario usuario){
    return usuarioRepository.obtenerUsuarioInmueblesBuscados(usuario);
  } 
  Future<Map<String,dynamic>> responderSolicitudUsuarioCalificacion(String id,int calificacion){
    return usuarioRepository.responderSolicitudUsuarioCalificacion(id,calificacion);
  }   
  Future<Map<String,dynamic>> registrarEmailClaveVerificaciones(String email,String actividad){
    return usuarioRepository.registrarEmailClaveVerificaciones(email,actividad);
  }
  Future<Map<String,dynamic>> obtenerEmailClaveVerificaciones(String email,int clave){
    return usuarioRepository.obtenerEmailClaveVerificaciones(email,clave);
  }
  Future<Map<String,dynamic>> crearModificarUsuario(Usuario usuario,String actividad){
      return usuarioRepository.crearModificarUsuario(usuario,actividad);
  }
  Future<Map<String,dynamic>> buscarUsuarioEmail(String email){
    return usuarioRepository.buscarUsuarioEmail(email);
  }
  Future<Map<String,dynamic>> registrarMembresiaPago(MembresiaPago membresiaPago){
    return usuarioRepository.registrarMembresiaPago(membresiaPago);
  }
  Future<Map<String,dynamic>> obtenerMembresiaPagos(String id){
    return usuarioRepository.obtenerMembresiaPagos(id);
  }
  Future<Map<String,dynamic>> autenticarUsuarioAutomatico(String email,String imeiNo,UsuarioInmuebleBase baseVisto,UsuarioInmuebleBase baseDobleVisto,UsuarioInmuebleBase baseFavorito){
    return usuarioRepository.autenticarUsuarioAutomatico(email,imeiNo,baseVisto,baseDobleVisto,baseFavorito);
  }
  Future<bool> modificarUsuario(Usuario usuario){
    return usuarioRepository.modificarUsuario(usuario);
  }
  Future<bool> modificarUsuarioInmueblesBuscadosPersonales(UsuarioInmuebleBuscado buscado){
    return usuarioRepository.modificarUsuarioInmueblesBuscadosPersonales(buscado);
  }
  Future<Map<String,dynamic>> modificarUsuarioInmuebleBuscado(UsuarioInmuebleBuscado buscado,Map<String,dynamic> mapInmuebleBuscado){
    return usuarioRepository.modificarUsuarioInmuebleBuscado(buscado,mapInmuebleBuscado);
  }
  Future<Map<String,dynamic>> registrarSolicitudInscripcionAgente(InscripcionAgente inscripcionAgente){
    return usuarioRepository.registrarSolicitudInscripcionAgente(inscripcionAgente);
  }
  Future<Map<String,dynamic>> obtenerAgentesCiudad(String ciudad){
    return usuarioRepository.obtenerAgentesCiudad(ciudad);
  }
  Future<Map<String,dynamic>> registrarUsuarioInmuebleBuscado(String nombreConfiguracion,String numeroTelefono,Usuario usuario,Map<String,dynamic> mapInmuebleBuscado){
    return usuarioRepository.registrarUsuarioInmuebleBuscado(nombreConfiguracion,numeroTelefono,usuario,mapInmuebleBuscado);
  }
  Future<void> registrarUsuarioShared(Usuario usuario, Future<SharedPreferences> _prefs){
   return usuarioRepository.registrarUsuarioShared(usuario,_prefs); 
  }
}