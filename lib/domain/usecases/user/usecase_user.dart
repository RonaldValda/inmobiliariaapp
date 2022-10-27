

import 'package:inmobiliariaapp/data/repositories/user/user_repository.dart';
import 'package:inmobiliariaapp/domain/entities/agent_registration.dart';
import 'package:inmobiliariaapp/domain/entities/membership_payment.dart';
import 'package:inmobiliariaapp/domain/entities/user.dart';
import 'package:inmobiliariaapp/domain/entities/user_property_favorite.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/services/authentication_external_repository.dart';

class UseCaseUser{
  UserRepository userRepository=UserRepository();
  Future<Map<String,dynamic>> authenticateUser({required User user,required List<UserPropertyBase> userPropertyBasesCache,String authMethod="Creada"})async{
    Future<SharedPreferences> _prefs=SharedPreferences.getInstance();
    Map<String,dynamic> mapResponse={};
    AuthenticationExternalRepository authenticationExternalRepository=AuthenticationExternalRepository();
    bool correct=false;
    if(authMethod=="Google"){
      var userCredential=await authenticationExternalRepository.loginGoogle();
      if(userCredential!=null){
        user.names=userCredential.displayName.toString();
        user.email=userCredential.email.toString();
        user.phoneNumber="";
        user.password="12345";
        user.authMethod="Google";
        user.userType="Común";
        user.verified=false;
        user.accountStatus=true;
        correct=true;
      }
    }else{
      correct=true;
    }
    if(correct){
      await userRepository.authenticateUser(user)
      .then((response) async{
        if(response["completed"]){
          mapResponse["user"]=response["user"];
          List<UserPropertyBase> userPropertyBases=response["user_property_bases"];
          if(userPropertyBases[2].propertiesQuantity<userPropertyBasesCache[2].propertiesQuantity){
            mapResponse["user_property_bases"]=response["user_property_bases"];
          }else{
            mapResponse["user_property_bases"]=userPropertyBasesCache;
          }
          mapResponse["memberships_payments"]=response["memberships_payments"];
          mapResponse["membership_payment_current"]=response["membership_payment_current"];
          //membresiaPagoActual=MembresiaPago.vacio();
          if(getSuscrito(mapResponse["membership_payment_current"])=="Suscrito"){
            await userRepository.getUserPropertiesSearcheds(response["user"])
           .then((response) {
              if(response["completed"]){
                mapResponse["user_properties_searcheds"]=response["user_properties_searcheds"];
              }
            });
          }
          mapResponse["session_started"]=true;
          mapResponse["session_type"]=user.userType=="Gerente"?"Observar":"Comprar";
          await userRepository.registerUserShared(user,_prefs);
        }
      });
    }

    return mapResponse;
  }

  String getSuscrito(MembershipPayment membershipPaymentCurrent){
    String subscribed="No suscrito";
    //con membresia pago actual
    if(membershipPaymentCurrent.authorization=="Aprobado"){
      DateTime currentDate=DateTime.now();
      if(DateTime.parse(membershipPaymentCurrent.finalDate).difference(currentDate).inMinutes>0){
        subscribed="Suscrito";
      }else if(currentDate.day<=3){
          subscribed="Suscrito";
      }
    }
    //return "Suscrito";
    return subscribed;
  }

  Future<Map<String,dynamic>> getUserPropertiesSearcheds(User user){
    return userRepository.getUserPropertiesSearcheds(user);
  } 
  Future<Map<String,dynamic>> answerUserQualificationRequest(String id,int qualification){
    return userRepository.answerUserQualificationRequest(id,qualification);
  }   
  Future<Map<String,dynamic>> registerEmailKeyVerifications(String email,String activity){
    return userRepository.registerEmailKeyVerifications(email,activity);
  }
  Future<Map<String,dynamic>> getEmailKeyVerifications(String email,int key){
    return userRepository.getEmailKeyVerifications(email,key);
  }
  Future<Map<String,dynamic>> createUpdateUser(User user,String activity){
      return userRepository.createUpdateUser(user,activity);
  }
  Future<Map<String,dynamic>> searchUserEmail(String email){
    return userRepository.searchUserEmail(email);
  }
  Future<Map<String,dynamic>> registerMembershipPayment(MembershipPayment membershipPayment){
    return userRepository.registerMembershipPayment(membershipPayment);
  }
  Future<Map<String,dynamic>> getMembershipPayments(String id){
    return userRepository.getMembershipPayments(id);
  }
  Future<Map<String,dynamic>> authenticateUserAutomatic(String email,String imeiNumber,UserPropertyBase viewedBase,UserPropertyBase viewedDoubleBase,UserPropertyBase favoriteBase){
    return userRepository.authenticateUserAutomatic(email,imeiNumber,viewedBase,viewedDoubleBase,favoriteBase);
  }
  Future<bool> updateUser(User user){
    return userRepository.updateUser(user);
  }
  Future<bool> updateUserPropertySearchedPersonalInformation(UserPropertySearched userPropertySearched){
    return userRepository.updateUserPropertySearchedPersonalInformation(userPropertySearched);
  }
  Future<Map<String,dynamic>> updateUserPropertySearched(UserPropertySearched userPropertySearched){
    return userRepository.updateUserPropertySearched(userPropertySearched);
  }
  Future<Map<String,dynamic>> registerAgentRegistrationRequest(AgentRegistration agentRegistration){
    return userRepository.registerAgentRegistrationRequest(agentRegistration);
  }
  Future<Map<String,dynamic>> getAgentsCity(String city){
    return userRepository.getAgentsCity(city);
  }
  Future<Map<String,dynamic>> registerUserPropertySearched(User user,UserPropertySearched searched){
    return userRepository.registerUserPropertySearched(user,searched);
  }
  Future<void> registerUserShared(User user, Future<SharedPreferences> _prefs){
   return userRepository.registerUserShared(user,_prefs); 
  }
  Future<void> registerInitialCityShared(String initialCity, Future<SharedPreferences> _prefs){
   return userRepository.registerInitialCityShared(initialCity,_prefs); 
  }
  Future<Map<String,dynamic>> getUserEmail(String email){
   return userRepository.getUserEmail(email); 
  }
}