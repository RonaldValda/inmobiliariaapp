import 'package:inmobiliariaapp/data/repositories/property/property_base_repository.dart';
import 'package:inmobiliariaapp/domain/entities/user_property_favorite.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UseCasePropertyBase{
  PropertyBaseRepository propertyBaseRepository=PropertyBaseRepository();
  Future<bool> updateDatePropertyBase(String id,String date){
    return propertyBaseRepository.updateDatePropertyBase(id,date);
  }
  Future<void> registerPropertyBase(List<UserPropertyBase> userPropertyBases, Future<SharedPreferences> _prefs){
    return propertyBaseRepository.registerPropertyBase(userPropertyBases,_prefs);
  }
  Future<Map<String, dynamic>> searchPropertyBaseShared(Future<SharedPreferences> _prefs){
    return propertyBaseRepository.searchPropertyBaseShared(_prefs);
  }
}