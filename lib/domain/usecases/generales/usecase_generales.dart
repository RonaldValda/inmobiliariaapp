import 'package:inmobiliariaapp/data/repositories/generales/generales_repository.dart';
import 'package:inmobiliariaapp/domain/entities/generales.dart';

class UseCaseGenerales{
  GeneralesRepository generalesRepository=GeneralesRepository();
  Future<bool> eliminarCiudad(String id){
    return generalesRepository.eliminarCiudad(id);
  }
  Future<bool> eliminarDepartamento(String id){
    return generalesRepository.eliminarDepartamento(id);
  }
  Future<bool> eliminarZona(String id){
    return generalesRepository.eliminarZona(id);
  }
  Future<bool> modificarCiudad(String id,String nombreCiudad){
    return generalesRepository.modificarCiudad(id,nombreCiudad);
  }
  Future<bool> modificarDepartamento(String id,String nombreDepartamento){
    return generalesRepository.modificarDepartamento(id,nombreDepartamento);
  }
  Future<bool> modificarZona(Zona zona){
    return generalesRepository.modificarZona(zona);
  }
  Future<Map<String,dynamic>> obtenerCiudades(String idDepartamento){
    return generalesRepository.obtenerCiudades(idDepartamento);
  }
  Future<Map<String,dynamic>> obtenerDepartamentos(){
    return generalesRepository.obtenerDepartamentos();
  }
  Future<Map<String,dynamic>> obtenerGeneralesLugares(){
    return generalesRepository.obtenerGeneralesLugares();
  }
  Future<Map<String,dynamic>> obtenerZonas(String idCiudad){
    return generalesRepository.obtenerZonas(idCiudad);
  }
  Future<Map<String,dynamic>> registrarCiudad(String idDepartamento,String nombreCiudad){
    return generalesRepository.registrarCiudad(idDepartamento,nombreCiudad);
  }
  Future<Map<String,dynamic>> registrarDepartamento(String nombreDepartamento){
    return generalesRepository.registrarDepartamento(nombreDepartamento);
  }
  Future<Map<String,dynamic>> registrarZona(String idCiudad,Zona zona){
    return generalesRepository.registrarZona(idCiudad,zona);
  } 
  Future<Map<String,dynamic>> obtenerVersionApp(){
    return generalesRepository.obtenerVersionApp();
  }
}