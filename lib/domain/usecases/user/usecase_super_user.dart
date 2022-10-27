
import 'package:inmobiliariaapp/data/repositories/user/super_user_repository.dart';
import 'package:inmobiliariaapp/domain/entities/administrator_request.dart';
import 'package:inmobiliariaapp/domain/entities/property_reported.dart';
import 'package:inmobiliariaapp/domain/entities/membership_payment.dart';
import 'package:inmobiliariaapp/domain/entities/user.dart';

class UseCaseSuperUser{
  SuperUserRepository superUserRepository=SuperUserRepository();
  
  Future<Map<String,dynamic>> getNotificationsSuperUser(User user,String sessionType){
    return superUserRepository.getNotificationsSuperUser(user,sessionType);
  }
  Future<Map<String,dynamic>> getAdministrators(){
    return superUserRepository.getAdministrators();
  }
  Future<Map<String,dynamic>> getNotificationsExistsSuperUser(User user){
    return superUserRepository.getNotificationsExistsSuperUser(user);
  }
  Future<bool> answerPropertyReport(PropertyReported propertyReported){
    return superUserRepository.answerPropertyReport(propertyReported);
  }
  Future<bool> answerPropertyComplaint(PropertyComplaint propertyComplaint,String superUserId){
    return superUserRepository.answerPropertyComplaint(propertyComplaint,superUserId);
  }
  Future<bool> answerMembershipPaymentSuperUser(MembershipPayment membershipPayment,String superUserId){
    return superUserRepository.answerMembershipPaymentSuperUser(membershipPayment,superUserId);
  }
  Future<bool> disableAdministrator(String userId){
    return superUserRepository.disableAdministrator(userId);
  }
  Future<bool> enableAdministrator(String userId){
    return superUserRepository.enableAdministrator(userId);
  }
  Future<Map<String,dynamic>> assignAdministratorZone(String administratorId,String zoneId){
    return superUserRepository.assignAdministratorZone(administratorId,zoneId);
  }
  Future<bool> removeAdministratorZone(String id){
    return superUserRepository.removeAdministratorZone(id);
  }
  
  Future<Map<String,dynamic>> getUsersPropertiesSearchedsCity(String city){
    return superUserRepository.getUsersPropertiesSearchedsCity(city);
  }
  Future<Map<String,dynamic>> getAdministratorsRequestsSuperUser(String id){
    return superUserRepository.getAdministratorsRequestsSuperUser(id);
  }
  Future<Map<String,dynamic>> answerAdministratorRequestSuperUser(User user,AdministratorRequest administratorPropery,AdministratorRequest administratorRequest){
    return superUserRepository.answerAdministratorRequestSuperUser(user,administratorPropery,administratorRequest);
  }
}