import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:inmobiliariaapp/domain/entities/membresia_pago.dart';
import 'package:inmobiliariaapp/domain/entities/usuario.dart';
import 'package:inmobiliariaapp/domain/entities/usuarios_inmuebles_favoritos.dart';
import 'package:inmobiliariaapp/domain/usecases/autenticacion_externos/usecase_autenticacion_externos.dart';
import 'package:inmobiliariaapp/domain/usecases/usuario/usecase_usuario.dart';
import 'package:inmobiliariaapp/ui/pages/crear_cuenta_usuario/page_crear_cuenta_usuario.dart';
import 'package:inmobiliariaapp/ui/provider/estado_widgets.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/usuarios_info.dart';
import 'package:inmobiliariaapp/widgets/textField_modelos.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' as iconc;
import 'package:shared_preferences/shared_preferences.dart';
// ignore: must_be_immutable
class PageAutenticacionUsuario extends StatefulWidget {
  PageAutenticacionUsuario();
  
  @override
  _PageAutenticacionUsuarioState createState() => _PageAutenticacionUsuarioState();
}

class _PageAutenticacionUsuarioState extends State<PageAutenticacionUsuario> {
  Future<SharedPreferences> _prefs=SharedPreferences.getInstance();
  String texto="";
  TextEditingController? _controllerNombreUsuario;
  TextEditingController? _controllerContrasenia;
  TextEditingController? _controllerNombres;
  TextEditingController? _controllerCorreo;
  TextEditingController? _controllerNumeroTelefono;
  bool nuevoRegistro=false;
  bool yaTengoCuenta=true;
  bool olvideMiContrasenia=false;
  FacebookLogin facebookLogin=FacebookLogin();
  String urlFoto="";
  final color=Colors.black54;
  final colorFill=Colors.white;
  UseCaseUsuario useCaseUsuario=UseCaseUsuario();
  UseCaseAutenticacionExternos useCaseAutenticacionExternos=UseCaseAutenticacionExternos();
  @override
  void initState() {
    super.initState();
    _controllerNombreUsuario=TextEditingController(text: "");
    _controllerContrasenia=TextEditingController(text: "");
    _controllerNombres=TextEditingController(text: "");
    _controllerCorreo=TextEditingController(text: "");
    _controllerNumeroTelefono=TextEditingController(text: "");
  }
  
  @override
  Widget build(BuildContext context) {
    final estadoWidget=Provider.of<EstadoWidgets>(context);
    final usuariosInfo=Provider.of<UsuariosInfo>(context);
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    return Scaffold(
       appBar: AppBar(
         leading: IconButton(
           icon: Icon(Icons.arrow_back),
           onPressed: (){
             Navigator.pop(context);
           },
         ),
         title: Text("Inicio de Sesión"+texto),
         shadowColor: Colors.amber,
       ),
       body: Container(
         //color: Colors.blue,
         //color: Colors.black.withOpacity(0.03),
         padding: EdgeInsets.all(10),
         child: SingleChildScrollView(
           child: Column(
             children: [
              TextFieldIcono(color: color, colorFill: colorFill, hintText: "Correo", icono: Icons.email, controller: _controllerCorreo!),
              TextFieldIcono(color: color, colorFill: colorFill, hintText: "Contraseña", icono: Icons.lock, controller: _controllerContrasenia!),
              
              SizedBox(height: 10,),
              Column(
                children: [
                  buttonSignCrear(
                    context, 
                    () { 
                      Usuario usuario=Usuario.vacio();
                      usuario.nombres=_controllerNombres!.text;
                      usuario.correo=_controllerCorreo!.text;
                      usuario.numeroTelefono=_controllerNumeroTelefono!.text;
                      usuario.contrasenia=_controllerContrasenia!.text;
                      usuario.metodoAutenticacion="Creada";
                      usuario.tipoUsuario=usuariosInfo.usuario.tipoUsuario;
                      usuario.verificado=false;
                      usuario.estadoCuenta=true;
                      useCaseUsuario.auntenticarUsuario(usuario)
                      .then((resultado){
                        if(resultado["completado"]){
                          Usuario usuario=resultado["usuario"];
                          List<UsuarioInmuebleBase> usuarioInmuebleBases=resultado["usuario_inmueble_bases"];
                          if(usuariosInfo.usuarioInmuebleBases[2].cantidadInmuebles<usuarioInmuebleBases[2].cantidadInmuebles){
                            usuariosInfo.setUsuarioInmuebleBases(usuarioInmuebleBases);
                          }
                          usuariosInfo.membresiaPagos=resultado["membresia_pagos"];
                          usuariosInfo.membresiaPagoActual=resultado["membresia_pago_actual"];
                          usuariosInfo.membresiaPagoActual=MembresiaPago.vacio();
                          if(usuariosInfo.getSuscrito()=="Suscrito"){
                            useCaseUsuario.obtenerUsuarioInmueblesBuscados(usuario).then((value) {
                              if(value["completado"]){
                                usuariosInfo.setUsuarioInmueblesBuscados(value["usuario_inmuebles_buscados"]);
                              }
                            });
                          }
                          _inmueblesFiltrado.setConsultarBD(true);
                          usuariosInfo.sesionIniciada=true;
                          usuariosInfo.tipoSesion=usuario.tipoUsuario=="Gerente"?"Observar":"Comprar";
                          usuariosInfo.setUsuario(usuario);
                          useCaseUsuario.registrarUsuarioShared( usuariosInfo.usuario,_prefs);
                          Navigator.pop(context);
                        }
                      });
                    }, 
                    "Iniciar Sesión"
                  ),
                  
                  SizedBox(height:10),
                  InkWell(
                    child: Text("Olvidé mi contraseña",
                      style: olvideMiContrasenia?TextStyle(
                        decoration: TextDecoration.underline,
                        decorationThickness: 2.5,
                      ):TextStyle(
                      ),
                    ),
                    onTap: ()async{
                      estadoWidget.getMapVerificacionCuenta["email_verificado"]=false;
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context){
                            return PageCrearCuentaUsuario(
                              nuevaCuenta: false,
                            );
                          }
                        )
                      );
                    },
                  ),
                  buttonSignExternos(
                    context,
                    ()async{
                      var userCredential;
                        userCredential=await useCaseAutenticacionExternos.iniciarSesionGoogle();
                        if(userCredential!=null){
                          Usuario usuario=Usuario.vacio();
                          usuario.nombres=userCredential.displayName.toString();
                          usuario.correo=userCredential.email.toString();
                          usuario.numeroTelefono="";
                          usuario.contrasenia="12345";
                          usuario.metodoAutenticacion="Google";
                          usuario.tipoUsuario="Común";
                          usuario.verificado=false;
                          usuario.estadoCuenta=true;
                          useCaseUsuario.auntenticarUsuario(usuario)
                          .then((resultado){
                            if(resultado["completado"]){
                              Usuario usuario=resultado["usuario"];
                              List<UsuarioInmuebleBase> usuarioInmuebleBases=resultado["usuario_inmueble_bases"];
                              if(usuariosInfo.usuarioInmuebleBases[2].cantidadInmuebles<usuarioInmuebleBases[2].cantidadInmuebles){
                                usuariosInfo.setUsuarioInmuebleBases(usuarioInmuebleBases);
                              }
                              usuariosInfo.membresiaPagos=resultado["membresia_pagos"];
                              usuariosInfo.membresiaPagoActual=resultado["membresia_pago_actual"];
                              usuariosInfo.membresiaPagoActual=MembresiaPago.vacio();
                              if(usuariosInfo.getSuscrito()=="Suscrito"){
                                useCaseUsuario.obtenerUsuarioInmueblesBuscados(usuario).then((value) {
                                  if(value["completado"]){
                                    usuariosInfo.setUsuarioInmueblesBuscados(value["usuario_inmuebles_buscados"]);
                                  }
                                });
                              }
                              _inmueblesFiltrado.setConsultarBD(true);
                              usuariosInfo.sesionIniciada=true;
                              usuariosInfo.tipoSesion=usuario.tipoUsuario=="Gerente"?"Observar":"Comprar";
                              usuariosInfo.setUsuario(usuario);
                              useCaseUsuario.registrarUsuarioShared( usuariosInfo.usuario,_prefs);
                              Navigator.pop(context);
                            }
                          });
                        }else{
                          print("nulo");
                        }
                        setState(() {
                          _controllerNombreUsuario!.text=userCredential.displayName.toString();
                          _controllerContrasenia!.text=userCredential.email.toString();
                        });
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
              Divider(height: 2,),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),       
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.green.withOpacity(0.5),
                      Colors.grey,
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
                    minimumSize: MaterialStateProperty.all(Size(150, 50)),
                    backgroundColor:
                    MaterialStateProperty.all(Colors.transparent),
                    shadowColor:MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: ()async{
                    estadoWidget.getMapVerificacionCuenta["email_verificado"]=false;
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context){
                          return PageCrearCuentaUsuario(
                            nuevaCuenta: true,
                          );
                        }
                      )
                    );
                  }, 
                  child: Text("Crear nueva cuenta")
                ),
              ),
            ],
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
            borderRadius: BorderRadius.circular(20),       
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue.withOpacity(0.5),
                Colors.orangeAccent,
              ],
            ),
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
