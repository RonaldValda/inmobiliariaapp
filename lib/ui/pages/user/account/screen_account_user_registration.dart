import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/usecases/user/usecase_user.dart';
import 'package:inmobiliariaapp/ui/common/buttons.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/provider/user/account_user_registration_provider.dart';
import 'package:inmobiliariaapp/widgets/f_text_fields.dart';
import 'package:provider/provider.dart';

import '../../../../domain/entities/user.dart';
import '../../../common/size_default.dart';
import '../../../common/texts.dart';
class ScreenAccountUserRegistration extends StatefulWidget {
  ScreenAccountUserRegistration({Key? key,required this.newAccount}) : super(key: key);
  final bool newAccount;
  @override
  _ScreenAccountUserRegistrationState createState() => _ScreenAccountUserRegistrationState();
}

class _ScreenAccountUserRegistrationState extends State<ScreenAccountUserRegistration> {
  TextEditingController? controllerNames;
  TextEditingController? controllerSurnames;
  TextEditingController? controllerPhone;
  TextEditingController? controllerEmail;
  TextEditingController? controllerKey;
  TextEditingController? controllerPassword;
  TextEditingController? controllerConfirmPassword;
  @override
  void initState() {
    super.initState();
    controllerNames=TextEditingController(text: "");
    controllerSurnames=TextEditingController(text: "");
    controllerPhone=TextEditingController(text: "");
    controllerEmail=TextEditingController(text: "");
    controllerKey=TextEditingController(text: "");
    controllerPassword=TextEditingController(text: "");
    controllerConfirmPassword=TextEditingController(text: "");
  }
  @override
  Widget build(BuildContext context) {
    final accountUserRegistrationProvider=context.watch<AccountUserRegistrationProvider>();
    //estadoWidget.getMapVerificacionCuenta["email_verificado"]=true;
    return Scaffold(
       appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: TextTitle(
          text: widget.newAccount?"Crear cuenta":"Recuperar cuenta",
          fontSize: SizeDefault.fSizeTitle
        ),
       ),
       body: Container(
        color: ColorsDefault.colorBackgroud,
         padding: EdgeInsets.symmetric(horizontal:SizeDefault.paddingHorizontalBody),
         child:Column(
           children: [
             Expanded(
               child: ListView(
                 children: [
                  SizedBox(height: 20*SizeDefault.scaleHeight,),
                  FTextFieldBasico(
                    controller: controllerEmail!, 
                    labelText: "Email", 
                    errorText: accountUserRegistrationProvider.mapAccountUserError["email"],
                    onChanged: (x){
                      accountUserRegistrationProvider.setMapAccountUserErrorItem(key: "email", value: "");
                      accountUserRegistrationProvider.user.email=x;
                    }
                  ),
                    
                   !accountUserRegistrationProvider.mapAccountUserVerified["email_verified"]
                   ?Column(
                     children: [
                      SizedBox(height: 15*SizeDefault.scaleHeight,),
                      ButtonOutlinedPrimary(
                        text: "Solicitar clave de activación", 
                        onPressed: ()async{
                          final response=await accountUserRegistrationProvider.keyRequest(newAccount: widget.newAccount);
                          print(response);
                          if(response["completed"]!=null){
                            if(response["completed"]){
                              ScaffoldMessenger.of(context).showSnackBar(_showSnackBar("Se envío la clave al email"));
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(_showSnackBar(response["error_message"]));
                            }
                          }
                        }, 
                      ),
                      SizedBox(height: 15*SizeDefault.scaleHeight,),
                      FTextFieldBasico(
                        controller: controllerKey!, 
                        labelText: "Clave de verificación enviada a email", 
                        onChanged: (x){
                          accountUserRegistrationProvider.setKeyV(x!=""?int.parse(x):0);
                        }
                      ),
                      SizedBox(height: 15*SizeDefault.scaleHeight,),
                      ButtonOutlinedPrimary(
                        text: "Verificar clave", 
                        onPressed: ()async{
                          final response=await accountUserRegistrationProvider.keyVerified();
                          if(response["completed"]){
                            ScaffoldMessenger.of(context).showSnackBar(_showSnackBar("Verificación correcta"));
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(_showSnackBar(response["error_message"]));
                          }
                        }, 
                      ),
                      SizedBox(height: 15*SizeDefault.scaleHeight,),
                     ],
                   ):Container(),
                  
                  accountUserRegistrationProvider.mapAccountUserVerified["email_verified"]
                  ?Column(
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 15*SizeDefault.scaleHeight,),
                          FTextFieldBasico(
                            controller: controllerNames!, 
                            labelText: "Nombres", 
                            onChanged: (x){

                            }
                          ),
                          SizedBox(height: 15*SizeDefault.scaleHeight,),
                          FTextFieldBasico(
                            controller: controllerSurnames!, 
                            labelText: "Apellidos", 
                            onChanged: (x){

                            }
                          ),
                          SizedBox(height: 15*SizeDefault.scaleHeight,),
                          FTextFieldBasico(
                            controller: controllerPhone!, 
                            labelText: "Teléfono", 
                            onChanged: (x){

                            }
                          ),
                        ],
                      ),
                      SizedBox(height: 15*SizeDefault.scaleHeight,),
                      FTextFieldBasico(
                        controller: controllerPassword!, 
                        labelText: "Nueva contraseña", 
                        onChanged: (x){

                        }
                      ),
                      SizedBox(height: 15*SizeDefault.scaleHeight,),
                      FTextFieldBasico(
                        controller: controllerConfirmPassword!, 
                        labelText: "Confirmar contraseña", 
                        onChanged: (x){

                        }
                      ),
                      SizedBox(height: 40*SizeDefault.scaleHeight,),
                      ButtonPrimary(
                        text: widget.newAccount?"Crear Usuario":"Recuperar cuenta", 
                        onPressed: (){

                        }
                      )
                    ],
                  ):Container(),
                  
                 ],
               ),
             ),
             accountUserRegistrationProvider.mapAccountUserVerified["email_verified"]
             ?CrearModificarUsuario(
               nuevaCuenta: widget.newAccount,
               controllerNombres: controllerNames!, 
               controllerApellidos: controllerSurnames!, 
               controllerTelefono: controllerPhone!, 
               controllerEmail: controllerEmail!, 
               controllerPassword: controllerPassword!, 
               controllerConfirmarPassword: controllerConfirmPassword!
             ):Container()
           ],
         )
       ),
    );
  }
}
SnackBar _showSnackBar(String texto){
  SnackBar snackBar=SnackBar(
    content: Text(texto),
    action: SnackBarAction(
      label: 'OK',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
  return snackBar;
}
class CrearModificarUsuario extends StatefulWidget {
  const CrearModificarUsuario({Key? key,
    required this.nuevaCuenta,
    required this.controllerNombres,
    required this.controllerApellidos,
    required this.controllerTelefono,
    required this.controllerEmail,
    required this.controllerPassword,
    required this.controllerConfirmarPassword
  }) : super(key: key);
  final bool nuevaCuenta;
  final TextEditingController controllerNombres;
  final TextEditingController controllerApellidos;
  final TextEditingController controllerTelefono;
  final TextEditingController controllerEmail;
  final TextEditingController controllerPassword;
  final TextEditingController controllerConfirmarPassword;

  @override
  _CrearModificarUsuarioState createState() => _CrearModificarUsuarioState();
}

class _CrearModificarUsuarioState extends State<CrearModificarUsuario> {
  UseCaseUser useCaseUser=UseCaseUser();
  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),bottomRight: Radius.circular(0),
          topLeft:Radius.circular(20),topRight: Radius.circular(20) 
        ),       
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.green,
            Colors.lightGreen,
          ],
        ),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>( 
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          minimumSize: MaterialStateProperty.all(Size(250, 30)),
          backgroundColor:
          MaterialStateProperty.all(Colors.transparent),
          shadowColor:MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: ()async{
          if(widget.controllerEmail.text==""){
            ScaffoldMessenger.of(context).showSnackBar(_showSnackBar("Email obligatorio"));
          }
          else if(widget.controllerPassword.text==""){
            ScaffoldMessenger.of(context).showSnackBar(_showSnackBar("Complete todos los campos"));
          }else if(widget.controllerPassword.text!=widget.controllerConfirmarPassword.text){
            ScaffoldMessenger.of(context).showSnackBar(_showSnackBar("La confirmación de constraseña no coincide"));
          }
          else{
            User user=User.empty();
            user.names=widget.controllerNombres.text;
            user.surnames=widget.controllerApellidos.text;
            user.email=widget.controllerEmail.text;
            user.phoneNumber=widget.controllerTelefono.text;
            user.password=widget.controllerPassword.text;
            user.authMethod="Creada";
            user.userType="Común";
            user.verified=false;
            user.accountStatus=true;
            useCaseUser.createUpdateUser(user,widget.nuevaCuenta?"Registrar":"Recuperar")
            .then((resultado) {
              if(resultado["completado"]){
                ScaffoldMessenger.of(context).showSnackBar(_showSnackBar(widget.nuevaCuenta?"Se registró el usuario":"Se guardaron los cambios"));
                Navigator.pop(context);
              }
            });
          }
        }, 
        child: Text(widget.nuevaCuenta?"Crear Usuario":"Recuperar cuenta",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600
          ),
        )
      ),
    );
  }
}