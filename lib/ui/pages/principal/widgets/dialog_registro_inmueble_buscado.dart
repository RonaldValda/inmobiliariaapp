import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/usuarios_inmuebles_favoritos.dart';
import 'package:inmobiliariaapp/domain/usecases/usuario/usecase_usuario.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' as iconc;
import 'package:inmobiliariaapp/ui/pages/principal/widgets/container_listado_inmuebles.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_comunidad_info.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_generales_info.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_internas_info.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_otros_info.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_principales_info.dart';
import 'package:inmobiliariaapp/ui/provider/usuarios_info.dart';
import 'package:inmobiliariaapp/widgets/textField_modelos.dart';
import 'package:inmobiliariaapp/domain/usecases/inmueble/filtrado_inmuebles.dart' as filtrado_inmuebles;
import 'package:inmobiliariaapp/widgets/utils.dart';
import 'package:provider/provider.dart';
Future dialogRegistroInmuebleBuscado(
  BuildContext context,
)async{
  
 return await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext ctx){
      return StatefulBuilder(
        builder: (BuildContext ctx,StateSetter setState){
          return SimpleDialog(
            contentPadding: EdgeInsets.zero,
            titlePadding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
            title: const Center(child: Text("Guardar configuración",style: TextStyle(fontSize: 20)),),
            children: [
              RegistroInmuebleBuscado()
            ],
          );
        }
      );
    }
  ); 
}
class RegistroInmuebleBuscado extends StatefulWidget {
  RegistroInmuebleBuscado({Key? key}) : super(key: key);

  @override
  _RegistroInmuebleBuscadoState createState() => _RegistroInmuebleBuscadoState();
}

class _RegistroInmuebleBuscadoState extends State<RegistroInmuebleBuscado> {
  bool nuevoRegistro=false;
  TextEditingController? controller;
  TextEditingController? controllerTelefono;
  String error="";
  int seleccionado=-1;
  UseCaseUsuario useCaseUsuario=UseCaseUsuario();
  @override
  void initState() {
    super.initState();
    controller=TextEditingController(text:"");
    controllerTelefono=TextEditingController(text: "");
  }
  @override
  Widget build(BuildContext context) {
    final _usuario=Provider.of<UsuariosInfo>(context);
    final _mapaFiltroGenerales=Provider.of<MapaFiltroGeneralesInfo>(context);
    final _mapaFiltroInternas=Provider.of<MapaFiltroInternasInfo>(context);
    final _mapaFiltroComunidad=Provider.of<MapaFiltroComunidadInfo>(context);
    final _mapaFiltroOtros=Provider.of<MapaFiltroOtrosInfo>(context);
    final _mapaFiltroPrincipales=Provider.of<MapaFiltroPrincipalesInfo>(context);
  
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: (){
              nuevoRegistro=!nuevoRegistro;
              setState(() {
                
              });
            }, 
            child: Icon(Icons.add,color:nuevoRegistro?Colors.white:Colors.blue),
            style: ElevatedButton.styleFrom(
              primary: nuevoRegistro?Colors.blue:Colors.white,
              animationDuration: Duration(milliseconds: 500),
              //onPrimary: Colors.cyan,
              //onSurface: Colors.green,
              shape: StadiumBorder(),
              side: BorderSide(color: Colors.grey)
            )
          ),
          if(nuevoRegistro)
          Column(
            children: [
              TextFFBasico(
                controller: controller!, 
                labelText: "Nombre configuración", 
                onChanged: (x){
                }
              ),
              SizedBox(height: 5,),
              TextFFBasico(
                controller: controllerTelefono!, 
                labelText: "Número de contacto", 
                onChanged: (x){
                }
              ),
            ],
          ),
          
          if(!nuevoRegistro&&_usuario.usuarioInmueblesBuscados.length>0)
          Column(
            children: [
              Divider(),
              Container(
                height: MediaQuery.of(context).size.height/5,
                width: MediaQuery.of(context).size.width/2,
                child: ListView.builder(
                  itemCount: _usuario.usuarioInmueblesBuscados.length,
                  itemBuilder: (context, index) {
                    UsuarioInmuebleBuscado buscado=_usuario.usuarioInmueblesBuscados[index];
                    return ListTile(
                      selected: seleccionado==index,
                      selectedTileColor: Colors.blue.withOpacity(0.1),
                      tileColor:(index+1)%2==0?Colors.black.withOpacity(0.05):Colors.transparent,
                      title: Text("${buscado.nombreConfiguracion}"),
                      subtitle: Text("Contacto: ${buscado.numeroTelefono}"),
                      onTap: (){
                        if(seleccionado==index){
                          seleccionado=-1;
                        }else{
                          seleccionado=index;
                        }
                        setState(() {
                          
                        });
                      },
                    );
                  },
                )
              ),
            ],
          ),
          //DropdownUsuarioInmueblesBuscados(),
          OutlinedButton(
            onPressed: (){
              if(nuevoRegistro){
                Map<String,dynamic> mapInmuebleBuscado={};
                  mapInmuebleBuscado.addAll(_mapaFiltroPrincipales.getMapaFiltro);
                  mapInmuebleBuscado.addAll(_mapaFiltroGenerales.getMapaFiltro);
                  mapInmuebleBuscado.addAll(_mapaFiltroGenerales.getMapaFiltroMas);
                  mapInmuebleBuscado.addAll(_mapaFiltroInternas.getMapaFiltro);
                  mapInmuebleBuscado.addAll(_mapaFiltroInternas.getMapaFiltroMas);
                  mapInmuebleBuscado.addAll(_mapaFiltroComunidad.getMapaFiltro);
                  mapInmuebleBuscado.addAll(_mapaFiltroComunidad.getMapaFiltroMas);
                  mapInmuebleBuscado.addAll(_mapaFiltroOtros.getMapaFiltro);
                  mapInmuebleBuscado.addAll(_mapaFiltroOtros.getMapaFiltroMas);
                useCaseUsuario.registrarUsuarioInmuebleBuscado(
                  controller!.text,
                  controllerTelefono!.text,
                  _usuario.usuario,
                  mapInmuebleBuscado
                ).then((value) {
                  if(value["completed"]){
                    _usuario.usuarioInmueblesBuscados.add(value["usuario_inmueble_buscado"]);
                  }
                }).whenComplete(() {
                  Navigator.pop(context);
                });
              }else{
                if(_usuario.usuarioInmueblesBuscados.length>0){
                  //print(_inmueblesFiltrado.filtroBuscadoSeleccionado);
                  //print(_usuario.usuarioInmueblesBuscados[_inmueblesFiltrado.filtroBuscadoSeleccionado]);
                  Map<String,dynamic> mapInmuebleBuscado={};
                  mapInmuebleBuscado.addAll(_usuario.usuario.toMap());
                  mapInmuebleBuscado.addAll(_mapaFiltroPrincipales.getMapaFiltro);
                  mapInmuebleBuscado.addAll(_mapaFiltroGenerales.getMapaFiltro);
                  mapInmuebleBuscado.addAll(_mapaFiltroGenerales.getMapaFiltroMas);
                  mapInmuebleBuscado.addAll(_mapaFiltroInternas.getMapaFiltro);
                  mapInmuebleBuscado.addAll(_mapaFiltroInternas.getMapaFiltroMas);
                  mapInmuebleBuscado.addAll(_mapaFiltroComunidad.getMapaFiltro);
                  mapInmuebleBuscado.addAll(_mapaFiltroComunidad.getMapaFiltroMas);
                  mapInmuebleBuscado.addAll(_mapaFiltroOtros.getMapaFiltro);
                  mapInmuebleBuscado.addAll(_mapaFiltroOtros.getMapaFiltroMas);

                  useCaseUsuario.modificarUsuarioInmuebleBuscado(
                    _usuario.usuarioInmueblesBuscados[seleccionado],
                    mapInmuebleBuscado
                  ).then((value) {
                    if(value["completed"]){
                      print("completado");
                      _usuario.usuarioInmueblesBuscados.removeWhere((element) => element.id==_usuario.usuarioInmueblesBuscados[seleccionado].id);
                      _usuario.usuarioInmueblesBuscados.add(value["usuario_inmueble_buscado"]);
                    }
                  }).whenComplete(() {
                    Navigator.pop(context);
                  });
                }
              }
            }, 
            child: Text(nuevoRegistro?"Registrar":"Modificar")
          )
        ],
      ),
    );
  }
}
class DropdownUsuarioInmueblesBuscados extends StatefulWidget {
  DropdownUsuarioInmueblesBuscados({Key? key}) : super(key: key);
  @override
  _DropdownUsuarioInmueblesBuscadosState createState() => _DropdownUsuarioInmueblesBuscadosState();
}

class _DropdownUsuarioInmueblesBuscadosState extends State<DropdownUsuarioInmueblesBuscados> {
  List<String> items=[];
  String valor="Común";
  bool dropdownActivado=false;
  @override
  Widget build(BuildContext context) {
    final _usuario=Provider.of<UsuariosInfo>(context);
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    if(_inmueblesFiltrado.filtroBuscadoSeleccionado<0){
      _inmueblesFiltrado.filtroBuscadoSeleccionado=0;
    }
    return  Container(
      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
      margin: EdgeInsets.fromLTRB(8, 5, 8, 5),
      //color: Colors.amberAccent,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black38,width: 1),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white
      ),
      child: Row(
        children: [
          SizedBox(width: 10,),
          DropdownButton<UsuarioInmuebleBuscado>(
            icon: Icon(Icons.arrow_drop_down,color: Colors.black54,),
            style: dropdownActivado?TextStyle(
              color:  Colors.black54
            ):TextStyle(
              color: Colors.black54,
              fontSize: 15
            ),
            
            onTap: (){
              setState(() {
                dropdownActivado=true;
              });
              
            },
            dropdownColor: Colors.white.withOpacity(0.8),
            value: _usuario.usuarioInmueblesBuscados[_inmueblesFiltrado.filtroBuscadoSeleccionado],
            onChanged: (UsuarioInmuebleBuscado? value){
              _inmueblesFiltrado.filtroBuscadoSeleccionado= _usuario.usuarioInmueblesBuscados.indexOf(value!);
              setState(() {
                
              });
            },
            items: _usuario.usuarioInmueblesBuscados
            .map<DropdownMenuItem<UsuarioInmuebleBuscado>>((UsuarioInmuebleBuscado value) {
              return DropdownMenuItem<UsuarioInmuebleBuscado>(
                value: value,
                child: Container(
                  child: Text(value.nombreConfiguracion),
                )
                
              );
            }).toList()
          ),
        ],
      ),
    );
  }
}
Future dialogCargarFiltros(
  BuildContext context,
)async{
  
 return await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext ctx){
      return StatefulBuilder(
        builder: (BuildContext ctx,StateSetter setState){
          return SimpleDialog(
            contentPadding: EdgeInsets.zero,
            titlePadding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
            title: const Center(child: Text("Configuraciones guardadas",style: TextStyle(fontSize: 20)),),
            children: [
              CargarInmuebleBuscado()
            ],
          );
        }
      );
    }
  ); 
}
class CargarInmuebleBuscado extends StatefulWidget {
  CargarInmuebleBuscado({Key? key}) : super(key: key);

  @override
  _CargarInmuebleBuscadoState createState() => _CargarInmuebleBuscadoState();
}

class _CargarInmuebleBuscadoState extends State<CargarInmuebleBuscado> {
  //int seleccionado=-1;
  TextEditingController? controllerNombreConfiguracion;
  TextEditingController? controllerNumeroTelefono;
  UsuarioInmuebleBuscado buscadoEditar=UsuarioInmuebleBuscado.vacio();
  UseCaseUsuario useCaseUsuario=UseCaseUsuario();
  @override
  void initState() {
    controllerNumeroTelefono=TextEditingController(text:  "");
    controllerNombreConfiguracion=TextEditingController(text: "");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final _usuario=Provider.of<UsuariosInfo>(context);
    final _mapaFiltroGenerales=Provider.of<MapaFiltroGeneralesInfo>(context);
    final _mapaFiltroInternas=Provider.of<MapaFiltroInternasInfo>(context);
    final _mapaFiltroComunidad=Provider.of<MapaFiltroComunidadInfo>(context);
    final _mapaFiltroOtros=Provider.of<MapaFiltroOtrosInfo>(context);
    final _mapaFiltroPrincipales=Provider.of<MapaFiltroPrincipalesInfo>(context);
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    for(int i=0;i<_usuario.usuarioInmueblesBuscados.length;i++){
      Map<String,dynamic> mapFiltro={};
      mapFiltro.addAll(_usuario.usuarioInmueblesBuscados[i].toMap());
      mapFiltro.addAll({"fecha_penultimo_ingreso":_usuario.usuario.fechaPenultimoIngreso});
      int contador=filtrado_inmuebles.filtrarInmuebles(inmueblesTotalGeneral, mapFiltro).length;
      _usuario.usuarioInmueblesBuscados[i].cantidadEncontrados=contador;
    }
    _usuario.usuarioInmueblesBuscados.sort((b,a)=>a.cantidadEncontrados.compareTo(b.cantidadEncontrados),);
    return Container(
      //padding: EdgeInsets.all(20),
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height/2.5,
      child: Column(
        children: [
          _usuario.usuarioInmueblesBuscados.length>0?
          Expanded(
            child: ListView.builder(
              itemCount: _usuario.usuarioInmueblesBuscados.length,
              itemBuilder: (context, index) {
                UsuarioInmuebleBuscado buscado=_usuario.usuarioInmueblesBuscados[index];
                return Column(
                  children: [
                    ListTile(
                      leading: Container(
                        width: 20,
                        child: Tooltip(
                          message: "Editar",
                          child: InkWell(
                            child: Icon(Icons.edit),
                            onTap: (){
                              if(buscadoEditar.id!=buscado.id){
                                buscadoEditar=UsuarioInmuebleBuscado.copyWith(buscado);
                                _inmueblesFiltrado.filtroBuscadoSeleccionado=index;
                                controllerNombreConfiguracion!.text=buscadoEditar.nombreConfiguracion;
                                controllerNumeroTelefono!.text=buscadoEditar.numeroTelefono;
                              }else{
                                buscadoEditar=UsuarioInmuebleBuscado.vacio();
                                _inmueblesFiltrado.filtroBuscadoSeleccionado=-1;
                                controllerNombreConfiguracion!.text="";
                                controllerNumeroTelefono!.text="";
                              }
                              setState(() {
                                
                              });
                            },
                          ),
                        ),
                      ),
                      minLeadingWidth: 20,
                      selected: _inmueblesFiltrado.filtroBuscadoSeleccionado==index,
                      selectedTileColor: Colors.blue.withOpacity(0.1),
                      tileColor:(index+1)%2==0?Colors.black.withOpacity(0.05):Colors.transparent,
                      title: Row(
                        children: [
                          if(buscado.cantidadEncontrados>0)
                          IconoNumeroNotificacion(numeroNotificaciones: buscado.cantidadEncontrados.toString(), size: Size(25,25)),
                          Text("${buscado.nombreConfiguracion}",style: TextStyle(fontSize: 13),),
                        ],
                      ),
                      subtitle: Text("Contacto: ${buscado.numeroTelefono}",style: TextStyle(fontSize: 12),),
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),

                      trailing: Container(
                        width: 60,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child:Tooltip(
                                message: "WhatsApp",
                                child: InkWell(
                                  child: iconc.FaIcon(iconc.FontAwesomeIcons.whatsapp),
                                  onTap: (){

                                  },
                                ),
                              )
                            ),
                            Container(
                              child:Tooltip(
                                message: "Llamar",
                                child: InkWell(
                                  child: iconc.FaIcon(iconc.FontAwesomeIcons.phone),
                                  onTap: ()async{
                                    String number = _usuario.usuarioInmueblesBuscados[index].numeroTelefono; //set the number here
                                    await FlutterPhoneDirectCaller.callNumber(number);
                                  },
                                ),
                              )
                            ),
                          ],
                        ),
                      ),
                      onTap: (){
                        if(_inmueblesFiltrado.filtroBuscadoSeleccionado==index){
                          _inmueblesFiltrado.filtroBuscadoSeleccionado=-1;
                          buscadoEditar=UsuarioInmuebleBuscado.vacio();
                        }else{
                          _inmueblesFiltrado.filtroBuscadoSeleccionado=index;
                          buscadoEditar=UsuarioInmuebleBuscado.vacio();
                        }
                        setState(() {
                          
                        });
                      },
                    ),
                    if(buscadoEditar.id==buscado.id)Container(
                      color: Colors.blue.withOpacity(0.1),
                      child: Column(
                        children: [
                          TextFFBasico(
                            controller: controllerNombreConfiguracion!, 
                            labelText: "Nombre configuración", 
                            onChanged: (x){
                              buscadoEditar.nombreConfiguracion=x;
                            }
                          ),
                          SizedBox(height: 5,),
                          TextFFBasico(
                            controller: controllerNumeroTelefono!, 
                            labelText: "Número de teléfono", 
                            onChanged: (x){
                              buscadoEditar.numeroTelefono=x;
                            }
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OutlinedButton(
                                onPressed: (){
                                  useCaseUsuario.modificarUsuarioInmueblesBuscadosPersonales(buscadoEditar).then((value) {
                                    if(value){
                                      _usuario.usuarioInmueblesBuscados.removeAt(_inmueblesFiltrado.filtroBuscadoSeleccionado);
                                      _usuario.usuarioInmueblesBuscados.add(buscadoEditar);
                                      buscadoEditar=UsuarioInmuebleBuscado.vacio();
                                      setState(() {
                                        
                                      });
                                    }
                                  });
                                },child: Text("Guardar")
                              ),
                              SizedBox(width: 5,),
                              OutlinedButton(
                                onPressed: (){
                                  buscadoEditar=UsuarioInmuebleBuscado.vacio();
                                  setState(() {
                                    
                                  });
                                },
                                child: Text("Cancelar",
                                  style: TextStyle(color: Colors.red),
                                )
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                );
              },
            )
          )
          :
          Text("No tiene filtros guardados"),
          //DropdownUsuarioInmueblesBuscados():,
          ElevatedButton(
            onPressed: (){
              if(_inmueblesFiltrado.filtroBuscadoSeleccionado>=0){
                cargarFiltros(
                  _usuario.usuarioInmueblesBuscados[_inmueblesFiltrado.filtroBuscadoSeleccionado],
                   _mapaFiltroGenerales.getMapaFiltro,_mapaFiltroGenerales.getMapaFiltroMas,
                   _mapaFiltroInternas.getMapaFiltro,_mapaFiltroInternas.getMapaFiltroMas,
                   _mapaFiltroComunidad.getMapaFiltro,_mapaFiltroComunidad.getMapaFiltroMas,
                   _mapaFiltroOtros.getMapaFiltro,_mapaFiltroOtros.getMapaFiltroMas,
                   _mapaFiltroPrincipales.getMapaFiltro);
                _inmueblesFiltrado.setFiltrar(true);
                _mapaFiltroGenerales.setMapaFiltroItem("superficie_terreno_min",_mapaFiltroGenerales.getMapaFiltro["superficie_terreno_min"]);
              }
            },
            child: Text("Aplicar filtros")
          )
        ],
      ),
    );
  }
  void cargarFiltros(
    UsuarioInmuebleBuscado buscado,
    Map<String,dynamic> _mapaFiltroGenerales,
    Map<String,dynamic> _mapaFiltroGeneralesMas,
    Map<String,dynamic> _mapaFiltroInternas,
    Map<String,dynamic> _mapaFiltroInternasMas,
    Map<String,dynamic> _mapaFiltroComunidad,
    Map<String,dynamic> _mapaFiltroComunidadMas,
    Map<String,dynamic> _mapaFiltroOtros,
    Map<String,dynamic> _mapaFiltroOtrosMas,
    Map<String,dynamic> _mapaFiltroPrincipales
  ){
   
    List<int> superficiesTerreno=[0,0,150,200,250,300];
    List<int> superficiesConstruccion=[0,0,100,200,300,400];
    List<int> antiguedadConstruccion=[0,0,10,20,30];
    List<int> tamanioFrente=[0,0,5,10,15,20];
    Map<String,dynamic> mapBuscado=buscado.toMap();
    _mapaFiltroGenerales.forEach((key, value) { 
      _mapaFiltroGenerales[key]=mapBuscado[key]??value;
    });
    _mapaFiltroGeneralesMas.forEach((key, value) { 
      _mapaFiltroGeneralesMas[key]=mapBuscado[key]??value;
    });
    _mapaFiltroGenerales["superficie_terreno_sel"]=getValorSeleccionado(superficiesTerreno, _mapaFiltroGenerales["superficie_terreno_min"], _mapaFiltroGenerales["superficie_terreno_max"]);
    _mapaFiltroGenerales["superficie_construccion_sel"]=getValorSeleccionado(superficiesConstruccion, _mapaFiltroGenerales["superficie_construccion_min"], _mapaFiltroGenerales["superficie_construccion_max"]);
    _mapaFiltroGenerales["antiguedad_construccion_sel"]=getValorSeleccionado(antiguedadConstruccion, _mapaFiltroGenerales["antiguedad_construccion_min"], _mapaFiltroGenerales["antiguedad_construccion_max"]);
    _mapaFiltroGenerales["tamanio_frente_sel"]=getValorSeleccionado(tamanioFrente, _mapaFiltroGenerales["tamanio_frente_min"], _mapaFiltroGenerales["tamanio_frente_max"]);
    _mapaFiltroInternas.forEach((key, value) { 
      _mapaFiltroInternas[key]=mapBuscado[key]??value;
    });
    _mapaFiltroInternasMas.forEach((key, value) { 
      _mapaFiltroInternasMas[key]=mapBuscado[key]??value;
    });
    _mapaFiltroComunidad.forEach((key, value) { 
      _mapaFiltroComunidad[key]=mapBuscado[key]??value;
    });
    _mapaFiltroComunidadMas.forEach((key, value) { 
      _mapaFiltroComunidadMas[key]=mapBuscado[key]??value;
    });
    _mapaFiltroOtros.forEach((key, value) { 
      _mapaFiltroOtros[key]=mapBuscado[key]??value;
    });
    _mapaFiltroOtrosMas.forEach((key, value) { 
      _mapaFiltroOtrosMas[key]=mapBuscado[key]??value;
    });
    _mapaFiltroPrincipales.forEach((key, value) { 
      _mapaFiltroPrincipales[key]=mapBuscado[key]??value;
    });
  }
  String getValorSeleccionado(List<int> numeros,int valorMin,int valorMax){
    String valorSeleccionado="";
    if(valorMax>0&&valorMin>0){
      for(int i=1;i<numeros.length;i++){
        if(numeros[i]==valorMin){
          if(i<numeros.length-1){
            valorSeleccionado=numeros[i].toString()+"-"+(numeros[i+1]-1).toString();
          }else{
            valorSeleccionado=numeros[i].toString()+" a más";
          }
        }
      }
    }else{
      valorSeleccionado="Cualquiera";
    }
    return valorSeleccionado;
  }
}
