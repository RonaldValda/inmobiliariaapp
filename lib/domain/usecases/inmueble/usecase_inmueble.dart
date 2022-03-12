import 'package:inmobiliariaapp/data/repositories/inmueble/inmueble_repository.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/domain/entities/usuario.dart';

class UseCaseInmueble{
  InmuebleRepository inmuebleRepository=InmuebleRepository();

  Future<Map<String,dynamic>> listarInmuebles(Usuario usuario, String tipoSesion, String ciudad){
    return inmuebleRepository.listarInmuebles(usuario,tipoSesion,ciudad);
  }
  Future<bool> registrarFavoritos(Usuario usuario, InmuebleTotal inmuebleTotal) {
    return inmuebleRepository.registrarFavoritos(usuario, inmuebleTotal);
  }
}