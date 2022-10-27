
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' as iconc;
import 'package:inmobiliariaapp/domain/entities/user_property_favorite.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_properties_searcheds.dart';
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
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context); 
    final userPropertiesSearchedsProvider=context.watch<UserPropertiesSearchedsProvider>();
    final userPropertiesSearcheds=userPropertiesSearchedsProvider.userPropertiesSearcheds;
    height=userPropertiesSearcheds.length*60;
    if(_inmueblesFiltrado.filtroBuscadoSeleccionado>=0){
      children=[];
      
      children=generarTextoGenerales(userPropertiesSearcheds[_inmueblesFiltrado.filtroBuscadoSeleccionado]);
      children.addAll(generarTextoInternas(userPropertiesSearcheds[_inmueblesFiltrado.filtroBuscadoSeleccionado]));
      children.addAll(generarTextoComunidad(userPropertiesSearcheds[_inmueblesFiltrado.filtroBuscadoSeleccionado]));
      children.addAll(generarTextoOtros(userPropertiesSearcheds[_inmueblesFiltrado.filtroBuscadoSeleccionado]));
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
              itemCount: userPropertiesSearcheds.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text("${userPropertiesSearcheds[index].configurationName}",
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
                                String number = userPropertiesSearcheds[index].phoneNumber; //set the number here
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
  List<Widget> generarTextoGenerales(UserPropertySearched searched){
    TextStyle style=TextStyle(
      fontSize: 14,

    );
    TextStyle styleTitulo=TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold

    );
    List<Widget> children=[];
    if(searched.landSurfaceMin<searched.landSurfaceMax){
      children.add(
        Text(
          "Superficie de terreno: " +searched.landSurfaceMin.toString()+" - "+searched.landSurfaceMax.toString(),
          style: style,
        )
      );
    }
    if(searched.constructionSurfaceMin<searched.constructionSurfaceMax){
      children.add(
        Text(
          "Superficie de construcción: " +searched.constructionSurfaceMin.toString()+" - "+searched.constructionSurfaceMax.toString(),
          style: style,
        )
      );
    }
    if(searched.frontSizeMin<searched.frontSizeMax){
      children.add(
        Text(
          "Metros de frente: " +searched.frontSizeMin.toString()+" - "+searched.frontSizeMax.toString(),
          style: style,
        )
      );
    }
    if(searched.constructionAntiquityMin<searched.constructionAntiquityMax){
      children.add(
        Text(
          "Antigûedad de construcción: " +searched.constructionAntiquityMin.toString()+" - "+searched.constructionAntiquityMax.toString(),
          style: style,
        )
      );
    }
    if(searched.enablePets){
      children.add(
        Text(
          "Mascotas permitidas" ,
          style: style,
        )
      );
    }
    if(searched.noMortgage){
      children.add(
        Text(
          "Sin hipoteca" ,
          style: style,
        )
      );
    }
    if(searched.newConstruction){
      children.add(
        Text(
          "Construcciones a estrenar " ,
          style: style,
        )
      );
    }
    if(searched.premiumMaterials){
      children.add(
        Text(
          "Materiales de primera " ,
          style: style,
        )
      );
    }
    if(searched.preSaleProject){
      children.add(
        Text(
          "Proyecto preventa " ,
          style: style,
        )
      );
    }
    if(searched.sharedProperty){
      children.add(
        Text(
          "Inmueble compartido: "+searched.ownersNumber.toString(),
          style: style,
        )
      );
    }
    if(searched.basicServices){
      children.add(
        Text(
          "Servicios basicos " ,
          style: style,
        )
      );
    }
    if(searched.householdGas){
      children.add(
        Text(
          "Gas domiciliario " ,
          style: style,
        )
      );
    }
    if(searched.wifi){
      children.add(
        Text(
          "Wi-Fi " ,
          style: style,
        )
      );
    }
    if(searched.independentMeter){
      children.add(
        Text(
          "Medidor independiente " ,
          style: style,
        )
      );
    }
    if(searched.hotWaterTank){
      children.add(
        Text(
          "Termotanques " ,
          style: style,
        )
      );
    }
    if(searched.pavedStreet){
      children.add(
        Text(
          "Calle alfaltada " ,
          style: style,
        )
      );
    }
    if(searched.transport){
      children.add(
        Text(
          "Transporte " ,
          style: style,
        )
      );
    }
    if(searched.disabilityPrepared){
      children.add(
        Text(
          "Preparado para discapacidad " ,
          style: style,
        )
      );
    }
    if(searched.orderPapers){
      children.add(
        Text(
          "Papeles en orden " ,
          style: style,
        )
      );
    }
    if(searched.enabledCredit){
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
  List<Widget> generarTextoOtros(UserPropertySearched searched){
    TextStyle style=TextStyle(
      fontSize: 14,

    );
    TextStyle styleTitulo=TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold

    );
    
    List<Widget> children=[];
    
    if(searched.judicialAuctions){
      children.add(
        Text(
          "Remates judiciales",
          style: style,
        )
      );
    }
    if(searched.video2DLink){
      children.add(
        Text(
          "Vídeo 2D",
          style: style,
        )
      );
    }
    if(searched.tourVirtual360Link){
      children.add(
        Text(
          "Tour virtual 360",
          style: style,
        )
      );
    }
    if(searched.videoTour360Link){
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
  List<Widget> generarTextoComunidad(UserPropertySearched searched){
    TextStyle style=TextStyle(
      fontSize: 14,

    );
    TextStyle styleTitulo=TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold

    );
    
    List<Widget> children=[];
    
    if(searched.church){
      children.add(
        Text(
          "Iglesia",
          style: style,
        )
      );
    }
    if(searched.playground){
      children.add(
        Text(
          "Parque infantil",
          style: style,
        )
      );
    }
    if(searched.school){
      children.add(
        Text(
          "Escuela",
          style: style,
        )
      );
    }
    if(searched.university){
      children.add(
        Text(
          "Universidad",
          style: style,
        )
      );
    }
    if(searched.smallSquare){
      children.add(
        Text(
          "Plazuela",
          style: style,
        )
      );
    }
    if(searched.policeModule){
      children.add(
        Text(
          "Módulo policial",
          style: style,
        )
      );
    }
    if(searched.publicSaunaPool){
      children.add(
        Text(
          "Sauna / piscina pública",
          style: style,
        )
      );
    }
    if(searched.publicGym){
      children.add(
        Text(
          "Gym público",
          style: style,
        )
      );
    }
    if(searched.sportCenter){
      children.add(
        Text(
          "Centro deportivo",
          style: style,
        )
      );
    }
    if(searched.postHeath){
      children.add(
        Text(
          "Puesto de salud",
          style: style,
        )
      );
    }
    if(searched.shoopingZone){
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
  List<Widget> generarTextoInternas(UserPropertySearched searched){
    TextStyle style=TextStyle(
      fontSize: 14,

    );
    TextStyle styleTitulo=TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold

    );
    List<Widget> children=[];
    if(searched.floorsNumber>0){
      children.add(
        Text(
          "Plantas: ${searched.floorsNumber}",
          style: style,
        )
      );
    }
    if(searched.roomsNumber>0){
      children.add(
        Text(
          "Ambientes: ${searched.roomsNumber}",
          style: style,
        )
      );
    }
    if(searched.bedroomsNumber>0){
      children.add(
        Text(
          "Dormitorios: ${searched.bedroomsNumber}",
          style: style,
        )
      );
    }
    if(searched.bathroomsNumber>0){
      children.add(
        Text(
          "Baños: ${searched.bathroomsNumber}",
          style: style,
        )
      );
    }
    if(searched.garagesNumber>0){
      children.add(
        Text(
          "Garaje [Vehículos]: ${searched.garagesNumber}",
          style: style,
        )
      );
    }
    if(searched.furnished){
      children.add(
        Text(
          "Amoblado",
          style: style,
        )
      );
    }
    if(searched.laundry){
      children.add(
        Text(
          "Lavanderia",
          style: style,
        )
      );
    }
    if(searched.laundryRoom){
      children.add(
        Text(
          "Cuarto de lavado",
          style: style,
        )
      );
    }
    if(searched.grill){
      children.add(
        Text(
          "Churrasquero",
          style: style,
        )
      );
    }
    if(searched.rooftop){
      children.add(
        Text(
          "Azotea",
          style: style,
        )
      );
    }
    if(searched.privateCondominium){
      children.add(
        Text(
          "[Club house]-> Condominio privado",
          style: style,
        )
      );
    }
    if(searched.court){
      children.add(
        Text(
          "Cancha de fútbol, tenis, etc. en inmueble",
          style: style,
        )
      );
    }
    if(searched.pool){
      children.add(
        Text(
          "Piscina",
          style: style,
        )
      );
    }
    if(searched.sauna){
      children.add(
        Text(
          "Sauna",
          style: style,
        )
      );
    }
    if(searched.jacuzzi){
      children.add(
        Text(
          "Jacuzzi",
          style: style,
        )
      );
    }
    if(searched.studio){
      children.add(
        Text(
          "Estudio",
          style: style,
        )
      );
    }
    if(searched.garden){
      children.add(
        Text(
          "Jardín",
          style: style,
        )
      );
    }
    if(searched.electricGate){
      children.add(
        Text(
          "Portón eléctrico",
          style: style,
        )
      );
    }
    if(searched.airConditioning){
      children.add(
        Text(
          "Aire acondicionado",
          style: style,
        )
      );
    }
    if(searched.heating){
      children.add(
        Text(
          "Calefacción",
          style: style,
        )
      );
    }
    if(searched.elevator){
      children.add(
        Text(
          "Ascensor",
          style: style,
        )
      );
    }
    if(searched.warehouse){
      children.add(
        Text(
          "Depósito",
          style: style,
        )
      );
    }
    if(searched.basement){
      children.add(
        Text(
          "Sótano",
          style: style,
        )
      );
    }
    if(searched.store){
      children.add(
        Text(
          "Tienda",
          style: style,
        )
      );
    }
    if(searched.landWalled){
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