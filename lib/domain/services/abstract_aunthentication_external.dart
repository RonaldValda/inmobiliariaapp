import 'package:flutter_login_facebook/flutter_login_facebook.dart' as fb;
abstract class AbstractAuthenticationExternal{
  Future handleLogin(fb.FacebookLogin facebookLogin);
  Future loginGoogle();
}