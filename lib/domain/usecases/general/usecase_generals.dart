import 'package:inmobiliariaapp/data/repositories/generals/generals_repository.dart';
import 'package:inmobiliariaapp/domain/entities/generals.dart';

class UseCaseGenerals{
  GeneralsRepository generalsRepository=GeneralsRepository();
  Future<bool> deleteCity(String id){
    return generalsRepository.deleteCity(id);
  }
  Future<bool> deleteDepartament(String id){
    return generalsRepository.deleteDepartament(id);
  }
  Future<bool> deleteZone(String id){
    return generalsRepository.deleteZone(id);
  }
  Future<bool> updateCity(String id,String cityName){
    return generalsRepository.updateCity(id,cityName);
  }
  Future<bool> updateDepartament(String id,String departamentName){
    return generalsRepository.updateDepartament(id,departamentName);
  }
  Future<bool> updateZone(Zone zone){
    return generalsRepository.updateZone(zone);
  }
  Future<Map<String,dynamic>> getCities(String departamentId){
    return generalsRepository.getCities(departamentId);
  }
  Future<Map<String,dynamic>> getDepartaments(){
    return generalsRepository.getDepartaments();
  }
  Future<Map<String,dynamic>> getGeneralsPlaces(){
    return generalsRepository.getGeneralsPlaces();
  }
  Future<Map<String,dynamic>> getZones(String cityId){
    return generalsRepository.getZones(cityId);
  }
  Future<Map<String,dynamic>> registerCity(String departamentId,String cityName){
    return generalsRepository.registerCity(departamentId,cityName);
  }
  Future<Map<String,dynamic>> registerDepartament(String departamentName){
    return generalsRepository.registerDepartament(departamentName);
  }
  Future<Map<String,dynamic>> registerZone(String cityId,Zone zone){
    return generalsRepository.registerZone(cityId,zone);
  } 
  Future<Map<String,dynamic>> getAppVersion(){
    return generalsRepository.getAppVersion();
  }
}