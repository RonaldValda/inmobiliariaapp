
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class Autenticacion {
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;

  Future<void> iniciarSesionGoogle()async{
    final googleSignIn=GoogleSignIn();
    final googleUser=await googleSignIn.signIn();
    if(googleUser!=null){
      final googleAuth=await googleUser.authentication;
      if(googleAuth.idToken!=null){
        // ignore: unused_local_variable
        final userCredential=await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,accessToken: googleAuth.accessToken
            
          )
        );
        //return userCredential.user;
      }
    }else{
      throw FirebaseAuthException(
        message: "Error al iniciar sesión",
        code: "ERROR"
      );
    }
    
    // ignore: unused_element
    Future<void> signOut()async{
      final googleSignIn=GoogleSignIn();
      await googleSignIn.signOut();
      await _firebaseAuth.signOut();
    } 
  }
}