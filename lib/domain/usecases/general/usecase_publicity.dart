import 'package:inmobiliariaapp/data/repositories/generals/publicity_repository.dart';
import 'package:inmobiliariaapp/domain/entities/publicity.dart';

class UseCasePublicity{
  PublicityRepository publicityRepository=PublicityRepository();
  Future<Map<String,dynamic>> registerAd(String adId,String adType){
    return publicityRepository.registerAd(adId,adType);
  }
  Future<Map<String,dynamic>> deleteAd(String adId){
    return publicityRepository.deleteAd(adId);
  }
  Future<Map<String,dynamic>> getAds(){
    return publicityRepository.getAds();
  }
  Future<Map<String,dynamic>> registerPublicity(Publicity publicity,int monthsValidity){
    return publicityRepository.registerPublicity(publicity,monthsValidity);
  }
  Future<Map<String,dynamic>> updatePublicity(Publicity publicity,int monthsValidity){
    return publicityRepository.updatePublicity(publicity,monthsValidity);
  }
  Future<Map<String,dynamic>> deletePublicity(String id){
    return publicityRepository.deletePublicity(id);
  }
  Future<Map<String,dynamic>> getPublicities(){
    return publicityRepository.getPublicities();
  }
}