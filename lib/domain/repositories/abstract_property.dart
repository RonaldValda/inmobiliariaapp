import 'package:inmobiliariaapp/domain/entities/property.dart';
import 'package:inmobiliariaapp/domain/entities/property_reported.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/domain/entities/user.dart';
import 'package:inmobiliariaapp/domain/entities/user_property_favorite.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AbstractPropertyRepository{
  Future<Map<String,dynamic>> getProperties(User user,String sessionType,String city,);
  Future<Map<String,dynamic>> registerUpdateProperty(PropertyTotal propertyTotal,String sessionType);
  Future<bool> registerPropertyFavorite(User user,PropertyTotal propertyTotal);
}
abstract class AbstractPropertySaleRepository{
  Future<bool> updatePropertyStatus(PropertyTotal propertyTotal,String actionType);
  Future<Map<String,dynamic>> registerPropertyComplaint(PropertyComplaint propertyComplaint);
  Future<Map<String,dynamic>> getNotificationsActionsSalesperson(String propertyId);
  Future<Map<String,dynamic>> updatePropertyPrice(PropertyTotal propertyTotal);
  Future<Map<String,dynamic>> readAdministratorRequestUser(String requestId);
  Future<Map<String,dynamic>> getComplaintsReportsProperty(String propertyId);
  Future<Map<String,dynamic>> closeOperationsProperty(PropertyTotal propertyTotal);
}
abstract class AbstractPropertyBaseRepository{
  Future<bool> updateDatePropertyBase(String id,String date);
  Future<void> registerPropertyBase(List<UserPropertyBase> userPropertyBases,Future<SharedPreferences> _prefs);
  Future<Map<String,dynamic>> searchPropertyBaseShared(Future<SharedPreferences> _prefs);
}
abstract class AbstractPropertyReportedRepository{
  Future<bool> reportProperty(PropertyReported propertyReported);
  Future<Map<String,dynamic>> getReportsProperty(User user,PropertyTotal propertyTotal,bool status1,bool status2);
}
abstract class AbstractPropertyNoteRepository{
  Future<Map<String,dynamic>> savePropertyNote(String propertyId,String userId,PropertyClientNote propertyClientNote);
  Future<Map<String,dynamic>> searchPropertyNote(String propertyId,String userId);
}