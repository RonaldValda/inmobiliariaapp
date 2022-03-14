import 'package:inmobiliariaapp/data/services/autenticacion_externos_repository.dart';

import 'package:flutter_login_facebook/flutter_login_facebook.dart' as fb;
class UseCaseAutenticacionExternos{
  AutenticacionExternosRepository autenticacionExternosRepository=AutenticacionExternosRepository();
  Future handleLogin(fb.FacebookLogin facebookLogin){
    return autenticacionExternosRepository.handleLogin(facebookLogin);
  }
  Future iniciarSesionGoogle(){
    return autenticacionExternosRepository.iniciarSesionGoogle();
  }
}