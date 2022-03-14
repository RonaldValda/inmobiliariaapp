
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inmobiliariaapp/domain/services/abstract_auntenticacion_externos.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart' as fb;

class AutenticacionExternosRepository extends AbstractAutenticacionExternos{
  @override
  Future handleLogin(fb.FacebookLogin facebookLogin) async{
    var userC;
    final fb.FacebookLoginResult result=await facebookLogin
      .logIn(permissions: [
        fb.FacebookPermission.publicProfile,
        fb.FacebookPermission.email,
      ]);
      print(result.toMap());
    switch(result.status){
      case fb.FacebookLoginStatus.cancel:
        print("se cancelo ");
        break;
      case fb.FacebookLoginStatus.error:
        print("error de logeo ");
        break;
      case fb.FacebookLoginStatus.success:
        try{
          userC=facebookLogin;
        }catch(e){
          print("errooor..... ${e.toString()}");
        }
    }
    return userC;
  }

  @override
  Future iniciarSesionGoogle() async{
    final GoogleSignInAccount? googleUsuario=await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth=await googleUsuario!.authentication;
    print(googleAuth);
    print(googleUsuario.displayName);

    return googleUsuario;
  }

}