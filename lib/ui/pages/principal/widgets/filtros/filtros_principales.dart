
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/generales.dart';
import 'package:inmobiliariaapp/ui/provider/datos_generales_info.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_generales_info.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_principales_info.dart';
import 'package:provider/provider.dart';

class FiltroTipoContrato extends StatefulWidget {
  FiltroTipoContrato({Key? key}) : super(key: key);
  
  @override
  _FiltroTipoContratoState createState() => _FiltroTipoContratoState();
}

class _FiltroTipoContratoState extends State<FiltroTipoContrato> {
  List<String> items=[];
  String valor="Todos";
  bool dropdownActivado=false;
  @override
  Widget build(BuildContext context) {
    //listarTipoContrato();
    final _mapaFiltroGenerales=Provider.of<MapaFiltroGeneralesInfo>(context);
    final _mapaFiltro=Provider.of<MapaFiltroPrincipalesInfo>(context);
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    return  Container(
      child: 
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.layers,size: 20,),
              DropdownButton(
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
                value: valor,
                onChanged: (String? value){
                  _mapaFiltro.isCambio=true;
                  _mapaFiltroGenerales.getMapaFiltro["precio_min"]=0;
                  _mapaFiltroGenerales.getMapaFiltro["precio_max"]=-1000;
                  _mapaFiltroGenerales.getMapaFiltro["precio_sel"]="Cualquiera";
                  _inmueblesFiltrado.consultarBD=false;
                  _inmueblesFiltrado.setFiltrar(true);
                  _mapaFiltro.setMapaFiltroItem("tipo_contrato", value);
                  _mapaFiltro.setLoading(!_mapaFiltro.isLoading);
                  
                  
                  //_mapaFiltro.setMapaFiltro(_mapaFiltro.getMapaFiltro);
                  setState(() {
                    valor=value!;
                    dropdownActivado=false;
                  });
                },
                items: <String>["Todos","Venta","Alquiler","Anticrético"]
                .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                      //color: valor==value?Colors.red:Colors.blue,
                      child: Text(value,textAlign: TextAlign.center),
                    )
                    
                  );
                }).toList()
              ),
            ],
          ),
        
    );
  }
}
class FiltroTipoInmueble extends StatefulWidget {
  FiltroTipoInmueble({Key? key}) : super(key: key);

  @override
  _FiltroTipoInmuebleState createState() => _FiltroTipoInmuebleState();
}

class _FiltroTipoInmuebleState extends State<FiltroTipoInmueble> {
  List<String> items=[];
  String valor="Casa";
  bool dropdownActivado=false;
  @override
  Widget build(BuildContext context) {
    final _mapaFiltro=Provider.of<MapaFiltroGeneralesInfo>(context);
    return  Container(
      color: Colors.transparent,
      child: DropdownButton(
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
        value: valor,
        onChanged: (String? value){
          _mapaFiltro.setMapaFiltroItem("tipo_inmueble", value);
          setState(() {
            valor=value!;
            dropdownActivado=false;
          });
        },
        items: <String>["Todos","Terreno","Departamento","Casa"]
        .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Container(
              color: valor==value?Colors.red:Colors.blue,
              child: Text(value),
            )
            
          );
        }).toList()
      ),
    );
  }
}
class PMItemTipoInmueble extends StatefulWidget {
  PMItemTipoInmueble({Key? key}) : super(key: key);

  @override
  _PMItemTipoInmuebleState createState() => _PMItemTipoInmuebleState();
}

class _PMItemTipoInmuebleState extends State<PMItemTipoInmueble> {
  bool terrenoActivado=false;
  bool otrosActivado=false;
  double heightFiltro=45;
  double heightContainerInicial=225;
  double heightContainerFinal=225;
  @override
  Widget build(BuildContext context) {
    final mapaFiltroPrincipales=Provider.of<MapaFiltroPrincipalesInfo>(context);
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    heightContainerFinal=heightContainerInicial;
    if(terrenoActivado){
      heightContainerFinal=heightFiltro*2;
    }
    if(otrosActivado){
      heightContainerFinal=heightFiltro*8;
    }
    return Container(
      height:heightContainerFinal,
      padding: EdgeInsets.zero,
      child:Column(
        children: [
          (terrenoActivado||otrosActivado)?
          Container():
          Column(
            children: [
              _itemTipoInmueble(
                "Todos",
                (){
                  _inmueblesFiltrado.setFiltrar(true);
                  mapaFiltroPrincipales.setMapaFiltroItem("tipo_inmueble", "Todos");
                  Navigator.pop(context);
                }
              ),
              _itemTipoInmueble(
                "Casa",
                (){
                  _inmueblesFiltrado.setFiltrar(true);
                  mapaFiltroPrincipales.setMapaFiltroItem("tipo_inmueble", "Casa");
                  Navigator.pop(context);
                }
              ),
              _itemTipoInmueble(
                "Departamento",
                (){
                  _inmueblesFiltrado.setFiltrar(true);
                  mapaFiltroPrincipales.setMapaFiltroItem("tipo_inmueble", "Departamento");
                  Navigator.pop(context);
                }
              ),
              _itemTipoInmueble(
                "Terreno",
                (){
                  setState(() {
                    terrenoActivado=!terrenoActivado;
                  });
                }
              ),
              _itemTipoInmueble(
                "Otros",
                (){
                  setState(() {
                    otrosActivado=!otrosActivado;
                  });
                }
              ),
            ],
          ),
          if(terrenoActivado)
          Container(
            child:Row(
              children: [
                Expanded(
                  child: Container(
                    //padding:EdgeInsets.all(10),
                    child: Column(
                      children: [
                        _itemTipoInmueble(
                          "Otros",
                          (){
                            _inmueblesFiltrado.setFiltrar(true);
                            mapaFiltroPrincipales.setMapaFiltroItem("tipo_inmueble", "Terreno constructivo");
                            Navigator.pop(context);
                          }
                        ),
                        _itemTipoInmueble(
                          "Agrícola",
                          (){
                            _inmueblesFiltrado.setFiltrar(true);
                            mapaFiltroPrincipales.setMapaFiltroItem("tipo_inmueble", "Terreno agrícola");
                            Navigator.pop(context);
                          }
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ),
          if(otrosActivado)
          Container(
            child:Row(
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        _itemTipoInmueble(
                          "Habitaciones",
                          (){
                            _inmueblesFiltrado.setFiltrar(true);
                            mapaFiltroPrincipales.setMapaFiltroItem("tipo_inmueble", "Habitaciones");
                            Navigator.pop(context);
                          }
                        ),
                        _itemTipoInmueble(
                          "Condominio abierto",
                          (){
                            _inmueblesFiltrado.setFiltrar(true);
                            mapaFiltroPrincipales.setMapaFiltroItem("tipo_inmueble", "Condominio abierto");
                            Navigator.pop(context);
                          }
                        ),
                        _itemTipoInmueble(
                          "Condominio privado",
                          (){
                            _inmueblesFiltrado.setFiltrar(true);
                            mapaFiltroPrincipales.setMapaFiltroItem("tipo_inmueble", "Condominio privado");
                            Navigator.pop(context);
                          }
                        ),
                        _itemTipoInmueble(
                          "Local comercial",
                          (){
                            _inmueblesFiltrado.setFiltrar(true);
                            mapaFiltroPrincipales.setMapaFiltroItem("tipo_inmueble", "Local comercial");
                            Navigator.pop(context);
                          }
                        ),
                        _itemTipoInmueble(
                          "Local eventual",
                          (){
                            _inmueblesFiltrado.setFiltrar(true);
                            mapaFiltroPrincipales.setMapaFiltroItem("tipo_inmueble", "Local eventual");
                            Navigator.pop(context);
                          }
                        ),
                        _itemTipoInmueble(
                          "Oficinas",
                          (){
                            _inmueblesFiltrado.setFiltrar(true);
                            mapaFiltroPrincipales.setMapaFiltroItem("tipo_inmueble", "Oficinas");
                            Navigator.pop(context);
                          }
                        ),
                        _itemTipoInmueble(
                          "Garajes",
                          (){
                            _inmueblesFiltrado.setFiltrar(true);
                            mapaFiltroPrincipales.setMapaFiltroItem("tipo_inmueble", "Garajes");
                            Navigator.pop(context);
                          }
                        ),
                        _itemTipoInmueble(
                          "Galpones",
                          (){
                            _inmueblesFiltrado.setFiltrar(true);
                            mapaFiltroPrincipales.setMapaFiltroItem("tipo_inmueble", "Galpones");
                            Navigator.pop(context);
                          }
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ),
        ],
      )
    );
  }
  Widget _itemTipoInmueble(String texto,VoidCallback onTap){
    return InkWell(
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding:EdgeInsets.only(left: 10,right: 0,top: 0,bottom: 0),
              alignment: Alignment.centerLeft,
              width: 120,
              height: heightFiltro,
              child: Text(texto,
                style:TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal
                  )
              ),
            ),
          ),
        ],
      ),
      onTap: onTap
    );
  }
}
class FiltroCiudad extends StatefulWidget {
  FiltroCiudad({Key? key}) : super(key: key);

  @override
  _FiltroCiudadState createState() => _FiltroCiudadState();
}

class _FiltroCiudadState extends State<FiltroCiudad> {
  
  bool dropdownActivado=false;
  Ciudad ciudad=Ciudad.vacio();
  @override
  Widget build(BuildContext context) {
    final _mapaFiltro=Provider.of<MapaFiltroPrincipalesInfo>(context);
    final _datosGenerales=Provider.of<DatosGeneralesInfo>(context);
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    for(int i=0;i<_datosGenerales.ciudades.length;i++){
      
      if(_mapaFiltro.getMapaFiltro["ciudad"]==_datosGenerales.ciudades[i].nombreCiudad){
        ciudad=_datosGenerales.ciudades[i];
        break;
      }
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
          _mapaFiltro.getMapaFiltro["zona"]="Cualquiera";
          _mapaFiltro.setMapaFiltroItem("ciudad", value.nombreCiudad);
          _inmueblesFiltrado.setConsultarBD(true);
          setState(() {
            ciudad=value;
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
class FiltroZona extends StatefulWidget {
  FiltroZona({Key? key}) : super(key: key);

  @override
  _FiltroZonaState createState() => _FiltroZonaState();
}

class _FiltroZonaState extends State<FiltroZona> {
  
  bool dropdownActivado=false;
  Zona zona=Zona.vacio();
  @override
  Widget build(BuildContext context) {
    final _mapaFiltro=Provider.of<MapaFiltroPrincipalesInfo>(context);
    final _datosGenerales=Provider.of<DatosGeneralesInfo>(context);
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    for(int i=0;i<_datosGenerales.zonasCiudad.length;i++){
      
      if(_mapaFiltro.getMapaFiltro["zona"]==_datosGenerales.zonasCiudad[i].nombreZona){
        zona=_datosGenerales.zonasCiudad[i];
        break;
      }
    }
    return  Container(
      color: Colors.transparent,
      child: DropdownButton<Zona>(
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
        value: zona,
        onChanged: (Zona? value){
          _mapaFiltro.setMapaFiltroItem("zona", value!.nombreZona);
          _inmueblesFiltrado.setConsultarBD(false);
          _inmueblesFiltrado.setFiltrar(true);
          setState(() {
            zona=value;
            dropdownActivado=false;
          });
        },
        items:_datosGenerales.zonasCiudad
        .map<DropdownMenuItem<Zona>>((Zona value) {
          return DropdownMenuItem<Zona>(
            value: value,
            child: Container(
              child: Text(value.nombreZona),
            )
            
          );
        }).toList()
      ),
    );
  }
}
class FiltroPrecio extends StatefulWidget {
  FiltroPrecio({Key? key}) : super(key: key);

  @override
  _FiltroPrecioState createState() => _FiltroPrecioState();
}

class _FiltroPrecioState extends State<FiltroPrecio> {
  List<String> itemsVenta=["Cualquiera","0-99K","100K-149K","150K-199K","200K-250K","250K a más"];
  List<int> preciosVenta=[0,0,100,150,200,250];
  List<String> itemAlquiler=["Cualquiera","0-499","500-999","1000-1499","1500-1999","2000 a más"];
  List<int> preciosAlquiler=[0,0,500,1000,1500,2000];
  List<int> preciosAnticretico=[0,0,5,10,15,20];
  List<String> itemAnticretico=["Cualquiera","0-4999","5000-9999","10K-14.9K","15K-19.9K","20K a más"];
  List<String> items=[];
  List<int> precios=[];
  final color=Colors.white;
  final colorFill=Colors.white12;
  bool dropdownActivado=false;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    final _mapaFiltro=Provider.of<MapaFiltroGeneralesInfo>(context);
    final _mapaFiltroPrincipales=Provider.of<MapaFiltroPrincipalesInfo>(context);
    if(_mapaFiltroPrincipales.isCambio){
      if(_mapaFiltroPrincipales.getMapaFiltro["tipo_contrato"]=="Venta"||_mapaFiltroPrincipales.getMapaFiltro["tipo_contrato"]=="Todos"){
        items=[];
        precios=[];
        items.addAll(itemsVenta);
        precios.addAll(preciosVenta);
      }else if(_mapaFiltroPrincipales.getMapaFiltro["tipo_contrato"]=="Alquiler"){
        items=[];
        precios=[];
        items.addAll(itemAlquiler);
        precios.addAll(preciosAlquiler);
      }else{
        items=[];
        precios=[];
        items.addAll(itemAnticretico);
        precios.addAll(preciosAnticretico);
      }
      _mapaFiltroPrincipales.isCambio=false;
    }
    return Container(
      width: 120,
       child: Row(
         children: [
           Icon(Icons.monetization_on_outlined,size:20),
           Container(
             child: DropdownButton(
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
              value: _mapaFiltro.getMapaFiltro["precio_sel"].toString(),
              onChanged: (String? value){
                _inmueblesFiltrado.setFiltrar(true);
                int index=items.indexOf(value!);
                _mapaFiltro.getMapaFiltro["precio_sel"]=value;
                if(_mapaFiltroPrincipales.getMapaFiltro["tipo_contrato"]=="Venta"||_mapaFiltroPrincipales.getMapaFiltro["tipo_contrato"]=="Todos"){
                  index<precios.length-1?_mapaFiltro.setMapaFiltroItem2("precio_min", precios[index]*1000,"precio_max", (precios[index+1]-1)*1000)
                  :_mapaFiltro.setMapaFiltroItem2("precio_min", precios[index]*1000,"precio_max", precios[index]*1000);
                }else if(_mapaFiltroPrincipales.getMapaFiltro["tipo_contrato"]=="Alquiler"){
                  index<precios.length-1?_mapaFiltro.setMapaFiltroItem2("precio_min", precios[index],"precio_max", (precios[index+1]-1))
                  :_mapaFiltro.setMapaFiltroItem2("precio_min", precios[index],"precio_max", precios[index]);
                }else{
                  if(precios[index]>=10){
                    index<precios.length-1?_mapaFiltro.setMapaFiltroItem2("precio_min", precios[index]*1000,"precio_max", (precios[index+1]-1)*1000)
                  :_mapaFiltro.setMapaFiltroItem2("precio_min", precios[index],"precio_max", precios[index]);
                  }else{
                    index<precios.length-1?_mapaFiltro.setMapaFiltroItem2("precio_min", precios[index]*1000,"precio_max", (precios[index+1]-1)*1000)
                  :_mapaFiltro.setMapaFiltroItem2("precio_min", precios[index],"precio_max", precios[index]);
                  }
                }
                setState(() {
                  dropdownActivado=false;
                });
              },
              items: items
              .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Container(
                    child: Text(value,textAlign: TextAlign.end,),
                  )
                );
              }).toList()
            ),
           ),
         ],
       ) 
    );
  }
}