import 'package:flutter_login_facebook/flutter_login_facebook.dart' as fb;
abstract class AbstractAutenticacionExternos{
  Future handleLogin(fb.FacebookLogin facebookLogin);
  Future iniciarSesionGoogle();
}