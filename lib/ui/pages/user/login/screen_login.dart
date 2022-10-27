import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:inmobiliariaapp/domain/entities/user.dart';
import 'package:inmobiliariaapp/domain/usecases/authentication_external/usecase_authentication_external.dart';
import 'package:inmobiliariaapp/domain/usecases/user/usecase_user.dart';
import 'package:inmobiliariaapp/ui/common/buttons.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/pages/user/account/screen_account_user_registration.dart';
import 'package:inmobiliariaapp/ui/provider/home/widget_status_provider.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_provider.dart';
import 'package:inmobiliariaapp/widgets/f_text_fields.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' as iconc;

import '../../../common/colors_default.dart';
import '../../../common/size_default.dart';
class ScreenLogin extends StatefulWidget {
  ScreenLogin();
  
  @override
  _ScreenLoginState createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  TextEditingController? _controllerPassword;
  TextEditingController? _controllerEmail;
  bool nuevoRegistro=false;
  bool yaTengoCuenta=true;
  bool olvideMiContrasenia=false;
  FacebookLogin facebookLogin=FacebookLogin();
  String urlFoto="";
  final color=Colors.black54;
  final colorFill=Colors.white;
  UseCaseUser useCaseUser=UseCaseUser();
  UseCaseAuthenticationExternal useCaseAuthenticationExternal=UseCaseAuthenticationExternal();
  User user=User.empty();
  @override
  void initState() {
    super.initState();
    _controllerPassword=TextEditingController(text: "");
    _controllerEmail=TextEditingController(text: "");
    user.email="ronald.valda0903@gmail.com";
    user.password="12345";
  }
  
  @override
  Widget build(BuildContext context) {
    final widgetStatusProvider=Provider.of<WidgetStatusProvider>(context);
    return Scaffold(
       appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: FBackButton(),
        title: TextTitle(
          text: "Inicio de Sesión", 
          fontSize: SizeDefault.fSizeTitle
        ),
       ),
       body: Container(
        color: ColorsDefault.colorBackgroud,
        height: double.infinity,
         //color: Colors.blue,
         //color: Colors.black.withOpacity(0.03),
         
         child: SingleChildScrollView(
           child: Container(
            padding: EdgeInsets.only(top: 100*SizeDefault.scaleHeight,right: SizeDefault.paddingHorizontalBody,left: SizeDefault.paddingHorizontalBody),
             child: Column(
               children: [
                FTextFieldBasico(
                  controller: _controllerEmail!, 
                  textInputType: TextInputType.emailAddress,
                  labelText: "Correo electrónico", 
                  onChanged: (x){
                    user.email=x;
                  }
                ),
                SizedBox(height: 10*SizeDefault.scaleHeight,),
                FTextFieldPassword(
                  textLabel: "Contraseña", 
                  controller: _controllerPassword!,
                  onChanged: (x){
                    user.password=x;
                  },
                ),
                SizedBox(height: 30*SizeDefault.scaleHeight,),
                Column(
                  children: [
                    ButtonPrimary(
                      text: "Iniciar Sesión", 
                      onPressed: () { 
                        user.authMethod="Creada";
                        context.read<UserProvider>().loginUser(user:user,context: context,authMethod: "Creada");
                      }
                    ),
                    
                    SizedBox(height: 10*SizeDefault.scaleHeight,),
                    TextButtonPrimary(
                      text: "Olvidé mi contraseña", 
                      onPressed: ()async{
                        widgetStatusProvider.getMapVerificacionCuenta["email_verificado"]=false;
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context){
                              return ScreenAccountUserRegistration(
                                newAccount: false,
                              );
                            }
                          )
                        );
                      },
                    ),
                    
                    
                  ],
                ),
                SizedBox(height: 60*SizeDefault.scaleHeight,),
                Divider(height: 2*SizeDefault.scaleHeight,),
                SizedBox(height: 10*SizeDefault.scaleHeight,),
                ButtonOutlinedPrimary(
                  text: "Crear nueva cuenta", 
                  
                  onPressed: ()async{
                    widgetStatusProvider.getMapVerificacionCuenta["email_verificado"]=false;
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context){
                          return ScreenAccountUserRegistration(
                            newAccount: true,
                          );
                        }
                      )
                    );
                  }
                ),
                buttonSignExternos(
                  context,
                  (){
                    context.read<UserProvider>().loginUser(user:User.empty(),context: context,authMethod: "Google");
                  },
                  ()async{
                    /*var userc=await handleLogin(facebookLogin);          
                    if(userc!=null){     
                      final profile =  await userc.getUserProfile();
                      final email = await userc.getUserEmail();
                      final foto =  await userc.getProfileImageUrl(width: 200);
                      _controllerNombreUsuario!.text=profile.name.toString();
                      runMutation({"nombre":profile!.name.toString(),"nombre_usuario":profile!.name.toString(),
                      "email":email.toString(),"password":"12345","medio_registro":"Facebook","fecha_ultimo_ingreso":DateTime.now().toString()});
                      urlFoto=foto.toString();
                    }else{
                      print("valor_nulo");
                    }*/
                  }
                ),
              ],
             ),
           ),
         ),

       ),
    );
  }

   buttonSignExternos(BuildContext context,VoidCallback loginGoogle, VoidCallback loginFacebook) {
     
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            IconButton(
              onPressed:() =>loginGoogle(),
              tooltip: "Login con Google",
              icon: iconc.FaIcon(iconc.FontAwesomeIcons.google,size: 20,),),
              IconButton(onPressed: ()=>loginFacebook(),
            tooltip: "Login con facebook",
            icon: iconc.FaIcon(iconc.FontAwesomeIcons.facebookF,size: 20,),),
          
        ],
      );
  }

  Row buttonSignCrear(BuildContext context,VoidCallback login,String textoBoton) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[ 
        Container(
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(20), 
          ),
          child: ElevatedButton(
            child: Row(
              children: [
                Text(textoBoton,
                  style: TextStyle(
                    color: Colors.white
                  ),
                )
              ],
            ),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>( 
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              minimumSize: MaterialStateProperty.all(Size(150, 50)),
              backgroundColor:
              MaterialStateProperty.all(Colors.transparent),
              shadowColor:MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed:()=>login(),
          ),
        ),
      ]
    );
  }
}
