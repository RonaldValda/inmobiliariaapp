import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/administrator_zone.dart';
import 'package:inmobiliariaapp/domain/entities/generals.dart';
import 'package:inmobiliariaapp/domain/entities/user.dart';
import 'package:inmobiliariaapp/domain/usecases/user/usecase_administrator.dart';
import 'package:inmobiliariaapp/domain/usecases/user/usecase_super_user.dart';
import 'package:inmobiliariaapp/domain/usecases/user/usecase_user.dart';
import 'package:inmobiliariaapp/ui/provider/generals/general_data_provider.dart';
import 'package:inmobiliariaapp/widgets/f_text_fields.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' as iconc;
import 'package:provider/provider.dart';
class PageRegistroAdministradores extends StatefulWidget {
  PageRegistroAdministradores({Key? key}) : super(key: key);

  @override
  _PageRegistroAdministradoresState createState() => _PageRegistroAdministradoresState();
}

class _PageRegistroAdministradoresState extends State<PageRegistroAdministradores> {
  List<User> administradores=[];
  int selected=-1;
  TextEditingController? controllerEmail;
  User usuario=User.empty();
  String textoDatos="";
  UseCaseSuperUser useCaseSuperUsuario=UseCaseSuperUser();
  UseCaseUser useCaseUsuario=UseCaseUser();
  @override
  void initState() {
    super.initState();
    controllerEmail=TextEditingController(text: "");
    useCaseSuperUsuario.getAdministrators().then((value){
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
                  User administrador=administradores[index];
                  return ListTile(
                    selectedTileColor: Colors.blue.withOpacity(0.05),
                    selected: selected==index,
                    tileColor: (index+1)%2==0?Colors.black.withOpacity(0.05):Colors.white,
                    title: Text("${administrador.names} ${administrador.surnames}"),
                    subtitle: Text("${administrador.email}"),
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
                              useCaseSuperUsuario.disableAdministrator(administrador.id).then((value) {
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
                        child: FTextFieldBasico(
                          controller: controllerEmail!, 
                          labelText: "Email", 
                          onChanged: (x){}
                        ),
                      ),
                      IconButton(
                        onPressed: (){
                          useCaseUsuario.searchUserEmail(controllerEmail!.text).then((value){
                            if(value["completed"]){
                              usuario=value["usuario"];
                              textoDatos="Usuario: ${usuario.names} ${usuario.surnames}";
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
                      useCaseSuperUsuario.enableAdministrator(usuario.id).then((value){
                        if(value){
                          usuario.userType="Administrador";
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
  final User administrador;
  @override
  _PageAsignarZonasAdministradorState createState() => _PageAsignarZonasAdministradorState();
}

class _PageAsignarZonasAdministradorState extends State<PageAsignarZonasAdministrador> {
  List<AdministratorZone> administradorZonas=[];
  UseCaseSuperUser useCaseSuperUsuario=UseCaseSuperUser();
  UseCaseAdministrator useCaseAdministrador=UseCaseAdministrator();
  @override
  void initState() {
    super.initState();
    useCaseAdministrador.getAdministratorZones(widget.administrador.id).then((value) {
      if(value["completed"]){
        administradorZonas=value["administrador_zonas"];
        setState(() {
          
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final _datosGenerales=Provider.of<GeneralDataProvider>(context);
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
                  AdministratorZone administradorZona=administradorZonas[index];
                  return ListTile(
                    tileColor: (index+1)%2==0?Colors.black.withOpacity(0.05):Colors.white,
                    title: Text(administradorZona.zone.zoneName),
                    trailing: IconButton(
                      tooltip: "Quitar",
                      onPressed: (){
                        useCaseSuperUsuario.removeAdministratorZone(administradorZona.id).then((value){
                          if(value){
                            administradorZonas.removeAt(index);
                            _datosGenerales.selectZonesFrees(administradorZonas);
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
                itemCount: _datosGenerales.zonesFree.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    tileColor: (index+1)%2==0?Colors.black.withOpacity(0.05):Colors.white,
                    title: Text(_datosGenerales.zonesFree[index].zoneName),
                    trailing: IconButton(
                      tooltip: "Asignar",
                      onPressed: (){
                        useCaseSuperUsuario.assignAdministratorZone(widget.administrador.id, _datosGenerales.zonesFree[index].id).then((value){
                          if(value["completed"]){
                            AdministratorZone administradorZona=AdministratorZone.empty();
                            administradorZona.zone=_datosGenerales.zonesFree[index];
                            administradorZona.id=value["id"];
                            administradorZonas.add(administradorZona);
                            _datosGenerales.selectZonesFrees(administradorZonas);
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
  final List<AdministratorZone> administradorZonas;
  @override
  _DropDownCiudadState createState() => _DropDownCiudadState();
}

class _DropDownCiudadState extends State<DropDownCiudad> {
  
  bool dropdownActivado=false;
  City ciudad=City.empty();
  @override
  Widget build(BuildContext context) {
    final _datosGenerales=Provider.of<GeneralDataProvider>(context);
    if(ciudad.id==""){
      ciudad=_datosGenerales.cities[0];
      //_datosGenerales.seleccionarZonasCiudad(ciudad.id);
      
    }else{
      //_datosGenerales.seleccionarZonasLibres(widget.administradorZonas);
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
        value: ciudad,
        onChanged: (City? value){
          _datosGenerales.selectZonesCity(value!.id);
          _datosGenerales.selectZonesFrees(widget.administradorZonas);
          setState(() {
            ciudad=value;
            //Wvalor=value!;
            dropdownActivado=false;
          });
        },
        items:_datosGenerales.cities
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