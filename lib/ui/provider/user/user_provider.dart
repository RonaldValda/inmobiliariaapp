import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/auxiliares/global_variables.dart';
import 'package:inmobiliariaapp/auxiliares/version_app.dart';
import 'package:inmobiliariaapp/device/device_info.dart';
import 'package:inmobiliariaapp/domain/entities/membership_payment.dart';
import 'package:inmobiliariaapp/domain/entities/user.dart';
import 'package:inmobiliariaapp/domain/entities/user_property_favorite.dart';
import 'package:inmobiliariaapp/domain/usecases/general/usecase_generals.dart';
import 'package:inmobiliariaapp/domain/usecases/user/usecase_super_user.dart';
import 'package:inmobiliariaapp/domain/usecases/user/usecase_user.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_user_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_provider.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_properties_searcheds.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/usecases/property/usecase_property_base.dart';
enum GetTipoUsuario{
  administrador,
  comun,
  agente,
  superusuario
}

class UserProvider with ChangeNotifier{
  User _user=User.empty();
  String _sessionType="Comprar";
  String _initialCity="";
  bool _sessionStarted=false;
  List<MembershipPayment> _membershipsPayments=[];
  MembershipPayment _membershipPaymentCurrent=MembershipPayment.empty();
  List<UserPropertyBase> _userPropertyBases=[UserPropertyBase.empty(),UserPropertyBase.empty(),UserPropertyBase.empty()];
  //List<UserPropertySearched> _userPropertiesSearcheds=[];
  bool _existsNotification=false;
  AppVersion _appVersion=AppVersion.empty();

  User get user=>_user;
  void setUser(User user){
    _user=user;
    notifyListeners();
  }
/*
  List<UserPropertySearched> get userPropertiesSearcheds=>_userPropertiesSearcheds;
  void setUserPropertiesSearcheds(List<UserPropertySearched> userPropertiesSearcheds){
    _userPropertiesSearcheds=userPropertiesSearcheds;
  }*/

  List<UserPropertyBase> get userPropertyBases =>_userPropertyBases;
  void setUserPropertyBases(List<UserPropertyBase> userPropertyBases){
    _userPropertyBases=userPropertyBases;
  }

  String get sessionType => _sessionType;
  
  void setSessionType(User user,bool status,{BuildContext? context}){
    if(!status){
      if(user.userType=="Gerente"){
        _sessionType="Observar";
      }else{
        _sessionType="Comprar";
      }
    }else{
      if(user.userType=="Administrador"){
        _sessionType="Administrar";
      }else if(user.userType=="Super Usuario"||user.userType=="Gerente"){
        _sessionType="Supervisar";
      }else {
        _sessionType="Vender";
      }
    }
    notifyListeners();
    if(context!=null)context.read<PropertiesProvider>().propertiesGeneralDB(context: context);
    notifyListeners();
  }

  void setSessionStarted(bool sessionStarted){
    _sessionStarted=sessionStarted;
  }
  bool get sessionStarted => _sessionStarted;

  void setExistsNotification(bool existsNotification){
    _existsNotification=existsNotification;
    notifyListeners();
  }
  bool get existsNotification => _existsNotification;

  List<MembershipPayment> get membershipsPayments => _membershipsPayments;
  void setMembershipsPayments(List<MembershipPayment> membershipsPayments){
    _membershipsPayments=membershipsPayments;
    notifyListeners();
  }

  void setInitialCity(String initialCity){

  }

  String get initialCity => _initialCity;

  MembershipPayment get membershipPaymentCurrent => _membershipPaymentCurrent;
  void setMembershipPaymentCurrent(MembershipPayment membershipPaymentCurrent){
    _membershipPaymentCurrent=membershipPaymentCurrent;
    notifyListeners();
  }

  String getSubscribed(){
    String subscribed="No suscrito";
    if(_membershipPaymentCurrent.authorization=="Aprobado"){
      DateTime currentDate=DateTime.now();
      if(DateTime.parse(_membershipPaymentCurrent.finalDate).difference(currentDate).inMinutes>0){
        subscribed="Suscrito";
      }else if(currentDate.day<=3){
          subscribed="Suscrito";
      }
    }
    //return "Suscrito";
    return subscribed;
  }

  AppVersion get appVersion => _appVersion;
  

  Future<SharedPreferences> _prefs=SharedPreferences.getInstance();
  UseCaseUser useCaseUser=UseCaseUser();
  
  Future<void> registerInitialCityShared()async{
    await useCaseUser.registerInitialCityShared(initialCityDefault, _prefs);
  }

  Future logoutUser({required BuildContext context})async{
    await useCaseUser.registerUserShared(User.empty(), _prefs);
    context.read<FilterUserProvider>().init();
    setSessionStarted(false);
    _userPropertyBases=[UserPropertyBase.empty(),UserPropertyBase.empty(),UserPropertyBase.empty()];
    _user=User.empty(); 
    _membershipsPayments=[];
    _membershipPaymentCurrent=MembershipPayment.empty();
    notifyListeners();
}

  Future<bool> loginUserAutomatic(bool mounted,{required BuildContext context}) async{
    bool completed=true;
    UseCaseGenerals useCaseGenerals=UseCaseGenerals();
    await useCaseGenerals.getAppVersion().then((responseVersion) async{
      if(!responseVersion["error"]){
        _appVersion=responseVersion["app_version"];
        if(_appVersion.checkVersion()){
          await DeviceInfo.initPlatformState(mounted)
          .then((responseDeviceInfo) async{
            UseCasePropertyBase useCasePropertyBase=UseCasePropertyBase();
            await useCasePropertyBase.searchPropertyBaseShared(_prefs)
            .then((responseShared)async{
              _userPropertyBases[2]=responseShared["viewed_base"];
              _userPropertyBases[1]=responseShared["viewed_double_base"];
              _userPropertyBases[0]=responseShared["favorite_base"];
              _user.email=responseShared["email"];
              _initialCity=responseShared["initial_city"];
              await useCaseUser.authenticateUserAutomatic( _user.email, responseDeviceInfo["imei_number"]??"",  userPropertyBases[1],  userPropertyBases[2],  userPropertyBases[0])
              .then((responseUser){
                print(responseUser);
                if(responseUser["completed"]){
                  _user=responseUser["user"];
                  _userPropertyBases=responseUser["user_property_bases"];
                  _membershipsPayments=responseUser["memberships_payments"];
                  _membershipPaymentCurrent=responseUser["membership_payment_current"];
                  if(_user.userType=="Super Usuario"){
                    UseCaseSuperUser useCaseSuperUser=UseCaseSuperUser();
                    useCaseSuperUser.getNotificationsExistsSuperUser(_user)
                    .then((responseSuperUser) {
                      if(responseSuperUser["completed"]){
                        _existsNotification=responseSuperUser["exists_notifications"];
                      }
                    });
                  }
                  if(_user.email!=""){
                    _sessionStarted=true;

                    setSessionType(_user, false);
                  }
                  if(getSubscribed()=="Suscrito"){
                    
                    useCaseUser.getUserPropertiesSearcheds(_user)
                    .then((responseSearched) {
                      if(responseSearched["completed"]){
                        context.read<UserPropertiesSearchedsProvider>().setUserPropertiesSearcheds(responseSearched["user_properties_searcheds"]??[],context: context);
                      }
                    });
                  }
                }else{
                  completed=false;
                  _user=User.empty();
                  _userPropertyBases=[UserPropertyBase.empty(),UserPropertyBase.empty(),UserPropertyBase.empty()];
                }
                notifyListeners();
              });
            });
          });
        }
      }
    });
    return completed;
  }

  void loginUser({required User user,required BuildContext context,required String authMethod})async{
    Map<String,dynamic> mapResponse={};
    await useCaseUser.authenticateUser(user:user,authMethod: authMethod,userPropertyBasesCache: userPropertyBases)
    .then((response) {
      mapResponse=response;
    });
    _sessionStarted=false;
    if(mapResponse["session_started"]!=null){
      _user=mapResponse["user"];
      _userPropertyBases=mapResponse["user_property_bases"]??[];
      _membershipsPayments=mapResponse["memberships_payments"]??[];
      _membershipPaymentCurrent=mapResponse["membership_payment_current"]??MembershipPayment.empty();
      context.read<UserPropertiesSearchedsProvider>().setUserPropertiesSearcheds(mapResponse["user_properties_searcheds"]??[],context: context);
      _sessionStarted=true;
      _sessionType=mapResponse["session_type"];
      notifyListeners();
      Navigator.pop(context);
    }
  }
}