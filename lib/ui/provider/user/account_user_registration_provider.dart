import 'package:flutter/cupertino.dart';
import 'package:inmobiliariaapp/domain/entities/user.dart';
import 'package:inmobiliariaapp/domain/usecases/user/usecase_user.dart';

class AccountUserRegistrationProvider extends ChangeNotifier{
  User _user=User.empty();
  int _keyV=0;
  Map<String,dynamic> _mapAccountUserVerified={
    "email_verified":false,
    "password_verified":false
  };

  Map<String,dynamic> _mapAccountUserError={
    "email":"",
    "key":"",
    "password":""
  };

  void setMapAccountUserVerifiedItem({required String key,required bool value,bool notify=false}){
    _mapAccountUserVerified[key]=value;
    if(notify) notifyListeners();
  }
  Map<String,dynamic> get  mapAccountUserVerified => _mapAccountUserVerified;

  void setMapAccountUserErrorItem({required String key, required String value}){
    _mapAccountUserError[key]=value;
    notifyListeners();
  }
  Map<String,dynamic> get mapAccountUserError => _mapAccountUserError;

  void setUser(User user){
    _user=user;
  }
  User get user => _user;

  void setKeyV(int keyV){
    if(_keyV>0){
      _keyV=keyV;
      _mapAccountUserError["key"]="";
      notifyListeners();
    }
  }
  int get keyV => _keyV;

  Future<Map<String,dynamic>> keyRequest({required bool newAccount})async{
    Map<String,dynamic> _response={};
    _mapAccountUserError["email"]="";
    if(_user.email==""){
      _mapAccountUserError["email"]="*";
    }
    if(_mapAccountUserError["email"]==""){
      UseCaseUser useCaseUser=UseCaseUser();
      await useCaseUser.registerEmailKeyVerifications(_user.email, newAccount?"Registrar":"Recuperar")
      .then((response) {
        _response=response;
      });
    }
    notifyListeners();
    return _response;
  }

  Future<Map<String,dynamic>> keyVerified()async{
    Map<String,dynamic> _response={};
    _mapAccountUserError["email"]="";
    _mapAccountUserError["key"]="";
    if(_mapAccountUserError["email"]==""||_mapAccountUserError["key"]){
      UseCaseUser useCaseUser=UseCaseUser();
      await useCaseUser.getEmailKeyVerifications(_user.email, _keyV)
      .then((response) {
        _response=response;
        if(response["completed"]){
          _mapAccountUserVerified["email_verified"]=true;
        }
      });
    }
    notifyListeners();
    return _response;
  }
}