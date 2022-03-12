import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/usuario.dart';
import 'package:inmobiliariaapp/domain/usecases/usuario/usecase_usuario.dart';
import 'package:inmobiliariaapp/ui/provider/estado_widgets.dart';
import 'package:inmobiliariaapp/widgets/textField_modelos.dart';
import 'package:provider/provider.dart';
class PageCrearCuentaUsuario extends StatefulWidget {
  PageCrearCuentaUsuario({Key? key,required this.nuevaCuenta}) : super(key: key);
  final bool nuevaCuenta;
  @override
  _PageCrearCuentaUsuarioState createState() => _PageCrearCuentaUsuarioState();
}

class _PageCrearCuentaUsuarioState extends State<PageCrearCuentaUsuario> {
  TextEditingController? controllerNombres;
  TextEditingController? controllerApellidos;
  TextEditingController? controllerTelefono;
  TextEditingController? controllerEmail;
  TextEditingController? controllerClave;
  TextEditingController? controllerPassword;
  TextEditingController? controllerConfirmarPassword;
  @override
  void initState() {
    super.initState();
    controllerNombres=TextEditingController(text: "");
    controllerApellidos=TextEditingController(text: "");
    controllerTelefono=TextEditingController(text: "");
    controllerEmail=TextEditingController(text: "");
    controllerClave=TextEditingController(text: "");
    controllerPassword=TextEditingController(text: "");
    controllerConfirmarPassword=TextEditingController(text: "");
  }
  @override
  Widget build(BuildContext context) {
    final estadoWidget=Provider.of<EstadoWidgets>(context);
    //estadoWidget.getMapVerificacionCuenta["email_verificado"]=true;
    return Scaffold(
       appBar: AppBar(
         title: Text(widget.nuevaCuenta?"Crear cuenta":"Recuperar cuenta"),
       ),
       body: Container(
         padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
         child:Column(
           children: [
             Expanded(
               child: ListView(
                 children: [
                   TextFFBasico(
                     controller: controllerEmail!, 
                     labelText: "Email o correo electrónico", 
                    onChanged: (x){}
                  ),
                    
                   !estadoWidget.getMapVerificacionCuenta["email_verificado"]? Column(
                     children: [
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BotonSolicitarClave(nuevaCuenta:widget.nuevaCuenta, controllerEmail: controllerEmail!)
                        ],
                      ),
                      SizedBox(height: 5,),
                      TextFFBasico(
                        controller: controllerClave!, 
                        labelText: "Clave de verificación enviada a email", 
                        onChanged: (x){}
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BotonVerificarClave(
                            controllerEmail: controllerEmail!, 
                            controllerClave: controllerClave!,
                            controllerNombres: controllerNombres!,
                            controllerApellidos: controllerApellidos!,
                            controllerTelefono: controllerTelefono!,
                            )
                        ],
                      ),
                      SizedBox(height: 5,),
                     ],
                   ):Container(),
                  
                  estadoWidget.getMapVerificacionCuenta["email_verificado"]?Column(
                    children: [
                      Column(
                        children: [
                          SizedBox(height:5),
                          TextFFBasico(
                            controller: controllerNombres!, 
                            labelText: "Nombres", 
                            onChanged: (x){

                            }
                          ),
                          SizedBox(height:5),
                          TextFFBasico(
                            controller: controllerApellidos!, 
                            labelText: "Apellidos", 
                            onChanged: (x){

                            }
                          ),
                          SizedBox(height:5),
                          TextFFBasico(
                            controller: controllerTelefono!, 
                            labelText: "Teléfono", 
                            onChanged: (x){

                            }
                          ),
                        ],
                      ),
                      SizedBox(height:5),
                      TextFFBasico(
                        controller: controllerPassword!, 
                        labelText: "Nueva contraseña", 
                        onChanged: (x){

                        }
                      ),
                      SizedBox(height:5),
                      TextFFBasico(
                        controller: controllerConfirmarPassword!, 
                        labelText: "Confirmar contraseña", 
                        onChanged: (x){

                        }
                      ),
                    ],
                  ):Container(),
                  
                 ],
               ),
             ),
             estadoWidget.getMapVerificacionCuenta["email_verificado"]?
             CrearModificarUsuario(
               nuevaCuenta: widget.nuevaCuenta,
               controllerNombres: controllerNombres!, 
               controllerApellidos: controllerApellidos!, 
               controllerTelefono: controllerTelefono!, 
               controllerEmail: controllerEmail!, 
               controllerPassword: controllerPassword!, 
               controllerConfirmarPassword: controllerConfirmarPassword!
             ):Container()
           ],
         )
       ),
    );
  }
}
class BotonSolicitarClave extends StatefulWidget {
   BotonSolicitarClave({Key? key,required this.nuevaCuenta,required this.controllerEmail}) : super(key: key);
  final TextEditingController controllerEmail;
  final bool nuevaCuenta;

  @override
  _BotonSolicitarClaveState createState() => _BotonSolicitarClaveState();
}

class _BotonSolicitarClaveState extends State<BotonSolicitarClave> {
  UseCaseUsuario useCaseUsuario=UseCaseUsuario();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),       
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.indigo.withOpacity(0.9),
            Colors.cyan,
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
          minimumSize: MaterialStateProperty.all(Size(150, 30)),
          backgroundColor:
          MaterialStateProperty.all(Colors.transparent),
          shadowColor:MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: ()async{
          if(widget.controllerEmail.text==""){
            ScaffoldMessenger.of(context).showSnackBar(_showSnackBar("Email obligatorio"));
          }else{
            useCaseUsuario.registrarEmailClaveVerificaciones(widget.controllerEmail.text, widget.nuevaCuenta?"Registrar":"Recuperar")
            .then((resultado) {
              if(resultado["completado"]){
                ScaffoldMessenger.of(context).showSnackBar(_showSnackBar("Se envío la clave al email"));
              }else{
                ScaffoldMessenger.of(context).showSnackBar(_showSnackBar(resultado["mensaje_error"]));
              }
            });
          }
        }, 
        child: Text("Solicitar clave de activación")
      ),
    );
  }
}
class BotonVerificarClave extends StatefulWidget {
  const BotonVerificarClave({Key? key,required this.controllerEmail,required this.controllerClave,
    required this.controllerNombres,required this.controllerApellidos,required this.controllerTelefono
  }) : super(key: key);
  final TextEditingController controllerEmail;
  final TextEditingController controllerClave;
  final TextEditingController controllerNombres;
  final TextEditingController controllerApellidos;
  final TextEditingController controllerTelefono;

  @override
  _BotonVerificarClaveState createState() => _BotonVerificarClaveState();
}

class _BotonVerificarClaveState extends State<BotonVerificarClave> {
  UseCaseUsuario useCaseUsuario=UseCaseUsuario();
  @override
  Widget build(BuildContext context) {
    final estadoWidget=Provider.of<EstadoWidgets>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),       
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.grey.withOpacity(0.9),
            Colors.red,
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
          minimumSize: MaterialStateProperty.all(Size(150, 30)),
          backgroundColor:
          MaterialStateProperty.all(Colors.transparent),
          shadowColor:MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: ()async{
          if(widget.controllerEmail.text==""||widget.controllerClave.text==""){
            ScaffoldMessenger.of(context).showSnackBar(_showSnackBar("Email y clave de verificación obligatorios"));
          }else{
            useCaseUsuario.obtenerEmailClaveVerificaciones(widget.controllerEmail.text, int.parse(widget.controllerClave.text))
            .then((resultado) {
              if(resultado["completado"]){
                ScaffoldMessenger.of(context).showSnackBar(_showSnackBar("Verificación correcta"));
                widget.controllerNombres.text=resultado["usuario"].nombres;
                widget.controllerApellidos.text=resultado["usuario"].apellidos;
                estadoWidget.setMapVerificacionCuentaItem("email_verificado", true);
                estadoWidget.setMapVerificacionCuentaItem("email_verificado", true);
              }else{
                ScaffoldMessenger.of(context).showSnackBar(_showSnackBar(resultado["mensaje_error"]));
              }
            });
          }
          /*
          else{
            estadoWidget.setMapVerificacionCuentaItem("email_verificado", false);
            ScaffoldMessenger.of(context).showSnackBar(_showSnackBar("Verificación incorrecta"));
          }
           */
        }, 
        child: Text("Verificar clave de activación")
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
  UseCaseUsuario useCaseUsuario=UseCaseUsuario();
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
            Usuario usuario=Usuario.vacio();
            usuario.nombres=widget.controllerNombres.text;
            usuario.apellidos=widget.controllerApellidos.text;
            usuario.correo=widget.controllerEmail.text;
            usuario.numeroTelefono=widget.controllerTelefono.text;
            usuario.contrasenia=widget.controllerPassword.text;
            usuario.metodoAutenticacion="Creada";
            usuario.tipoUsuario="Común";
            usuario.verificado=false;
            usuario.estadoCuenta=true;
            useCaseUsuario.crearModificarUsuario(usuario,widget.nuevaCuenta?"Registrar":"Recuperar")
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