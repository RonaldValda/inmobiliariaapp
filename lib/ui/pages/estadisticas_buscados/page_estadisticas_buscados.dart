import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:inmobiliariaapp/domain/usecases/usuario/usecase_super_usuario.dart';
class PageEstadisticasBuscados extends StatefulWidget {
  PageEstadisticasBuscados({Key? key,required this.ciudad}) : super(key: key);
  final String ciudad;
  @override
  _PageEstadisticasBuscadosState createState() => _PageEstadisticasBuscadosState();
}

class _PageEstadisticasBuscadosState extends State<PageEstadisticasBuscados> {
  Map<String,dynamic> mapSuperficiesTerrero={};
  Map<String,dynamic> mapSuperficiesConstruccion={};
  Map<String,dynamic> mapMetrosFrente={};
  Map<String,dynamic> mapAntiguedadConstruccion={};
  Map<String,dynamic> mapMascotasPermitidas={};
  Map<String,dynamic> mapSinHipoteca={};
  Map<String,dynamic> mapContruccionEstrenar={};
  Map<String,dynamic> mapMaterialesPrimera={};
  Map<String,dynamic> mapProyectoPreventa={};
  Map<String,dynamic> mapInmuebleCompartido={};
  Map<String,dynamic> mapNumeroDuenios={};
  Map<String,dynamic> mapServiciosBasicos={};
  Map<String,dynamic> mapGasDomiciliario={};
  Map<String,dynamic> mapWifi={};
  Map<String,dynamic> mapMedidorIndependiente={};
  Map<String,dynamic> mapTermotanque={};
  Map<String,dynamic> mapCalleAsfaltada={};
  Map<String,dynamic> mapTransporte={};
  Map<String,dynamic> mapPreparadoDiscapacidad={};
  Map<String,dynamic> mapPapelesOrden={};
  Map<String,dynamic> mapHabilitadoCredito={};
  Map<String,dynamic> mapPlantas={};
  Map<String,dynamic> mapAmbientes={};
  Map<String,dynamic> mapDormitorios={};
  Map<String,dynamic> mapBanios={};
  Map<String,dynamic> mapGaraje={};
  Map<String,dynamic> mapAmoblado={};
  Map<String,dynamic> mapLavanderia={};
  Map<String,dynamic> mapCuartoLavado={};
  Map<String,dynamic> mapChurrasquero={};
  Map<String,dynamic> mapAzotea={};
  Map<String,dynamic> mapCondominioPrivado={};
  Map<String,dynamic> mapCancha={};
  Map<String,dynamic> mapPiscina={};
  Map<String,dynamic> mapSauna={};
  Map<String,dynamic> mapJacuzzi={};
  Map<String,dynamic> mapEstudio={};
  Map<String,dynamic> mapJardin={};
  Map<String,dynamic> mapPortonElectrico={};
  Map<String,dynamic> mapAireAcondicionado={};
  Map<String,dynamic> mapCalefaccion={};
  Map<String,dynamic> mapAscensor={};
  Map<String,dynamic> mapDeposito={};
  Map<String,dynamic> mapSotano={};
  Map<String,dynamic> mapBalcon={};
  Map<String,dynamic> mapTienda={};
  Map<String,dynamic> mapAmuralladoTerreno={};
  Map<String,dynamic> mapIglesia={};
  Map<String,dynamic> mapParqueInfantil={};
  Map<String,dynamic> mapEscuela={};
  Map<String,dynamic> mapUniversidad={};
  Map<String,dynamic> mapPlazuela={};
  Map<String,dynamic> mapModuloPolicial={};
  Map<String,dynamic> mapSaunaPiscinaPublica={};
  Map<String,dynamic> mapGymPublico={};
  Map<String,dynamic> mapCentroDeportivo={};
  Map<String,dynamic> mapPuestoSalud={};
  Map<String,dynamic> mapZonaComercial={};


  List<String> titulosI=["Superficie de terreno","Superficie de construcción","Metros de frente","Antigüedad de construcción",
                      "Mascotas permitidas","Sin hipoteca","Construcciones a estrenar","Materiales de primera",
                      "Proyectos en preventa","Inmueble compartido","Numero de dueños","Servicios básicos","Gas domiciliario",
                      "Wi-Fi","Medidor independiente","Termotanques","Calle asfaltada","Transporte (0-100m)",
                      "Preparado para discapacidad","Papeles en orden","Habilitado para crédito de viviendo social",
                      "Plantas","Ambientes","Dormitorios","Baños","Garaje [Vehículos]","Amoblado","Lavanderia","Cuarto de lavado",
                      "Churrasquero","Azotea","[Club house]-> Condominio privado","Cancha de fútbol, tenis, etc. en inmueble",
                      "Piscina","Sauna","Jacuzzi","Estudio","Jardín","Portón eléctrico","Aire acondicionado","Calefacción",
                      "Ascensor","Depósito","Sótano","Balcón","Tienda","[Amurallado-> Terreno]",
                      "Iglesia","Parque infantil","Escuela","Universidad","Plazuela","Módulo policial",
                      "Sauna / piscina pública","Gym público","Centro deportivo","Puesto salud","Zona comercial"
                      ];
  List<String> titulosD=[];
  double cantidadDatos=0;
  List<Map<String,dynamic>> mapsI=[];
  List<Map<String,dynamic>> mapsD=[];
   List<Color> colores=[Colors.indigo,Colors.red,Colors.orange,Colors.green,Colors.brown,Colors.blue];
   UseCaseSuperUsuario useCaseSuperUsuario=UseCaseSuperUsuario();
  @override
  void initState() {
    super.initState();
    useCaseSuperUsuario.obtenerUsuariosInmueblesBuscadosCiudad(widget.ciudad).then((value) {
      if(value["completed"]){
        mapSuperficiesTerrero=value["map_superficies_terreno"];
        mapSuperficiesConstruccion=value["map_superficies_construccion"];
        mapMetrosFrente=value["map_metros_frente"];
        mapAntiguedadConstruccion=value["map_antiguedad_construccion"];
        mapMascotasPermitidas=value["map_mascotas_permitidas"];
        mapSinHipoteca=value["map_sin_hipoteca"];
        mapContruccionEstrenar=value["map_construccion_estrenar"];
        mapMaterialesPrimera=value["map_materiales_primera"];
        mapProyectoPreventa=value["map_proyecto_preventa"];
        mapInmuebleCompartido=value["map_inmueble_compartido"];
        mapNumeroDuenios=value["map_numero_duenios"];
        mapServiciosBasicos=value["map_servicios_basicos"];
        mapGasDomiciliario=value["map_gas_domiciliario"];
        mapWifi=value["map_wifi"];
        mapMedidorIndependiente=value["map_medidor_independiente"];
        mapTermotanque=value["map_termotanque"];
        mapCalleAsfaltada=value["map_calle_asfaltada"];
        mapTransporte=value["map_transporte"];
        mapPreparadoDiscapacidad=value["map_preparado_discapacidad"];
        mapPapelesOrden=value["map_papeles_orden"];
        mapHabilitadoCredito=value["map_habilitado_credito"];
        mapPlantas=value["map_plantas"];
        mapAmbientes=value["map_ambientes"];
        mapDormitorios=value["map_dormitorios"];
        mapBanios=value["map_banios"];
        mapGaraje=value["map_garaje"];
        mapAmoblado=value["map_amoblado"];
        mapLavanderia=value["map_lavanderia"];
        mapCuartoLavado=value["map_cuarto_lavado"];
        mapChurrasquero=value["map_churrasquero"];
        mapAzotea=value["map_azotea"];
        mapCondominioPrivado=value["map_condominio_privado"];
        mapCancha=value["map_cancha"];
        mapPiscina=value["map_piscina"];
        mapSauna=value["map_sauna"];
        mapJacuzzi=value["map_jacuzzi"];
        mapEstudio=value["map_estudio"];
        mapJardin=value["map_jardin"];
        mapPortonElectrico=value["map_porton_electrico"];
        mapAireAcondicionado=value["map_aire_acondicionado"];
        mapCalefaccion=value["map_calefaccion"];
        mapAscensor=value["map_ascensor"];
        mapDeposito=value["map_deposito"];
        mapSotano=value["map_sotano"];
        mapBalcon=value["map_balcon"];
        mapTienda=value["map_tienda"];
        mapAmuralladoTerreno=value["map_amurallado_terreno"];
        mapIglesia=value["map_iglesia"];
        mapParqueInfantil=value["map_parque_infantil"];
        mapEscuela=value["map_escuela"];
        mapUniversidad=value["map_universidad"];
        mapPlazuela=value["map_plazuela"];
        mapModuloPolicial=value["map_modulo_policial"];
        mapSaunaPiscinaPublica=value["map_sauna_piscina_publica"];
        mapGymPublico=value["map_gym_publico"];
        mapCentroDeportivo=value["map_centro_deportivo"];
        mapPuestoSalud=value["map_puesto_salud"];
        mapZonaComercial=value["map_zona_comercial"];
        mapsI.addAll([mapSuperficiesTerrero,mapSuperficiesConstruccion,mapMetrosFrente,mapAntiguedadConstruccion,
                    mapMascotasPermitidas,mapSinHipoteca,mapContruccionEstrenar,mapMaterialesPrimera,
                    mapProyectoPreventa,mapInmuebleCompartido,mapNumeroDuenios,mapServiciosBasicos,
                    mapGasDomiciliario,mapWifi,mapMedidorIndependiente,mapTermotanque,mapCalleAsfaltada,
                    mapTransporte,mapPreparadoDiscapacidad,mapPapelesOrden,mapHabilitadoCredito,
                    mapPlantas,mapAmbientes,mapDormitorios,mapBanios,mapGaraje,mapAmoblado,mapLavanderia,
                    mapCuartoLavado,mapChurrasquero,mapAzotea,mapCondominioPrivado,mapCancha,mapPiscina,
                    mapSauna,mapJacuzzi,mapEstudio,mapJardin,mapPortonElectrico,mapAireAcondicionado,
                    mapCalefaccion,mapAscensor,mapDeposito,mapSotano,mapBalcon,mapTienda,mapAmuralladoTerreno,
                    mapIglesia,mapParqueInfantil,mapEscuela,mapUniversidad,mapPlazuela,mapModuloPolicial,mapSaunaPiscinaPublica,
                    mapGymPublico,mapCentroDeportivo,mapPuestoSalud,mapZonaComercial
                    ]);
        for(int i=1;i<mapsI.length;i=i+2){
          Map<String,dynamic> mapAux={};
          mapsI[i].forEach((key, value) { 
            mapAux[key]=value;
          });
          mapsD.add(mapAux);
          mapsI[i]={};
          titulosD.add(titulosI[i]);
          titulosI[i]="";
        }
        mapsI.removeWhere((element) => element.length==0);
        titulosI.removeWhere((element) => element=="");
        cantidadDatos=value["cantidad_datos"];
        setState(() {
          
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Estadísticas inmuebles buscados"),
      ),
      body: Container(
        child: Card(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: mapsI.length,
                  itemBuilder: (context, index) {
                    Map<String,dynamic> mapI=mapsI[index];
                    Map<String,dynamic> mapD={};
                    if(mapsD.length>index){
                      mapD=mapsD[index];
                    }
                    return Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          mapI.length<3?Card(
                            elevation: 10,
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width/2.2,
                                  height: MediaQuery.of(context).size.width/1.5,
                                  child: Column(
                                    children: [
                                      Text(titulosI[index],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15
                                        ),
                                      ),
                                      Expanded(
                                        child: PieChart(
                                          PieChartData(
                                            borderData: FlBorderData(show: false),
                                            sectionsSpace: 0,
                                            centerSpaceRadius: MediaQuery.of(context).size.width/15,
                                            sections: getSecctions1(mapI,cantidadDatos,colores)
                                          )
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          IndicatorPieChart(map: mapI,colores: colores,)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ):Card(
                            elevation: 10,
                            child: Column(
                              children: [
                                Text(titulosI[index],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width/2.2,
                                  height: MediaQuery.of(context).size.width/1.5,
                                  child: BarChartWidget(map: mapI, colores: colores)
                                ),
                              ],
                            )
                          ),
                          if(mapsD.length>index)
                          mapD.length<3?Card(
                            elevation: 10,
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width/2.2,
                                  height: MediaQuery.of(context).size.width/1.5,
                                  child: Column(
                                    children: [
                                      Text(titulosD[index],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15
                                        ),
                                      ),
                                      Expanded(
                                        child: PieChart(
                                          PieChartData(
                                            borderData: FlBorderData(show: false),
                                            sectionsSpace: 0,
                                            centerSpaceRadius: MediaQuery.of(context).size.width/15,
                                            sections: getSecctions1(mapD,cantidadDatos,colores)
                                          )
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          IndicatorPieChart(map: mapD,colores: colores,)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                
                              ],
                            ),
                          ):Card(
                            elevation: 10,
                            child: Column(
                              children: [
                                Text(titulosD[index],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width/2.2,
                                  height: MediaQuery.of(context).size.width/1.5,
                                  child: BarChartWidget(map: mapD, colores: colores)
                                ),
                              ],
                            )
                          )
                        ],
                      ),
                    );
                  },
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class IndicatorPieChart extends StatelessWidget {
  const IndicatorPieChart({Key? key,required this.map,required this.colores}) : super(key: key);
  final Map<String,dynamic> map;
  final List<Color> colores;
  @override
  Widget build(BuildContext context) {
    final List<String> datos=[];
    final List<int> numeros=[];
    int i=-1;
    map.forEach((key, value) { 
      datos.add(key);
      numeros.add(value);
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: datos.map((e) {
        i++;
        return indicador(color: colores[i], texto: "$e -> ${numeros[i]}");
      }).toList()
    );
  }
  Widget indicador({
    required Color color,
    required String texto,
    bool isSquare=false,
    double size=12,
    Color colorTexto=const Color(0xff505050)
  }){
    return Row(
      children: [
        Container(
          width: size,
          height: size,
          decoration:BoxDecoration(
            shape: isSquare?BoxShape.rectangle:BoxShape.circle,
            color: color
          )
        ),
        SizedBox(width: 8,),
        Text(
          texto,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: colorTexto
          ),
        )
      ],
    );
  }
}
List<PieChartSectionData> getSecctions1(Map<String,dynamic> map,double total,List<Color> colores) {
 
  int index=0;
  List<PieChartSectionData> data=[];
  map.forEach((key, value) { 
    final pie=PieChartSectionData(
      color: colores[index],
      value: value/total,
      title: '${(value/total)*100}%',
      radius: 50,
      titleStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white
      )
    );
    data.add(
      pie
    );
    index++;
  });
  return data;
}
List<PieChartSectionData> getSections(){
  return PieData.data.asMap()
      .map<int,PieChartSectionData>((index, data) {
        final value=PieChartSectionData(
          color: data.color,
          value: data.percent,
          title: '${data.percent}%',
          
          titleStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white
          )
        );
        return MapEntry(index, value);
      })
      .values
      .toList();
}
class PieData{
   static List<Data> data=[
    Data(nombre: "Rojo", percent: 40, color: Colors.red),
    Data(nombre: "Azul",percent: 20,color: Colors.blue),
    Data(nombre: "Amarillo", percent: 5, color: Colors.orangeAccent),
    Data(nombre: "Verde", percent: 25, color: Colors.green)
  ];
}
class Data{
  final String nombre;
  final double percent;
  final Color color;
  Data({required this.nombre,required this.percent,required this.color});
}
class BarChartWidget extends StatefulWidget {
  BarChartWidget({Key? key,required this.map,required this.colores}) : super(key: key);
  final Map<String,dynamic> map;
  final List<Color> colores;
  @override
  _BarChartWidgetState createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  final double barWidth=22;
  final List<String> datos=[];
  final List<int> numeros=[];
  final List<int> numerosAux=[];
  int i=-1;
  @override
  void initState() {
    super.initState();
    widget.map.forEach((key, value) { 
      datos.add(key);
      numeros.add(value);
    });
    numerosAux.addAll(numeros);
    numerosAux.sort((b,a)=>a.compareTo(b));
  }
    
  @override
  Widget build(BuildContext context) {
    i=-1;
    return Column(
      children: [
        SizedBox(height: 50,),
        Expanded(
          child: BarChart(
            BarChartData(
              borderData: FlBorderData(border: Border(bottom: BorderSide(width: 1,color: Colors.grey)),show: true),
              alignment: BarChartAlignment.center,
              maxY: numerosAux[0].toDouble(),
              minY: 0,
              groupsSpace: 2,
              barTouchData: BarTouchData(enabled: false),
            
              titlesData: FlTitlesData(
                topTitles: BarTitles.getTopBottomTitles(context, datos,true),
                bottomTitles: BarTitles.getTopBottomTitles(context, datos,false),
                leftTitles: BarTitles.getSlideTitles(context, datos),
                rightTitles: BarTitles.getSlideTitles(context, datos)
              ),
              barGroups: numeros.map((e){
                i++;
                return BarChartGroupData(
                  x: i,
                  //showingTooltipIndicators: numeros,
                  barRods:[
                    BarChartRodData(
        
                      y: e.toDouble(),
                      width: barWidth,
                      colors: [widget.colores[i]],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6)
                      )
                    )
                  ]
                );
              }).toList(),
            )
          ),
        ),
      ],
    );
  }
}
class BarTitles{
  static SideTitles getTopBottomTitles(BuildContext context,List<String> datos,bool top)=>SideTitles(
    showTitles: true,
    getTextStyles: (context,value)=> TextStyle(
      color: top?Colors.blue:Colors.transparent,fontSize: 10
    ),
    rotateAngle: -90,
    getTitles:(double id)=>datos[id.toInt()]
  );
  static SideTitles getSlideTitles(BuildContext context,List<String> datos)=>SideTitles(
    showTitles: true,
    getTextStyles: (context,value)=>const TextStyle(
      color: Colors.blue,fontSize: 10,
    ),
    interval: 2,
    getTitles:(double id)=>id.toDouble().toString()
  );
}
