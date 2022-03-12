
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' as iconc;
import 'package:inmobiliariaapp/domain/entities/usuarios_inmuebles_favoritos.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/usuarios_info.dart';
import 'package:provider/provider.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class FiltrosInmueblesBuscados extends StatefulWidget {
  FiltrosInmueblesBuscados({Key? key}) : super(key: key);

  @override
  _FiltrosInmueblesBuscadosState createState() => _FiltrosInmueblesBuscadosState();
}

class _FiltrosInmueblesBuscadosState extends State<FiltrosInmueblesBuscados> {
  List<bool> activadores=[];
  double height=0;
  List<Widget> children=[];
  @override
  Widget build(BuildContext context) {
    final _usuario=Provider.of<UsuariosInfo>(context);
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context); 
    height=_usuario.usuarioInmueblesBuscados.length*60;
    if(_inmueblesFiltrado.filtroBuscadoSeleccionado>=0){
      children=[];
      
      children=generarTextoGenerales(_usuario.usuarioInmueblesBuscados[_inmueblesFiltrado.filtroBuscadoSeleccionado]);
      children.addAll(generarTextoInternas(_usuario.usuarioInmueblesBuscados[_inmueblesFiltrado.filtroBuscadoSeleccionado]));
      children.addAll(generarTextoComunidad(_usuario.usuarioInmueblesBuscados[_inmueblesFiltrado.filtroBuscadoSeleccionado]));
      children.addAll(generarTextoOtros(_usuario.usuarioInmueblesBuscados[_inmueblesFiltrado.filtroBuscadoSeleccionado]));
      height+=children.length*16;
      if(MediaQuery.of(context).size.height/2<height){
        height=MediaQuery.of(context).size.height/2;
      }
    }
    return Container(
      //color: Colors.amber,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      width: double.maxFinite,
      height: height,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _usuario.usuarioInmueblesBuscados.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text("${_usuario.usuarioInmueblesBuscados[index].nombreConfiguracion}",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight:FontWeight.w500
                        ),
                      ),
                      trailing: Container(
                        width: 100,
                        height: 50,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: (){}, 
                              icon: iconc.FaIcon(iconc.FontAwesomeIcons.whatsapp)
                            ),
                            IconButton(
                              onPressed: ()async{
                                String number = _usuario.usuarioInmueblesBuscados[index].numeroTelefono; //set the number here
                                await FlutterPhoneDirectCaller.callNumber(number);
                              }, 
                              icon: iconc.FaIcon(iconc.FontAwesomeIcons.phone)
                            )
                          ],
                        ),
                      ),
                      selected: _inmueblesFiltrado.filtroBuscadoSeleccionado==index,
                      onTap: (){
                        if(_inmueblesFiltrado.filtroBuscadoSeleccionado==index){
                          _inmueblesFiltrado.setFiltroBuscadoSeleccionado(-1);
                        }else{
                          _inmueblesFiltrado.setFiltroBuscadoSeleccionado(index);
                        }
                      },
                    ),
                    if(_inmueblesFiltrado.filtroBuscadoSeleccionado==index)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: double.maxFinite,
                      //color:Colors.blue,
                     // height: 20,
                      //width: 500,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: children
                      )
                    ),
                    Container(
                      width: 500,
                      height: 1,
                      color: Colors.black.withOpacity(0.2),
                    )
                  ],
                );
              },
            )
          )
        ]
      ),
    );
  }
  List<Widget> generarTextoGenerales(UsuarioInmuebleBuscado buscado){
    TextStyle style=TextStyle(
      fontSize: 14,

    );
    TextStyle styleTitulo=TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold

    );
    List<Widget> children=[];
    if(buscado.superficieTerrenoMin<buscado.superficieTerrenoMax){
      children.add(
        Text(
          "Superficie de terreno: " +buscado.superficieTerrenoMin.toString()+" - "+buscado.superficieTerrenoMax.toString(),
          style: style,
        )
      );
    }
    if(buscado.superficieConstruccionMin<buscado.superficieConstruccionMax){
      children.add(
        Text(
          "Superficie de construcción: " +buscado.superficieConstruccionMin.toString()+" - "+buscado.superficieConstruccionMax.toString(),
          style: style,
        )
      );
    }
    if(buscado.tamanioFrenteMin<buscado.tamanioFrenteMax){
      children.add(
        Text(
          "Metros de frente: " +buscado.tamanioFrenteMin.toString()+" - "+buscado.tamanioFrenteMax.toString(),
          style: style,
        )
      );
    }
    if(buscado.antiguedadConstruccionMin<buscado.antiguedadConstruccionMax){
      children.add(
        Text(
          "Antigûedad de construcción: " +buscado.antiguedadConstruccionMin.toString()+" - "+buscado.antiguedadConstruccionMax.toString(),
          style: style,
        )
      );
    }
    if(buscado.mascotasPermitidas){
      children.add(
        Text(
          "Mascotas permitidas" ,
          style: style,
        )
      );
    }
    if(buscado.sinHipoteca){
      children.add(
        Text(
          "Sin hipoteca" ,
          style: style,
        )
      );
    }
    if(buscado.construccionEstrenar){
      children.add(
        Text(
          "Construcciones a estrenar " ,
          style: style,
        )
      );
    }
    if(buscado.materialesPrimera){
      children.add(
        Text(
          "Materiales de primera " ,
          style: style,
        )
      );
    }
    if(buscado.proyectoPreventa){
      children.add(
        Text(
          "Proyecto preventa " ,
          style: style,
        )
      );
    }
    if(buscado.inmuebleCompartido){
      children.add(
        Text(
          "Inmueble compartido: "+buscado.numeroDuenios.toString(),
          style: style,
        )
      );
    }
    if(buscado.serviciosBasicos){
      children.add(
        Text(
          "Servicios basicos " ,
          style: style,
        )
      );
    }
    if(buscado.gasDomiciliario){
      children.add(
        Text(
          "Gas domiciliario " ,
          style: style,
        )
      );
    }
    if(buscado.wifi){
      children.add(
        Text(
          "Wi-Fi " ,
          style: style,
        )
      );
    }
    if(buscado.medidorIndependiente){
      children.add(
        Text(
          "Medidor independiente " ,
          style: style,
        )
      );
    }
    if(buscado.termotanque){
      children.add(
        Text(
          "Termotanques " ,
          style: style,
        )
      );
    }
    if(buscado.calleAsfaltada){
      children.add(
        Text(
          "Calle alfaltada " ,
          style: style,
        )
      );
    }
    if(buscado.transporte){
      children.add(
        Text(
          "Transporte " ,
          style: style,
        )
      );
    }
    if(buscado.preparadoDiscapacidad){
      children.add(
        Text(
          "Preparado para discapacidad " ,
          style: style,
        )
      );
    }
    if(buscado.papelesOrden){
      children.add(
        Text(
          "Papeles en orden " ,
          style: style,
        )
      );
    }
    if(buscado.habilitadoCredito){
      children.add(
        Text(
          "Habilitado crédito de vivienda social " ,
          style: style,
        )
      );
    }
    if(children.length>0){
      children.insert(0, 
        Text(
          "GENERALES",
          style: styleTitulo,
        )
      );
    }
    return children;
  }
  List<Widget> generarTextoOtros(UsuarioInmuebleBuscado buscado){
    TextStyle style=TextStyle(
      fontSize: 14,

    );
    TextStyle styleTitulo=TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold

    );
    
    List<Widget> children=[];
    
    if(buscado.rematesJudiciales){
      children.add(
        Text(
          "Remates judiciales",
          style: style,
        )
      );
    }
    if(buscado.imagenes2D){
      children.add(
        Text(
          "Imágenes 2D",
          style: style,
        )
      );
    }
    if(buscado.video2D){
      children.add(
        Text(
          "Vídeo 2D",
          style: style,
        )
      );
    }
    if(buscado.tourVirtual360){
      children.add(
        Text(
          "Tour virtual 360",
          style: style,
        )
      );
    }
    if(buscado.videoTour360){
      children.add(
        Text(
          "Vídeo tour 360",
          style: style,
        )
      );
    }
    if(children.length>0){
      children.insert(0, 
        Text(
          "OTROS",
          style: styleTitulo,
        )
      );
    }
    return children; 
  }
  List<Widget> generarTextoComunidad(UsuarioInmuebleBuscado buscado){
    TextStyle style=TextStyle(
      fontSize: 14,

    );
    TextStyle styleTitulo=TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold

    );
    
    List<Widget> children=[];
    
    if(buscado.iglesia){
      children.add(
        Text(
          "Iglesia",
          style: style,
        )
      );
    }
    if(buscado.parqueInfantil){
      children.add(
        Text(
          "Parque infantil",
          style: style,
        )
      );
    }
    if(buscado.escuela){
      children.add(
        Text(
          "Escuela",
          style: style,
        )
      );
    }
    if(buscado.universidad){
      children.add(
        Text(
          "Universidad",
          style: style,
        )
      );
    }
    if(buscado.plazuela){
      children.add(
        Text(
          "Plazuela",
          style: style,
        )
      );
    }
    if(buscado.moduloPolicial){
      children.add(
        Text(
          "Módulo policial",
          style: style,
        )
      );
    }
    if(buscado.saunaPiscinaPublica){
      children.add(
        Text(
          "Sauna / piscina pública",
          style: style,
        )
      );
    }
    if(buscado.gymPublico){
      children.add(
        Text(
          "Gym público",
          style: style,
        )
      );
    }
    if(buscado.centroDeportivo){
      children.add(
        Text(
          "Centro deportivo",
          style: style,
        )
      );
    }
    if(buscado.puestoSalud){
      children.add(
        Text(
          "Puesto de salud",
          style: style,
        )
      );
    }
    if(buscado.zonaComercial){
      children.add(
        Text(
          "Zona comercial",
          style: style,
        )
      );
    }
    if(children.length>0){
      children.insert(0, 
        Text(
          "COMUNIDAD",
          style: styleTitulo,
        )
      );
    }
    return children;
  }
  List<Widget> generarTextoInternas(UsuarioInmuebleBuscado buscado){
    TextStyle style=TextStyle(
      fontSize: 14,

    );
    TextStyle styleTitulo=TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold

    );
    List<Widget> children=[];
    if(buscado.plantas>0){
      children.add(
        Text(
          "Plantas: ${buscado.plantas}",
          style: style,
        )
      );
    }
    if(buscado.ambientes>0){
      children.add(
        Text(
          "Ambientes: ${buscado.ambientes}",
          style: style,
        )
      );
    }
    if(buscado.dormitorios>0){
      children.add(
        Text(
          "Dormitorios: ${buscado.dormitorios}",
          style: style,
        )
      );
    }
    if(buscado.banios>0){
      children.add(
        Text(
          "Baños: ${buscado.banios}",
          style: style,
        )
      );
    }
    if(buscado.garaje>0){
      children.add(
        Text(
          "Garaje [Vehículos]: ${buscado.garaje}",
          style: style,
        )
      );
    }
    if(buscado.amoblado){
      children.add(
        Text(
          "Amoblado",
          style: style,
        )
      );
    }
    if(buscado.lavanderia){
      children.add(
        Text(
          "Lavanderia",
          style: style,
        )
      );
    }
    if(buscado.cuartoLavado){
      children.add(
        Text(
          "Cuarto de lavado",
          style: style,
        )
      );
    }
    if(buscado.churrasquero){
      children.add(
        Text(
          "Churrasquero",
          style: style,
        )
      );
    }
    if(buscado.azotea){
      children.add(
        Text(
          "Azotea",
          style: style,
        )
      );
    }
    if(buscado.condominioPrivado){
      children.add(
        Text(
          "[Club house]-> Condominio privado",
          style: style,
        )
      );
    }
    if(buscado.cancha){
      children.add(
        Text(
          "Cancha de fútbol, tenis, etc. en inmueble",
          style: style,
        )
      );
    }
    if(buscado.piscina){
      children.add(
        Text(
          "Piscina",
          style: style,
        )
      );
    }
    if(buscado.sauna){
      children.add(
        Text(
          "Sauna",
          style: style,
        )
      );
    }
    if(buscado.jacuzzi){
      children.add(
        Text(
          "Jacuzzi",
          style: style,
        )
      );
    }
    if(buscado.estudio){
      children.add(
        Text(
          "Estudio",
          style: style,
        )
      );
    }
    if(buscado.jardin){
      children.add(
        Text(
          "Jardín",
          style: style,
        )
      );
    }
    if(buscado.portonElectrico){
      children.add(
        Text(
          "Portón eléctrico",
          style: style,
        )
      );
    }
    if(buscado.aireAcondicionado){
      children.add(
        Text(
          "Aire acondicionado",
          style: style,
        )
      );
    }
    if(buscado.calefaccion){
      children.add(
        Text(
          "Calefacción",
          style: style,
        )
      );
    }
    if(buscado.ascensor){
      children.add(
        Text(
          "Ascensor",
          style: style,
        )
      );
    }
    if(buscado.deposito){
      children.add(
        Text(
          "Depósito",
          style: style,
        )
      );
    }
    if(buscado.sotano){
      children.add(
        Text(
          "Sótano",
          style: style,
        )
      );
    }
    if(buscado.tienda){
      children.add(
        Text(
          "Tienda",
          style: style,
        )
      );
    }
    if(buscado.amuralladoTerreno){
      children.add(
        Text(
          "[Amurallado]-> Terreno",
          style: style,
        )
      );
    }
    if(children.length>0){
      children.insert(0, 
        Text(
          "CARACTERÍSTICAS INTERNAS",
          style: styleTitulo,
        )
      );
    }
    return children;
  }
}