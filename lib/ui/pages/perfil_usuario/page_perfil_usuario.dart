
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/generales.dart';
import 'package:inmobiliariaapp/domain/entities/inscripcion_agente.dart';
import 'package:inmobiliariaapp/domain/entities/usuario.dart';
import 'package:inmobiliariaapp/domain/usecases/usuario/usecase_usuario.dart';
import 'package:inmobiliariaapp/ui/pages/registro_inmuebles/widgets/grilla_imagenes.dart';
import 'package:inmobiliariaapp/ui/pages/registro_inmuebles/widgets/operaciones_imagenes.dart';
import 'package:inmobiliariaapp/ui/pages/membresia_pagos/page_membresia_pagos.dart';
import 'package:inmobiliariaapp/widgets/estrellas_calificacion.dart';
import 'package:inmobiliariaapp/ui/provider/datos_generales_info.dart';
import 'package:inmobiliariaapp/ui/provider/usuarios_info.dart';
import 'package:inmobiliariaapp/widgets/textField_modelos.dart';
import 'package:provider/provider.dart';
class PagePerfilUsuario extends StatefulWidget {
  PagePerfilUsuario({Key? key}) : super(key: key);

  @override
  _PagePerfilUsuarioState createState() => _PagePerfilUsuarioState();
}

class _PagePerfilUsuarioState extends State<PagePerfilUsuario> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final _datosGenerales=Provider.of<DatosGeneralesInfo>(context);
    final usuario=Provider.of<UsuariosInfo>(context);
    
    return Scaffold(
      appBar:AppBar(
        title: Text("Mi perfil"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
        child: ListView(
          children: [
            Text("Datos personales",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email: ${usuario.usuario.correo}"),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Nombres: ${usuario.usuario.nombres}"),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Apellidos: ${usuario.usuario.apellidos}"),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Medio de registro: ${usuario.usuario.metodoAutenticacion}"),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Tipo de usuario: ${usuario.usuario.tipoUsuario}"),
                  SizedBox(
                    height: 5,
                  ),
                  
                  Text("Agencia Inmobiliaria: ${usuario.usuario.nombreAgencia}"),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Web: ${usuario.usuario.web}"),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Teléfono: ${usuario.usuario.numeroTelefono}"),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Verificación de cuenta: ${usuario.usuario.verificado?"Si":"No"}"),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text("Calificación: "),
                      EstrellasCalificacion(cantidadEstrellas: usuario.usuario.getCalificacion.ceil()),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context){
                            return PageModificarInformacionUsuario(
                            );
                          }
                        )
                      );
                    }, 
                    child: Text("Modificar información",
                      style: TextStyle(
                        inherit: true,
                        decorationStyle: TextDecorationStyle.solid,
                        decorationThickness: 1,
                        decoration: TextDecoration.underline
                      ),
                    )
                  ),
                  TextButton(
                    onPressed: ()async{
                      
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context){
                            return PageRegistroAgente(
                            );
                          }
                        )
                      );
                      _datosGenerales.setCiudad(Ciudad.vacio());
                    }, 
                    child: Text("Quiero ser agente inmobiliario",
                      style: TextStyle(
                        inherit: true,
                        decorationStyle: TextDecorationStyle.solid,
                        decorationThickness: 1,
                        decoration: TextDecoration.underline
                      ),
                    )
                  ),
                  TextButton(
                    onPressed: ()async{
                      //mapController.move(london, 11);
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context){
                            return PageMembresiaPagos();
                          }
                        )
                      );
                      _datosGenerales.setCiudad(Ciudad.vacio());
                    }, 
                    child: Text("Pago de membresías",
                      style: TextStyle(
                        inherit: true,
                        decorationStyle: TextDecorationStyle.solid,
                        decorationThickness: 1,
                        decoration: TextDecoration.underline
                      ),
                    )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class PageModificarInformacionUsuario extends StatefulWidget {
  PageModificarInformacionUsuario({Key? key}) : super(key: key);

  @override
  _PageModificarInformacionUsuarioState createState() => _PageModificarInformacionUsuarioState();
}

class _PageModificarInformacionUsuarioState extends State<PageModificarInformacionUsuario> {
  TextEditingController? controllerNombres;
  TextEditingController? controllerApellidos;
  TextEditingController? controllerTelefono;
  TextEditingController? controllerPassword;
  TextEditingController? controllerPasswordConfirmar;
  dynamic imagen="";
  bool isGallery=true;
  bool loadingImage=false;
  bool editarPassword=false;
  late UsuariosInfo usuariosInfo;
  UseCaseUsuario useCaseUsuario=UseCaseUsuario();
  @override
  void initState() {
    super.initState();
    controllerNombres=TextEditingController(text: "");
    controllerApellidos=TextEditingController(text: "");
    controllerTelefono=TextEditingController(text: "");
    controllerPassword=TextEditingController(text: "");
    controllerPasswordConfirmar=TextEditingController(text: "");
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      usuariosInfo = Provider.of<UsuariosInfo>(context, listen: false);
      controllerNombres!.text=usuariosInfo.usuario.nombres;
      controllerApellidos!.text=usuariosInfo.usuario.apellidos;
      controllerTelefono!.text=usuariosInfo.usuario.numeroTelefono;
      imagen=usuariosInfo.usuario.linkFoto;
    });
    
  }
  @override
  Widget build(BuildContext context) {
    final _usuario=Provider.of<UsuariosInfo>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar datos usuario"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.width/4,
                        width: MediaQuery.of(context).size.width/4,
                        color: Colors.black.withOpacity(0.05),
                        child:Stack(
                          children: [
                            (imagen as String!="")?Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.3),
                                image: DecorationImage(
                                  image: NetworkImage(imagen),
                                  fit: BoxFit.fitHeight,
                                  scale: 1.5
                                )
                              ),
                            ):Container(
                                color: Colors.grey.withOpacity(.3),
                            ),
                            loadingImage?Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                
                              ),
                            ):Container(),
                            Container(
                              margin: EdgeInsets.all(10),
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.black45,
                                
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: onPressedUploadImage,
                                icon: Icon(Icons.upload,color: Colors.white,)
                              ),
                            )
                          ],
                        )
                      )
                    ],
                  ),
                  SizedBox(height: 5,),
                  TextFFBasico(
                    controller: controllerNombres!, 
                    labelText: "Nombres", onChanged: (x){}
                  ),
                  SizedBox(height: 5,),
                  TextFFBasico(
                    controller: controllerApellidos!, 
                    labelText: "Apellidos", onChanged: (x){}
                  ),
                  SizedBox(height: 5,),
                  TextFFBasico(
                    controller: controllerTelefono!, 
                    labelText: "Teléfono", onChanged: (x){}
                  ),
                  Row(
                    children: [
                      Text("Cambiar contraseña",
                        style: TextStyle(
                          fontStyle: FontStyle.italic
                        ),
                      ),
                      Checkbox(
                        value: editarPassword, 
                        onChanged: (value){
                          editarPassword=value!;
                          setState(() {
                            
                          });
                        }
                      ),
                    ],
                  ),
                  editarPassword?
                  Column(
                    children: [
                      SizedBox(height: 5,),
                      TextFFBasico(
                        controller: controllerPassword!, 
                        labelText: "Nueva contraseña", onChanged: (x){}
                      ),
                      SizedBox(height: 5,),
                      TextFFBasico(
                        controller: controllerPasswordConfirmar!, 
                        labelText: "Confirmar contraseña", onChanged: (x){}
                      ),
                    ],
                  ):Container()
                ],
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight:Radius.circular(20),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0)
              ),
              splashColor: Colors.blue[900],
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.green.withOpacity(0.5),
                      Colors.blue,
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight:Radius.circular(20),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0)
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Guardar cambios",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                      ),
                    )
                  ],
                ),
              ),
              onTap: (){
                Usuario usuarioAux=Usuario.copyWith(_usuario.usuario);
                usuarioAux.linkFoto=imagen;
                usuarioAux.nombres=controllerNombres!.text;
                usuarioAux.apellidos=controllerApellidos!.text;
                usuarioAux.numeroTelefono=controllerTelefono!.text;
                usuarioAux.contrasenia=controllerPassword!.text;
                useCaseUsuario.modificarUsuario(usuarioAux)
                .then((completed){
                  if(completed){
                    _usuario.setUsuario(usuarioAux);
                    Navigator.pop(context);
                  }
                });
              },
            )
          ],
        ),
      ),
    );
  }
  void onPressedUploadImage() async{
    final file=await ImageUtils.pickMedia(
      isGallery: isGallery,
      cropImage: cropCustomImage,
    );
    if(file==null) return;

    setState(() {
      loadingImage=true;
      //widget.inmuebleTotal.solicitudAdministrador.inmuebleDarBaja.imagenDocumentoPropiedad=file; 
    });
    uploadImagen(file).then((value){
        imagen=value;
    }).onError((error, stackTrace) {
      loadingImage=false;
      setState(() {
        
      });
    }).whenComplete(() {
      setState(() {
        loadingImage=false;
      });
    });
  }
}
class PageRegistroAgente extends StatefulWidget {
  PageRegistroAgente({Key? key}) : super(key: key);

  @override
  _PageRegistroAgenteState createState() => _PageRegistroAgenteState();
}

class _PageRegistroAgenteState extends State<PageRegistroAgente> {
  Ciudad ciudad=Ciudad.vacio();
  
  List<Ciudad> ciudades=[];
  TextEditingController? controllerAgencia;
  TextEditingController? controllerWeb;
  TextEditingController? controllerTelefono;
  dynamic imagen="";
  bool isGallery=true;
  bool loadingImage=false;
  UseCaseUsuario useCaseUsuario=UseCaseUsuario();
  @override
  void initState() {
    super.initState();
    
    controllerAgencia=TextEditingController(text: "");
    controllerWeb=TextEditingController(text: "");
    controllerTelefono=TextEditingController(text:"");
  }
  @override
  Widget build(BuildContext context) {
    final _datosGenerales=Provider.of<DatosGeneralesInfo>(context);
    final _usuario=Provider.of<UsuariosInfo>(context);
    if(ciudad.id==""){
      _datosGenerales.ciudades.forEach((element) { 
        ciudades.add(Ciudad.copyWith(element));
      });
    }else{
      //_datosGenerales.seleccionarZonasLibres(widget.administradorZonas);
    }
    if(controllerTelefono!.text==""){
      controllerTelefono!.text=_usuario.usuario.numeroTelefono;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de agentes"),
      ),
      body: Container(
        padding:EdgeInsets.only(left: 10,right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView(
                children:[
                  //Expanded(child: ListView()),
                  Row(
                    children: [
                      Text("Ciudad: "),
                      DropDownCiudad(ciudades: ciudades,),
                      
                    ],
                  ),
                  SizedBox(height: 5,),
                  TextFFBasico(
                    controller: controllerAgencia!, 
                    labelText: "Agencia", 
                    onChanged: (x){}
                  ),
                  SizedBox(height: 5,),
                  TextFFBasico(
                    controller: controllerWeb!, 
                    labelText: "Web", 
                    onChanged: (x){}
                  ),
                  SizedBox(height: 5,),
                  TextFFBasico(
                    controller: controllerTelefono!, 
                    labelText: "Teléfono", 
                    onChanged: (x){
            
                    }
                  ),
                  SizedBox(height: 5,),
                  Text("Respaldo solicitud:"),
                  SizedBox(height: 5,),
                  Container(
                    height: MediaQuery.of(context).size.width/1.1,
                    width: MediaQuery.of(context).size.width/1.1,
                    color: Colors.black.withOpacity(0.05),
                    child:Stack(
                      children: [
                        (imagen as String!="")?Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.3),
                            image: DecorationImage(
                              image: NetworkImage(imagen),
                              fit: BoxFit.fitHeight,
                              scale: 1.5
                            )
                          ),
                        ):Container(
                            color: Colors.grey.withOpacity(.3),
                        ),
                        loadingImage?Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
            
                          ),
                        ):Container(),
                        Container(
                          margin: EdgeInsets.all(10),
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.black45,
                            
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: onPressedUploadImage,
                            icon: Icon(Icons.upload,color: Colors.white,)
                          ),
                        )
                      ],
                    )
                  )
                ]
              ),
            ),
            ElevatedButton(
              onPressed: (){
                InscripcionAgente inscripcionAgente=InscripcionAgente.vacio();
                inscripcionAgente.linkRespaldoSolicitud=imagen.toString();
                inscripcionAgente.usuarioSolicitante=Usuario.copyWith(_usuario.usuario);
                inscripcionAgente.usuarioSolicitante.web=controllerWeb!.text;
                inscripcionAgente.usuarioSolicitante.nombreAgencia=controllerAgencia!.text;
                inscripcionAgente.usuarioSolicitante.ciudad=_datosGenerales.ciudadSeleccionada.nombreCiudad;
               //print(inscripcionAgente.toMap());
                useCaseUsuario.registrarSolicitudInscripcionAgente(inscripcionAgente).then((value) {
                  if(value["completed"]){
                    inscripcionAgente=value["inscripcion_agente"];
                    _usuario.setUsuario(inscripcionAgente.usuarioSolicitante);
                    Navigator.pop(context);
                  }
                });
              }, 
              child: Text("Enviar")
            ),
            /*ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context){
                      return PageRegistroAgentes();
                      
                    }
                  )
                );
              }, 
              child: Text("Siguiente")
            )*/
          ],
        ),
      ),
    );
  }
  void onPressedUploadImage() async{
    final file=await ImageUtils.pickMedia(
      isGallery: isGallery,
      cropImage: cropCustomImage,
    );
    if(file==null) return;

    setState(() {
      loadingImage=true;
      //widget.inmuebleTotal.solicitudAdministrador.inmuebleDarBaja.imagenDocumentoPropiedad=file; 
    });
    uploadImagen(file).then((value){
        imagen=value;
    }).onError((error, stackTrace) {
      loadingImage=false;
      setState(() {
        
      });
    }).whenComplete(() {
      setState(() {
        loadingImage=false;
      });
    });
  }
}
class DropDownCiudad extends StatefulWidget {
  DropDownCiudad({Key? key,required this.ciudades}) : super(key: key);
  final List<Ciudad> ciudades;
  @override
  _DropDownCiudadState createState() => _DropDownCiudadState();
}

class _DropDownCiudadState extends State<DropDownCiudad> {
  
  bool dropdownActivado=false;
  @override
  Widget build(BuildContext context) {
    final _datosGenerales=Provider.of<DatosGeneralesInfo>(context);
    if(_datosGenerales.ciudadSeleccionada.id==""){
      _datosGenerales.ciudadSeleccionada=widget.ciudades[0];
    }
    return  Container(
      color: Colors.transparent,
      child: DropdownButton<Ciudad>(
        icon: Icon(Icons.arrow_drop_down,color: Colors.black,),
        style: dropdownActivado?TextStyle(
          color:  Colors.black
        ):TextStyle(
          color: Colors.black
        ),
        
        onTap: (){
          setState(() {
            dropdownActivado=true;
          });
          
        },
        dropdownColor: Colors.white.withOpacity(0.8),
        value: _datosGenerales.ciudadSeleccionada,
        onChanged: (Ciudad? value){
          setState(() {
            _datosGenerales.setCiudad(value);
            //widget.ciudad=Ciudad.copyWith(value!);
            //Wvalor=value!;
            dropdownActivado=false;
          });
        },
        items:widget.ciudades
        .map<DropdownMenuItem<Ciudad>>((Ciudad value) {
          return DropdownMenuItem<Ciudad>(
            value: value,
            child: Container(
              child: Text(value.nombreCiudad),
            )
            
          );
        }).toList()
      ),
    );
  }
}