import 'package:inmobiliariaapp/domain/entities/property_reported.dart';
import 'package:inmobiliariaapp/domain/entities/agent_registration.dart';
import 'package:inmobiliariaapp/domain/entities/membership_payment.dart';
import 'package:inmobiliariaapp/domain/entities/administrator_request.dart';
import 'package:inmobiliariaapp/domain/entities/user.dart';
import 'package:inmobiliariaapp/domain/entities/user_property_favorite.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AbstractUser{
  Future<Map<String,dynamic>> createUpdateUser(User user,String activity);
  Future<Map<String,dynamic>> authenticateUser(User user);
  Future<bool> updateUser(User user);
  Future<Map<String,dynamic>> getUserEmail(String email);
  Future<Map<String,dynamic>> getUserRequests();
  Future<Map<String,dynamic>> answerUserQualificationRequest(String id,int qualification);
  Future<Map<String,dynamic>> getMembershipPayments(String id);
  Future<Map<String,dynamic>> registerMembershipPayment(MembershipPayment membershipPayment);
  Future<Map<String,dynamic>> registerEmailKeyVerifications(String email,String activity);
  Future<Map<String,dynamic>> getEmailKeyVerifications(String email,int key);
  Future<Map<String,dynamic>> authenticateUserAutomatic(String email,String imeiNumber, UserPropertyBase viewedBase,UserPropertyBase viewedDoubleBase, UserPropertyBase favoriteBase);
  Future<Map<String,dynamic>> searchUserEmail(String email);
  Future<Map<String,dynamic>> registerUserPropertySearched(User user,UserPropertySearched searched);
  Future<Map<String,dynamic>> updateUserPropertySearched(UserPropertySearched userPropertySearched);
  Future<bool> updateUserPropertySearchedPersonalInformation(UserPropertySearched userPropertySearched);
  Future<Map<String,dynamic>> getUserPropertiesSearcheds(User user);
  Future<Map<String,dynamic>> registerAgentRegistrationRequest(AgentRegistration agentRegistration);
  Future<Map<String,dynamic>> getAgentsCity(String city);
  Future<bool> registerUserPropertyBase(String userId,UserPropertyBase viewedBase,UserPropertyBase viewedDoubleBase, UserPropertyBase favoriteBase);
  Future<void> registerUserShared(User user,Future<SharedPreferences> _prefs);
  Future<void> registerInitialCityShared(String initialCity,Future<SharedPreferences> _prefs);
   
}
abstract class AbstractSuperUserRepository{
  Future<Map<String,dynamic>> getNotificationsSuperUser(User user,String sessionType);
  Future<Map<String,dynamic>> getAdministrators();
  Future<Map<String,dynamic>> getNotificationsExistsSuperUser(User user);
  
  Future<bool> answerPropertyReport(PropertyReported propertyReported);
  Future<bool> answerPropertyComplaint(PropertyComplaint propertyComplaint,String superUserId);
  Future<bool> answerMembershipPaymentSuperUser(MembershipPayment membershipPayment, String superUserId);
  Future<bool> enableAdministrator(String usuarioId);
  Future<bool> disableAdministrator(String usuarioId);
  Future<Map<String,dynamic>> assignAdministratorZone(String administratorI,String zoneId);
  Future<bool> removeAdministratorZone(String id);
  Future<Map<String,dynamic>> getUsersPropertiesSearchedsCity(String city);
  Future<Map<String,dynamic>> getAdministratorsRequestsSuperUser(String id);
  Future<Map<String,dynamic>> answerAgentRegistrationRequestSuperUser(AgentRegistration agentRegistration);
  Future<Map<String,dynamic>> answerAdministratorRequestSuperUser(User user,AdministratorRequest administratorProperty,AdministratorRequest administratorRequest);
}
abstract class AbstractAdministratorRepository{
  Future<Map<String,dynamic>> answerAdministratorRequest(User user,AdministratorRequest administratorProperty,AdministratorRequest administratorRequest);
  Future<Map<String,dynamic>> getAdministratorZones(String administratorId);
  Future<Map<String,dynamic>> getNotificationsAdministrator(String administradorId);
  Future<Map<String,dynamic>> answerAgentRegistrationRequest(AgentRegistration agentRegistration);
  Future<Map<String, dynamic>> getAdministratorsRequests(String id);
}