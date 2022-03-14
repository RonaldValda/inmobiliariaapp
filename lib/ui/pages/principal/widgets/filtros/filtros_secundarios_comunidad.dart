import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/filtros_widgets.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_comunidad_info.dart';
import 'package:provider/provider.dart';
class FiltrosSecundariosComunidad extends StatefulWidget {
  FiltrosSecundariosComunidad({Key? key}) : super(key: key);

  @override
  _FiltrosSecundariosComunidadState createState() => _FiltrosSecundariosComunidadState();
}

class _FiltrosSecundariosComunidadState extends State<FiltrosSecundariosComunidad> {
  
  bool verMas=false;
  double widthContainerTexto=180;
  double heightContainerTexto=25;
  double heightContainerTexto2=35;
  double heightContainerTexto3=60;
  double heightContainerTexto4=100;
  @override
  Widget build(BuildContext context) {
    final mapaFiltroComunidad=Provider.of<MapaFiltroComunidadInfo>(context);
    return Container(
       child: Column(
         children: [
           WidgetsSelectoresSimples(texto: "Iglesia",mapaFiltro: mapaFiltroComunidad, clave: "iglesia",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimples(texto: "Parque infantil",mapaFiltro: mapaFiltroComunidad, clave: "parque_infantil",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimples(texto: "Escuela",mapaFiltro: mapaFiltroComunidad, clave: "escuela",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),                         
           WidgetsSelectoresSimples(texto: "Universidad",mapaFiltro: mapaFiltroComunidad, clave: "universidad",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimples(texto: "Plazuela",mapaFiltro: mapaFiltroComunidad, clave: "plazuela",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),                         
           Container(
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(0),
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
                  ],
                )
              ),
            ),
           verMas?FiltrosSecundariosComunidadMas():Container()
         ],
       ),
    );
  }
}
class FiltrosSecundariosComunidadMas extends StatefulWidget {
  FiltrosSecundariosComunidadMas({Key? key}) : super(key: key);

  @override
  _FiltrosSecundariosComunidadMasState createState() => _FiltrosSecundariosComunidadMasState();
}

class _FiltrosSecundariosComunidadMasState extends State<FiltrosSecundariosComunidadMas> {
  bool deportiva=false;
  bool policial=false;
  bool residencial=false;
  bool estudiantil=false;
  bool comercial=false;
  bool kinder=false;
  double widthContainerTexto=180;
  double heightContainerTexto=25;
  double heightContainerTexto2=35;
  double heightContainerTexto3=60;
  double heightContainerTexto4=100;
  @override
  Widget build(BuildContext context) {
    final mapaFiltroComunidad=Provider.of<MapaFiltroComunidadInfo>(context);
    return Container(
       child: Column(
         children: [
           WidgetsSelectoresSimplesMas(texto: "Módulo policial",mapaFiltro: mapaFiltroComunidad, clave: "modulo_policial",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimplesMas(texto: "Sauna / piscina pública",mapaFiltro: mapaFiltroComunidad, clave: "sauna_piscina_publica",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimplesMas(texto: "Gym público",mapaFiltro: mapaFiltroComunidad, clave: "gym_publico",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimplesMas(texto: "Centro deportivo",mapaFiltro: mapaFiltroComunidad, clave: "centro_deportivo",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimplesMas(texto: "Puesto de salud",mapaFiltro: mapaFiltroComunidad, clave: "puesto_salud",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
           WidgetsSelectoresSimplesMas(texto: "Zona comercial",mapaFiltro: mapaFiltroComunidad, clave: "zona_comercial",
                                    heightContainerTexto: heightContainerTexto,
                                    widthContainerTexto: widthContainerTexto),
         ],
       ),
    );
  }
}