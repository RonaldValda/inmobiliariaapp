import 'package:inmobiliariaapp/data/repositories/generales/publicidad_repository.dart';
import 'package:inmobiliariaapp/domain/entities/publicidad.dart';

class UseCasePublicidad{
  PublicidadRepository publicidadRepository=PublicidadRepository();
  Future<Map<String,dynamic>> registrarAd(String idAd,String tipoAd){
    return publicidadRepository.registrarAd(idAd,tipoAd);
  }
  Future<Map<String,dynamic>> eliminarAd(String idAd){
    return publicidadRepository.eliminarAd(idAd);
  }
  Future<Map<String,dynamic>> obtenerAds(){
    return publicidadRepository.obtenerAds();
  }
  Future<Map<String,dynamic>> registrarPublicidad(Publicidad publicidad,int mesesVigencia){
    return publicidadRepository.registrarPublicidad(publicidad,mesesVigencia);
  }
  Future<Map<String,dynamic>> modificarPublicidad(Publicidad publicidad,int mesesVigencia){
    return publicidadRepository.modificarPublicidad(publicidad,mesesVigencia);
  }
  Future<Map<String,dynamic>> eliminarPublicidad(String id){
    return publicidadRepository.eliminarPublicidad(id);
  }
  Future<Map<String,dynamic>> obtenerPublicidades(){
    return publicidadRepository.obtenerPublicidades();
  }
}