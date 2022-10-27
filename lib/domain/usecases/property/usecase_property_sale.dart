import 'package:inmobiliariaapp/data/repositories/property/property_sale_repository.dart';
import 'package:inmobiliariaapp/domain/entities/property_reported.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';

class UseCasePropertySale{
  PropertySaleRepository propertySaleRepository=PropertySaleRepository();

  Future<bool> updatePropertyStatus(PropertyTotal propertyTotal,String actionType){
    return propertySaleRepository.updatePropertyStatus(propertyTotal,actionType);
  }
  Future<Map<String,dynamic>> registerPropertyComplaint(PropertyComplaint propertyComplaint){
    return propertySaleRepository.registerPropertyComplaint(propertyComplaint);
  }
  Future<Map<String,dynamic>> getNotificationsActionsSalesperson(String propertyId){
    return propertySaleRepository.getNotificationsActionsSalesperson(propertyId);
  }
  Future<Map<String,dynamic>> updatePropertyPrice(PropertyTotal propertyTotal){
    return propertySaleRepository.updatePropertyPrice(propertyTotal);
  }
  Future<Map<String,dynamic>> readAdministratorRequestUser(String requestId){
    return propertySaleRepository.readAdministratorRequestUser(requestId);
  }
  Future<Map<String,dynamic>> getComplaintsReportsProperty(String propertyId){
    return propertySaleRepository.getComplaintsReportsProperty(propertyId);
  }
  Future<Map<String,dynamic>> closeOperationsProperty(PropertyTotal propertyTotal){
    return propertySaleRepository.closeOperationsProperty(propertyTotal);
  }
}