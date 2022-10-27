
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/generals.dart';
import 'package:inmobiliariaapp/domain/entities/agent_registration.dart';
import 'package:inmobiliariaapp/domain/entities/user.dart';
import 'package:inmobiliariaapp/ui/pages/membresia_pagos/page_membresia_pagos.dart';
import 'package:inmobiliariaapp/widgets/estrellas_calificacion.dart';
import 'package:inmobiliariaapp/ui/provider/generals/general_data_provider.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_provider.dart';
import 'package:inmobiliariaapp/widgets/f_text_fields.dart';
import 'package:provider/provider.dart';

import '../../../data/services/images_repository.dart';
import '../../../device/image_utils.dart';
import '../../../domain/usecases/user/usecase_user.dart';
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
    final _datosGenerales=Provider.of<GeneralDataProvider>(context);
    final usuario=Provider.of<UserProvider>(context);
    
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
                  Text("Email: ${usuario.user.email}"),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Nombres: ${usuario.user.names}"),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Apellidos: ${usuario.user.surnames}"),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Medio de registro: ${usuario.user.authMethod}"),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Tipo de usuario: ${usuario.user.userType}"),
                  SizedBox(
                    height: 5,
                  ),
                  
                  Text("Agencia Inmobiliaria: ${usuario.user.agencyName}"),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Web: ${usuario.user.web}"),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Teléfono: ${usuario.user.phoneNumber}"),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Verificación de cuenta: ${usuario.user.verified?"Si":"No"}"),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text("Calificación: "),
                      EstrellasCalificacion(cantidadEstrellas: usuario.user.qualification.ceil()),
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
                      _datosGenerales.setCity(City.empty());
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
                      _datosGenerales.setCity(City.empty());
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
  late UserProvider usuariosInfo;
  UseCaseUser useCaseUsuario=UseCaseUser();
  @override
  void initState() {
    super.initState();
    controllerNombres=TextEditingController(text: "");
    controllerApellidos=TextEditingController(text: "");
    controllerTelefono=TextEditingController(text: "");
    controllerPassword=TextEditingController(text: "");
    controllerPasswordConfirmar=TextEditingController(text: "");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      usuariosInfo = Provider.of<UserProvider>(context, listen: false);
      controllerNombres!.text=usuariosInfo.user.names;
      controllerApellidos!.text=usuariosInfo.user.surnames;
      controllerTelefono!.text=usuariosInfo.user.phoneNumber;
      imagen=usuariosInfo.user.photoLink;
    });
    
  }
  @override
  Widget build(BuildContext context) {
    final _usuario=Provider.of<UserProvider>(context);
    
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
                  FTextFieldBasico(
                    controller: controllerNombres!, 
                    labelText: "Nombres", onChanged: (x){}
                  ),
                  SizedBox(height: 5,),
                  FTextFieldBasico(
                    controller: controllerApellidos!, 
                    labelText: "Apellidos", onChanged: (x){}
                  ),
                  SizedBox(height: 5,),
                  FTextFieldBasico(
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
                      FTextFieldBasico(
                        controller: controllerPassword!, 
                        labelText: "Nueva contraseña", onChanged: (x){}
                      ),
                      SizedBox(height: 5,),
                      FTextFieldBasico(
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
                User usuarioAux=User.copyWith(_usuario.user);
                usuarioAux.photoLink=imagen;
                usuarioAux.names=controllerNombres!.text;
                usuarioAux.surnames=controllerApellidos!.text;
                usuarioAux.phoneNumber=controllerTelefono!.text;
                usuarioAux.password=controllerPassword!.text;
                useCaseUsuario.updateUser(usuarioAux)
                .then((completed){
                  if(completed){
                    _usuario.setUser(usuarioAux);
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
    /*final file=await ImageUtils.pickMedia(
      isGallery: isGallery,
      cropImage: cropCustomImage,
    );*/
    final file=await ImageUtils.uploadImage();
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
  City ciudad=City.empty();
  
  List<City> ciudades=[];
  TextEditingController? controllerAgencia;
  TextEditingController? controllerWeb;
  TextEditingController? controllerTelefono;
  dynamic imagen="";
  bool isGallery=true;
  bool loadingImage=false;
  UseCaseUser useCaseUsuario=UseCaseUser();
  @override
  void initState() {
    super.initState();
    
    controllerAgencia=TextEditingController(text: "");
    controllerWeb=TextEditingController(text: "");
    controllerTelefono=TextEditingController(text:"");
  }
  @override
  Widget build(BuildContext context) {
    final _datosGenerales=Provider.of<GeneralDataProvider>(context);
    final _usuario=Provider.of<UserProvider>(context);
    if(ciudad.id==""){
      _datosGenerales.cities.forEach((element) { 
        ciudades.add(City.copyWith(element));
      });
    }else{
      //_datosGenerales.seleccionarZonasLibres(widget.administradorZonas);
    }
    if(controllerTelefono!.text==""){
      controllerTelefono!.text=_usuario.user.phoneNumber;
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
                  FTextFieldBasico(
                    controller: controllerAgencia!, 
                    labelText: "Agencia", 
                    onChanged: (x){}
                  ),
                  SizedBox(height: 5,),
                  FTextFieldBasico(
                    controller: controllerWeb!, 
                    labelText: "Web", 
                    onChanged: (x){}
                  ),
                  SizedBox(height: 5,),
                  FTextFieldBasico(
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
                AgentRegistration inscripcionAgente=AgentRegistration.empty();
                inscripcionAgente.requestBackupLink=imagen.toString();
                inscripcionAgente.userRequest=User.copyWith(_usuario.user);
                inscripcionAgente.userRequest.web=controllerWeb!.text;
                inscripcionAgente.userRequest.agencyName=controllerAgencia!.text;
                inscripcionAgente.userRequest.city=_datosGenerales.citySelected.cityName;
               //print(inscripcionAgente.toMap());
                useCaseUsuario.registerAgentRegistrationRequest(inscripcionAgente).then((value) {
                  if(value["completed"]){
                    inscripcionAgente=value["inscripcion_agente"];
                    _usuario.setUser(inscripcionAgente.userRequest);
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
    /*final file=await ImageUtils.pickMedia(
      isGallery: isGallery,
      cropImage: cropCustomImage,
    );*/
    final file=await ImageUtils.uploadImage();
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
  final List<City> ciudades;
  @override
  _DropDownCiudadState createState() => _DropDownCiudadState();
}

class _DropDownCiudadState extends State<DropDownCiudad> {
  
  bool dropdownActivado=false;
  @override
  Widget build(BuildContext context) {
    final _datosGenerales=Provider.of<GeneralDataProvider>(context);
    if(_datosGenerales.citySelected.id==""){
      _datosGenerales.setCitySelected(widget.ciudades[0]);
    }
    return  Container(
      color: Colors.transparent,
      child: DropdownButton<City>(
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
        value: _datosGenerales.citySelected,
        onChanged: (City? value){
          setState(() {
            _datosGenerales.setCity(value);
            //widget.ciudad=Ciudad.copyWith(value!);
            //Wvalor=value!;
            dropdownActivado=false;
          });
        },
        items:widget.ciudades
        .map<DropdownMenuItem<City>>((City value) {
          return DropdownMenuItem<City>(
            value: value,
            child: Container(
              child: Text(value.cityName),
            )
            
          );
        }).toList()
      ),
    );
  }
}