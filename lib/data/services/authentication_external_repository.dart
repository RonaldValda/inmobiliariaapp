
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inmobiliariaapp/domain/services/abstract_aunthentication_external.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart' as fb;

class AuthenticationExternalRepository extends AbstractAuthenticationExternal{
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
  Future loginGoogle() async{
    final GoogleSignInAccount? googleUser=await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth=await googleUser!.authentication;
    print(googleAuth);
    print(googleUser.displayName);

    return googleUser;
  }

}