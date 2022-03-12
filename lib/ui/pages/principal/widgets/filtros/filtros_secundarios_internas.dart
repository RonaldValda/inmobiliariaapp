import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/filtros_widgets.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_internas_info.dart';
import 'package:provider/provider.dart';
class FiltrosSecundariosInternas extends StatefulWidget {
  FiltrosSecundariosInternas({Key? key}) : super(key: key);

  @override
  _FiltrosSecundariosInternasState createState() => _FiltrosSecundariosInternasState();
}

class _FiltrosSecundariosInternasState extends State<FiltrosSecundariosInternas> {
  int numeroDormitorios=1;
  int numeroBanios=1;
  int numeroGaraje=1;
  bool verMas=false;
  double widthContainerTexto=80;
  double heightContainerTexto=30;
  double heightContainerTexto2=35;
  double heightContainerTexto3=60;
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(
         children: [
           WidgetsSelectoresBotones(texto: "Plantas",clave: "plantas",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto,),
           WidgetsSelectoresBotones(texto: "Ambientes",clave: "ambientes",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto,),
           WidgetsSelectoresBotones(texto: "Dormitorios",clave: "dormitorios",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto,),
           WidgetsSelectoresBotones(texto: "Baños",clave: "banios",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto,),
           WidgetsSelectoresBotones(texto: "Garaje [Vehículos]",clave: "garaje",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto,),
           
           Container(
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(0),
              //color: Colors.redAccent,
              //alignment: Alignment.centerRight,
              //width:40,
              height: 30,
              child: TextButton(
                onPressed: (){
                  setState(() {
                  verMas=!verMas;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.arrow_drop_down,color:Colors.black,),
                    //Text("Ver más")
                  ],
                )
              ),
            ),
           verMas?FiltrosSecundariosInternasMas():Container(),
         ]
       ),
    );
  }
}
class FiltrosSecundariosInternasMas extends StatefulWidget {
  FiltrosSecundariosInternasMas({Key? key}) : super(key: key);

  @override
  _FiltrosSecundariosInternasMasState createState() => _FiltrosSecundariosInternasMasState();
}

class _FiltrosSecundariosInternasMasState extends State<FiltrosSecundariosInternasMas> {
  bool mascotasPermitidas=true;
  double widthContainerTexto=180;
  double heightContainerTexto=25;
  double heightContainerTexto2=35;
  double heightContainerTexto3=60;
  double heightContainerTexto4=100;
  @override
  Widget build(BuildContext context) {
    final mapaFiltroInternas=Provider.of<MapaFiltroInternasInfo>(context);
    return Container(
       child: Column(
         children: [
           WidgetsSelectoresSimplesMas(texto: "Amoblado",mapaFiltro: mapaFiltroInternas, clave: "amoblado",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimplesMas(texto: "Lavandería",mapaFiltro: mapaFiltroInternas, clave: "lavanderia",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimplesMas(texto: "Cuarto de lavado",mapaFiltro: mapaFiltroInternas, clave: "cuarto_lavado",
                                    heightContainerTexto: heightContainerTexto2,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimplesMas(texto: "Churrasquero",mapaFiltro: mapaFiltroInternas, clave: "churrasquero",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimplesMas(texto: "Azotea",mapaFiltro: mapaFiltroInternas, clave: "azotea",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimplesMas(texto: "[Club house]-> Condominio privado",mapaFiltro: mapaFiltroInternas, clave: "condominio_privado",
                                    heightContainerTexto: heightContainerTexto2,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimplesMas(texto: "Cancha de Fútbol, tenis, etc. en inmueble",mapaFiltro: mapaFiltroInternas, clave: "cancha",
                                    heightContainerTexto: heightContainerTexto2,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimplesMas(texto: "Piscina",mapaFiltro: mapaFiltroInternas, clave: "piscina",
                                    heightContainerTexto: heightContainerTexto2,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimplesMas(texto: "Sauna",mapaFiltro: mapaFiltroInternas, clave: "sauna",
                                    heightContainerTexto: heightContainerTexto2,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimplesMas(texto: "Jacuzzi",mapaFiltro: mapaFiltroInternas, clave: "jacuzzi",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),     
           WidgetsSelectoresSimplesMas(texto: "Estudio",mapaFiltro: mapaFiltroInternas, clave: "estudio",
                                    heightContainerTexto: heightContainerTexto2,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimplesMas(texto: "Jardín",mapaFiltro: mapaFiltroInternas, clave: "jardin",
                                    heightContainerTexto: heightContainerTexto2,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimplesMas(texto: "Portón eléctrico",mapaFiltro: mapaFiltroInternas, clave: "porton_electrico",
                                    heightContainerTexto: heightContainerTexto2,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimplesMas(texto: "Aire acondicionado",mapaFiltro: mapaFiltroInternas, clave: "aire_acondicionado",
                                    heightContainerTexto: heightContainerTexto2,
                                    widthContainerTexto: widthContainerTexto),               
           WidgetsSelectoresSimplesMas(texto: "Calefacción",mapaFiltro: mapaFiltroInternas, clave: "calefaccion",
                                    heightContainerTexto: heightContainerTexto2,
                                    widthContainerTexto: widthContainerTexto),    
          WidgetsSelectoresSimplesMas(texto: "Ascensor",mapaFiltro: mapaFiltroInternas, clave: "ascensor",
                                    heightContainerTexto: heightContainerTexto2,
                                    widthContainerTexto: widthContainerTexto),
          WidgetsSelectoresSimplesMas(texto: "Depósito",mapaFiltro: mapaFiltroInternas, clave: "deposito",
                                    heightContainerTexto: heightContainerTexto2,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimplesMas(texto: "Sótano",mapaFiltro: mapaFiltroInternas, clave: "sotano",
                                    heightContainerTexto: heightContainerTexto2,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimplesMas(texto: "Balcón",mapaFiltro: mapaFiltroInternas, clave: "balcon",
                                    heightContainerTexto: heightContainerTexto2,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimplesMas(texto: "Tienda",mapaFiltro: mapaFiltroInternas, clave: "tienda",
                                    heightContainerTexto: heightContainerTexto2,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimplesMas(texto: "[Amurallado]-> Terreno",mapaFiltro: mapaFiltroInternas, clave: "amurallado_terreno",
                                    heightContainerTexto: heightContainerTexto2,
                                    widthContainerTexto: widthContainerTexto),
           
           
         ],
       )
    );
  }
}