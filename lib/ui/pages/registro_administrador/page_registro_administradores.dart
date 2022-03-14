import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/administrador_zona.dart';
import 'package:inmobiliariaapp/domain/entities/generales.dart';
import 'package:inmobiliariaapp/domain/entities/usuario.dart';
import 'package:inmobiliariaapp/domain/usecases/usuario/usecase_administrador.dart';
import 'package:inmobiliariaapp/domain/usecases/usuario/usecase_super_usuario.dart';
import 'package:inmobiliariaapp/domain/usecases/usuario/usecase_usuario.dart';
import 'package:inmobiliariaapp/ui/provider/datos_generales_info.dart';
import 'package:inmobiliariaapp/widgets/textField_modelos.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' as iconc;
import 'package:provider/provider.dart';
class PageRegistroAdministradores extends StatefulWidget {
  PageRegistroAdministradores({Key? key}) : super(key: key);

  @override
  _PageRegistroAdministradoresState createState() => _PageRegistroAdministradoresState();
}

class _PageRegistroAdministradoresState extends State<PageRegistroAdministradores> {
  List<Usuario> administradores=[];
  int selected=-1;
  TextEditingController? controllerEmail;
  Usuario usuario=Usuario.vacio();
  String textoDatos="";
  UseCaseSuperUsuario useCaseSuperUsuario=UseCaseSuperUsuario();
  UseCaseUsuario useCaseUsuario=UseCaseUsuario();
  @override
  void initState() {
    super.initState();
    controllerEmail=TextEditingController(text: "");
    useCaseSuperUsuario.obtenerAdministradores().then((value){
      if(value["completed"]){
        administradores=value["administradores"];
        setState(() {
          
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Registro de administradores"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: administradores.length,
                itemBuilder: (context, index) {
                  Usuario administrador=administradores[index];
                  return ListTile(
                    selectedTileColor: Colors.blue.withOpacity(0.05),
                    selected: selected==index,
                    tileColor: (index+1)%2==0?Colors.black.withOpacity(0.05):Colors.white,
                    title: Text("${administrador.nombres} ${administrador.apellidos}"),
                    subtitle: Text("${administrador.correo}"),
                    trailing: Container(
                      height: 50,
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            tooltip: "Asignar zonas",
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context){
                                    return PageAsignarZonasAdministrador(administrador: administrador);
                                  }
                                ),
                              );
                            }, 
                            icon: Icon(Icons.public,color: Colors.blue[600],)
                          ),
                          IconButton(
                            tooltip: "Inhabilitar",
                            onPressed: (){
                              useCaseSuperUsuario.inhabilitarAdministradores(administrador.id).then((value) {
                                if(value){
                                  selected=-1;
                                  administradores.removeAt(index);
                                  setState(() {
                                    
                                  });
                                }
                              });
                            }, 
                            icon: iconc.FaIcon(iconc.FontAwesomeIcons.handPointDown,size:20,color: Colors.red)
                          )
                        ],
                      ),
                    ),
                    onTap: (){
                      if(selected==index){
                        selected=-1;
                      }else{
                        selected=index;
                      }
                      setState(() {
                        
                      });
                    },
                  );
                },
              )
            ),
            Container(
              padding: EdgeInsets.all(5),
              height: 0.5,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
            ),
            if(selected<0)Container(
              padding: EdgeInsets.all(5),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFFBasico(
                          controller: controllerEmail!, 
                          labelText: "Email", 
                          onChanged: (x){}
                        ),
                      ),
                      IconButton(
                        onPressed: (){
                          useCaseUsuario.buscarUsuarioEmail(controllerEmail!.text).then((value){
                            if(value["completed"]){
                              usuario=value["usuario"];
                              textoDatos="Usuario: ${usuario.nombres} ${usuario.apellidos}";
                              setState(() {
                                
                              });
                            }else{
                              textoDatos="No se encotró al usuario, revise el email";
                              setState(() {
                                
                              });
                            }
                          });
                        }, 
                        icon: Icon(Icons.search)
                      )
                    ],
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(textoDatos)
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      useCaseSuperUsuario.habilitarAdministradores(usuario.id).then((value){
                        if(value){
                          usuario.tipoUsuario="Administrador";
                          administradores.add(usuario);
                          setState(() {
                            
                          });
                        }
                      });
                    }, 
                    child: Text("Habilitar")
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
class PageAsignarZonasAdministrador extends StatefulWidget {
  PageAsignarZonasAdministrador({Key? key,required this.administrador}) : super(key: key);
  final Usuario administrador;
  @override
  _PageAsignarZonasAdministradorState createState() => _PageAsignarZonasAdministradorState();
}

class _PageAsignarZonasAdministradorState extends State<PageAsignarZonasAdministrador> {
  List<AdministradorZona> administradorZonas=[];
  UseCaseSuperUsuario useCaseSuperUsuario=UseCaseSuperUsuario();
  UseCaseAdministrador useCaseAdministrador=UseCaseAdministrador();
  @override
  void initState() {
    super.initState();
    useCaseAdministrador.obtenerAdministradorZonas(widget.administrador.id).then((value) {
      if(value["completed"]){
        administradorZonas=value["administrador_zonas"];
        setState(() {
          
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final _datosGenerales=Provider.of<DatosGeneralesInfo>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Asignar zonas administrador"),
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Text("Zonas asignadas al administrador"),
            Expanded(
              child: ListView.builder(
                itemCount: administradorZonas.length,
                itemBuilder: (context, index) {
                  AdministradorZona administradorZona=administradorZonas[index];
                  return ListTile(
                    tileColor: (index+1)%2==0?Colors.black.withOpacity(0.05):Colors.white,
                    title: Text(administradorZona.zona.nombreZona),
                    trailing: IconButton(
                      tooltip: "Quitar",
                      onPressed: (){
                        useCaseSuperUsuario.quitarAdministradorZona(administradorZona.id).then((value){
                          if(value){
                            administradorZonas.removeAt(index);
                            _datosGenerales.seleccionarZonasLibres(administradorZonas);
                            setState(() {
                              
                            });
                          }
                        });
                      },
                      icon: iconc.FaIcon(iconc.FontAwesomeIcons.handPointDown,size:20,color: Colors.red)
                    ),
                  );
                },
              )
            ),
            Container(
              padding: EdgeInsets.all(5),
              height: 0.5,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
            ),
            Text("Zonas libres"),
            Expanded(
              child: ListView.builder(
                itemCount: _datosGenerales.zonasLibres.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    tileColor: (index+1)%2==0?Colors.black.withOpacity(0.05):Colors.white,
                    title: Text(_datosGenerales.zonasLibres[index].nombreZona),
                    trailing: IconButton(
                      tooltip: "Asignar",
                      onPressed: (){
                        useCaseSuperUsuario.asignarAdministradorZona(widget.administrador.id, _datosGenerales.zonasLibres[index].id).then((value){
                          if(value["completed"]){
                            AdministradorZona administradorZona=AdministradorZona.vacio();
                            administradorZona.zona=_datosGenerales.zonasLibres[index];
                            administradorZona.id=value["id"];
                            administradorZonas.add(administradorZona);
                            _datosGenerales.seleccionarZonasLibres(administradorZonas);
                            setState(() {
                              
                            });
                          }
                        });
                      },
                      icon: iconc.FaIcon(iconc.FontAwesomeIcons.handPointUp,size:20,color: Colors.blue)
                    ),
                  );
                },
              )
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Ciudad: "),
                  DropDownCiudad(administradorZonas: administradorZonas,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class DropDownCiudad extends StatefulWidget {
  DropDownCiudad({Key? key,required this.administradorZonas}) : super(key: key);
  final List<AdministradorZona> administradorZonas;
  @override
  _DropDownCiudadState createState() => _DropDownCiudadState();
}

class _DropDownCiudadState extends State<DropDownCiudad> {
  
  bool dropdownActivado=false;
  Ciudad ciudad=Ciudad.vacio();
  @override
  Widget build(BuildContext context) {
    final _datosGenerales=Provider.of<DatosGeneralesInfo>(context);
    if(ciudad.id==""){
      ciudad=_datosGenerales.ciudades[0];
      //_datosGenerales.seleccionarZonasCiudad(ciudad.id);
      
    }else{
      //_datosGenerales.seleccionarZonasLibres(widget.administradorZonas);
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
        value: ciudad,
        onChanged: (Ciudad? value){
          _datosGenerales.seleccionarZonasCiudad(value!.id);
          _datosGenerales.seleccionarZonasLibres(widget.administradorZonas);
          setState(() {
            ciudad=value;
            //Wvalor=value!;
            dropdownActivado=false;
          });
        },
        items:_datosGenerales.ciudades
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