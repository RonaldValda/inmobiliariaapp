import 'package:inmobiliariaapp/data/repositories/property/property_reported_repository.dart';
import 'package:inmobiliariaapp/domain/entities/property_reported.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/domain/entities/user.dart';

class UseCasePropertyReported{
  PropertyReportedRepository propertyReportedRepository=PropertyReportedRepository();
  Future<Map<String,dynamic>> getReportsProperty(User user,PropertyTotal propertyTotal,bool status1,bool status2){
    return propertyReportedRepository.getReportsProperty(user,propertyTotal,status1,status2);
  }
  Future<bool> reportProperty(PropertyReported propertyReported){
    return propertyReportedRepository.reportProperty(propertyReported);
  }
}