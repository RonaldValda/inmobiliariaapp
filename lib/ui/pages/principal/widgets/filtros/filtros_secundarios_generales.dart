import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/filtros/filtros_principales.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/filtros_widgets.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_generales_info.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class FiltrosSecundariosGenerales extends StatefulWidget {
  Map<String,dynamic> mapFiltro;
  FiltrosSecundariosGenerales({Key? key,required this.mapFiltro}) : super(key: key);

  @override
  _FiltrosSecundariosGeneralesState createState() => _FiltrosSecundariosGeneralesState();
}

class _FiltrosSecundariosGeneralesState extends State<FiltrosSecundariosGenerales> {
  bool docDia=false;
  bool aEstrenar=false;
  bool incluyeCredito=false;
  bool verMas=false;
  List<String> itemsSupTerreno=["Cualquiera","0-149","150-199","200-249","250-299","300 a más"];
  List<int> superficiesTerreno=[0,0,150,200,250,300];
  List<String> itemsSupConstruccion=["Cualquiera","0-99","100-199","200-299","300-399","400 a más"];
  List<int> superficiesConstruccion=[0,0,100,200,300,400];
  List<String> itemsTiempoConstruccion=["Cualquiera","0-9","10-19","20-29","30 a más"];
  List<int> tiemposConstruccion=[0,0,10,20,30];
  List<String> itemsMetrosFrente=["Cualquiera","0-4","5-9","10-14","15-19","20 a más"];
  List<int> metrosFrente=[0,0,5,10,15,20];
  bool dropdownActivado=false;
  Color colorActiveSwitch=Colors.indigo;
  Color colorTexto=Colors.black;
  double widthContainerTexto=180;
  double heightContainerTexto=25;
  double heightContainerTexto2=35;
  double heightContainerTexto3=50;
  
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final _mapaFiltroGenerales=Provider.of<MapaFiltroGeneralesInfo>(context);
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
       child: Column(
         children: [
           Row(
             mainAxisAlignment:MainAxisAlignment.spaceBetween,
             children: [
               Container(
                  padding: EdgeInsets.all(0),
                  margin: EdgeInsets.all(0),
                  alignment: Alignment.centerLeft,
                  height: heightContainerTexto2,
                  width: 160,
                  child: Text("Ciudad",style: TextStyle(fontSize: 13),),
                ),
                FiltroCiudad(),
             ],
           ),
           Row(
             mainAxisAlignment:MainAxisAlignment.spaceBetween,
             children: [
               Container(
                  padding: EdgeInsets.all(0),
                  margin: EdgeInsets.all(0),
                  alignment: Alignment.centerLeft,
                  height: heightContainerTexto2,
                  width: 160,
                  child: Text("Zona",style: TextStyle(fontSize: 13),),
                ),
                FiltroZona(),
             ],
           ),
           Container(
            padding: EdgeInsets.all(0),
            child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 160,
                    padding: EdgeInsets.all(0),
                    margin: EdgeInsets.all(0),
                    alignment: Alignment.centerLeft,
                    height: heightContainerTexto2,
                    //color:Colors.greenAccent[100],
                    child: Text("Superficie del terreno",style: TextStyle(fontSize: 13),),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        child: DropdownButton(
                          icon: Icon(Icons.arrow_drop_down,color: Colors.black,),
                          style: dropdownActivado?TextStyle(
                            color:  Colors.black,
                            
                          ):TextStyle(
                            color: Colors.black
                          ),
                          onTap: (){
                            setState(() {
                              dropdownActivado=true;
                            });
                          },
                          dropdownColor: Colors.white70,
                          value:  _mapaFiltroGenerales.getMapaFiltro["superficie_terreno_sel"].toString(),
                          onChanged: (String? value){
                            int index=itemsSupTerreno.indexOf(value!);
                            index<superficiesTerreno.length-1?_mapaFiltroGenerales.setMapaFiltroItem2("superficie_terreno_min", superficiesTerreno[index],"superficie_terreno_max", (superficiesTerreno[index+1]-1))
                            :_mapaFiltroGenerales.setMapaFiltroItem2("superficie_terreno_min", superficiesTerreno[index],"superficie_terreno_max", superficiesTerreno[index]);
                            setState(() {
                              _inmueblesFiltrado.setFiltrar(true);
                              _mapaFiltroGenerales.setMapaFiltroItem("superficie_terreno_sel", value);
                              dropdownActivado=false;
                            });
                          },
                          items: itemsSupTerreno
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
                  ),
                  
                ],
            ),
          ),
          _mapaFiltroGenerales.getMapaFiltroMas["proyecto_preventa"]?
           Container():
           Container(
             padding: EdgeInsets.all(0),
             height: heightContainerTexto3,
             child:Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 160,
                      padding: EdgeInsets.all(0),
                      margin: EdgeInsets.all(0),
                      alignment: Alignment.centerLeft,
                      height: heightContainerTexto2,
                      //color:Colors.greenAccent[100],
                      child: Text("Superficie de construcción",style: TextStyle(fontSize: 13),),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          child: DropdownButton(
                            icon: Icon(Icons.arrow_drop_down,color: Colors.black,),
                            style: dropdownActivado?TextStyle(
                              color:  Colors.black,
                              
                            ):TextStyle(
                              color: Colors.black
                            ),
                            
                            onTap: (){
                              setState(() {
                                dropdownActivado=true;
                              });
                            },
                            dropdownColor: Colors.white70,
                            value: _mapaFiltroGenerales.getMapaFiltro["superficie_construccion_sel"].toString(),
                            onChanged: (String? value){
                              int index=itemsSupConstruccion.indexOf(value!);
                              index<superficiesConstruccion.length-1?_mapaFiltroGenerales.setMapaFiltroItem2("superficie_construccion_min", superficiesConstruccion[index],"superficie_construccion_max", (superficiesConstruccion[index+1]-1))
                              :_mapaFiltroGenerales.setMapaFiltroItem2("superficie_construccion_min", superficiesConstruccion[index],"superficie_construccion_max", superficiesConstruccion[index]);
                              setState(() {
                                _inmueblesFiltrado.setFiltrar(true);
                                _mapaFiltroGenerales.setMapaFiltroItem("superficie_construccion_sel", value);
                                //valor_sup_construccion=value;
                                dropdownActivado=false;
                              });
                            },
                            items: itemsSupConstruccion
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
                    ),
                  
                ],
             ),
           ),
           Row(
             mainAxisAlignment:MainAxisAlignment.spaceBetween,
             children: [
               Container(
                  padding: EdgeInsets.all(0),
                  margin: EdgeInsets.all(0),
                  alignment: Alignment.centerLeft,
                  height: heightContainerTexto2,
                  width: 160,
                  child: Text("Metros de frente",style: TextStyle(fontSize: 13),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      child: DropdownButton(
                        icon: Icon(Icons.arrow_drop_down,color: Colors.black,),
                        style: dropdownActivado?TextStyle(
                          color:  Colors.black,
                          
                        ):TextStyle(
                          color: Colors.black
                        ),
                        
                        onTap: (){
                          setState(() {
                            print("");
                            dropdownActivado=true;
                          });
                        },
                        dropdownColor: Colors.white70,
                        value: _mapaFiltroGenerales.getMapaFiltro["tamanio_frente_sel"].toString(),
                        onChanged: (String? value){
                          int index=itemsMetrosFrente.indexOf(value!);
                          index<metrosFrente.length-1?_mapaFiltroGenerales.setMapaFiltroItem2("tamanio_frente_min", metrosFrente[index],"tamanio_frente_max", (metrosFrente[index+1]-1))
                          :_mapaFiltroGenerales.setMapaFiltroItem2("tamanio_frente_min", metrosFrente[index],"tamanio_frente_max", metrosFrente[index]);
                          setState(() {
                            _inmueblesFiltrado.setFiltrar(true);
                            _mapaFiltroGenerales.setMapaFiltroItem("tamanio_frente_sel", value);
                            dropdownActivado=false;
                          });
                        },
                        items: itemsMetrosFrente
                        .map<DropdownMenuItem<String>>((String value) {
                          print(value);
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
                ),
             ],
           ),
           Row(
             mainAxisAlignment:MainAxisAlignment.spaceBetween,
             children: [
               Container(
                  padding: EdgeInsets.all(0),
                  margin: EdgeInsets.all(0),
                  alignment: Alignment.centerLeft,
                  height: heightContainerTexto2,
                  width: 160,
                  child: Text("Antigüedad de construcción",style: TextStyle(fontSize: 13),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      child: DropdownButton(
                        icon: Icon(Icons.arrow_drop_down,color: Colors.black,),
                        style: dropdownActivado?TextStyle(
                          color:  Colors.black,
                          
                        ):TextStyle(
                          color: Colors.black
                        ),
                        onTap: (){
                          setState(() {
                            print("");
                            dropdownActivado=true;
                          });
                        },
                        dropdownColor: Colors.white70,
                        value: _mapaFiltroGenerales.getMapaFiltro["antiguedad_construccion_sel"].toString(),
                        onChanged: (String? value){
                          int index=itemsTiempoConstruccion.indexOf(value!);
                          index<tiemposConstruccion.length-1?_mapaFiltroGenerales.setMapaFiltroItem2("antiguedad_construccion_min", tiemposConstruccion[index],"antiguedad_construccion_max", (tiemposConstruccion[index+1]-1))
                          :_mapaFiltroGenerales.setMapaFiltroItem2("antiguedad_construccion_min", tiemposConstruccion[index],"antiguedad_construccion_max", tiemposConstruccion[index]);
                          setState(() {
                            _inmueblesFiltrado.setFiltrar(true);
                            _mapaFiltroGenerales.setMapaFiltroItem("antiguedad_construccion_sel", value);
                            dropdownActivado=false;
                          });
                        },
                        items: itemsTiempoConstruccion
                        .map<DropdownMenuItem<String>>((String value) {
                          print(value);
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
                ),
             ],
           ),
           Container(
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.all(0),
            height: 20,
            child: TextButton(
              onPressed: (){
                setState(() {
                verMas=!verMas;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  !verMas?Icon(Icons.arrow_drop_down,color:Colors.black,):Icon(Icons.arrow_drop_up,color:Colors.black,),
                  //Text("Ver más")
                ],
              )
            ),
          ),
           verMas?FiltrosSecundariosGeneralesMas():Container()
        ],
       ),
    );
  }
  Widget selectoresSimples({required String texto,required MapaFiltroGeneralesInfo mapaFiltroGenerales,required String clave,required double heightContainerTexto}){
    return Container(
      height: heightContainerTexto,
      child:Row(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: heightContainerTexto,
            width: widthContainerTexto,
            child: Text(texto,style: TextStyle(fontSize: 13),),
          ),
          Container(
            child: Switch(
              value: mapaFiltroGenerales.getMapaFiltro[clave],
              onChanged: (bool value){
                mapaFiltroGenerales.setMapaFiltroItem(clave, value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
class FiltrosSecundariosGeneralesMas extends StatefulWidget {

  FiltrosSecundariosGeneralesMas({Key? key}) : super(key: key);

  @override
  _FiltrosSecundariosGeneralesMasState createState() => _FiltrosSecundariosGeneralesMasState();
}

class _FiltrosSecundariosGeneralesMasState extends State<FiltrosSecundariosGeneralesMas> {
  bool sinConstruir=false;
  bool inmuebleCompartido=false;
  bool sinHipoteca=true;
  
  bool dropdownActivado=false;
  Color colorActiveSwitch=Colors.indigo;
  Color colorTexto=Colors.black;
  double widthContainerTexto=200;
  double heightContainerTexto=25;
  double heightContainerTexto2=35;
  double heightContainerTexto3=60;
  double heightContainerTexto4=100;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final _mapaFiltroGenerales=Provider.of<MapaFiltroGeneralesInfo>(context);
    return Container(
       child: Column(
         children: [
           WidgetsSelectoresSimplesMas(texto: "Mascotas permitidas",mapaFiltro: _mapaFiltroGenerales, clave: "mascotas_permitidas",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimplesMas(texto: "Sin hipoteca",mapaFiltro: _mapaFiltroGenerales, clave: "sin_hipoteca",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimplesMas(texto: "Construcciones a estrenar",mapaFiltro: _mapaFiltroGenerales, clave: "construccion_estrenar",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
            WidgetsSelectoresSimplesMas(texto: "Materiales de primera",mapaFiltro: _mapaFiltroGenerales, clave: "materiales_primera",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
           
           
           
           WidgetsSelectoresSimplesMas(texto: "Proyecto preventa",mapaFiltro: _mapaFiltroGenerales,clave: "proyecto_preventa",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimplesMas(texto: "Inmueble compartido",mapaFiltro: _mapaFiltroGenerales, clave: "inmueble_compartido",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
           !_mapaFiltroGenerales.getMapaFiltroMas["inmueble_compartido"]?
           Container():
           Container(
             padding: EdgeInsets.all(0),
             height: 30,
             child:Column(
                children: [
                  WidgetsSelectoresBotonesMas(texto: "Numero Duenios",clave: "numero_duenios",
                                    heightContainerTexto: 30,
                                    widthContainerTexto: 80,),
                  
                ],
             ),
           ),
           WidgetsSelectoresSimplesMas(texto: "Servicios básicos (agua, luz, etc.)",mapaFiltro: _mapaFiltroGenerales, clave: "servicios_basicos",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimplesMas(texto: "Gas domiciliario",mapaFiltro: _mapaFiltroGenerales, clave: "gas_domiciliario",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimplesMas(texto: "Wi-Fi",mapaFiltro: _mapaFiltroGenerales, clave: "wifi",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimplesMas(texto: "Medidor independiente",mapaFiltro: _mapaFiltroGenerales, clave: "medidor_independiente",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),                                                  
           WidgetsSelectoresSimplesMas(texto: "Termotanques",mapaFiltro: _mapaFiltroGenerales, clave: "termotanque",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
            WidgetsSelectoresSimplesMas(texto: "Calle asfaltada",mapaFiltro: _mapaFiltroGenerales, clave: "calle_asfaltada",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
            WidgetsSelectoresSimplesMas(texto: "Transporte (0 - 100m)",mapaFiltro: _mapaFiltroGenerales, clave: "transporte",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
            WidgetsSelectoresSimplesMas(texto: "Preparado para discapacidad",mapaFiltro: _mapaFiltroGenerales, clave: "preparado_discapacidad",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
            WidgetsSelectoresSimplesMas(texto: "Papeles en orden",mapaFiltro: _mapaFiltroGenerales, clave: "papeles_orden",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),                                                
            WidgetsSelectoresSimplesMas(texto: "Habilitado para crédito de vivienda social",mapaFiltro: _mapaFiltroGenerales, clave: "habilitado_credito",
                                    heightContainerTexto: heightContainerTexto2,
                                    widthContainerTexto: widthContainerTexto),
           
         ],
       ),
    );
  }
}