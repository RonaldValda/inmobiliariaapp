import 'package:inmobiliariaapp/data/repositories/user/user_repository.dart';
import 'package:inmobiliariaapp/data/services/authentication_external_repository.dart';

import 'package:flutter_login_facebook/flutter_login_facebook.dart' as fb;

class UseCaseAuthenticationExternal{
  AuthenticationExternalRepository authenticationExternalRepository=AuthenticationExternalRepository();
  UserRepository userRepository=UserRepository();
  Future handleLogin(fb.FacebookLogin facebookLogin){
    return authenticationExternalRepository.handleLogin(facebookLogin);
  }
  Future loginGoogle(){
    return authenticationExternalRepository.loginGoogle();
  }
}