
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/domain/entities/user.dart';

import '../../../data/repositories/property/property_repository.dart';

class UseCaseProperty{
  PropertyRepository propertyRepository=PropertyRepository();

  Future<Map<String,dynamic>> getProperties(User user, String sessionType, String city){
    return propertyRepository.getProperties(user,sessionType,city);
  }
  Future<bool> registerPropertyFavorite(User user, PropertyTotal propertyTotal) {
    return propertyRepository.registerPropertyFavorite(user, propertyTotal);
  }

  Future<Map<String,dynamic>> registerUpdateProperty(PropertyTotal propertyTotal,String sessionType){
    return propertyRepository.registerUpdateProperty(propertyTotal, sessionType);
  }
}