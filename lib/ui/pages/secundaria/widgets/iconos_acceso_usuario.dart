import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/domain/usecases/inmueble/usecase_inmueble.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' as iconc;
import 'package:inmobiliariaapp/domain/usecases/inmueble/usecase_inmueble_base.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/container_listado_inmuebles.dart';
import 'package:inmobiliariaapp/ui/pages/registro_inmuebles/widgets/mapa_registro_inmueble.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_otros_info.dart';
import 'package:inmobiliariaapp/ui/provider/usuarios_info.dart';
import 'package:inmobiliariaapp/widgets/utils.dart';
import 'package:provider/provider.dart';
import 'package:inmobiliariaapp/domain/usecases/inmueble/filtrado_inmuebles.dart' as filtrado_inmuebles;
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
class IconosAccesoUsuario extends StatefulWidget {
  const IconosAccesoUsuario({Key? key,required this.inmuebleTotal}) : super(key: key);
  final InmuebleTotal inmuebleTotal;
  @override
  _IconosAccesoUsuarioState createState() => _IconosAccesoUsuarioState();
}

class _IconosAccesoUsuarioState extends State<IconosAccesoUsuario> {
  Future<SharedPreferences> _prefs=SharedPreferences.getInstance();
  bool vertical=true;
  double height=0.0;
  double width=0.0;
  bool isContacto=false;
  bool isLinks=false;
  ScrollController? scrollController=ScrollController(initialScrollOffset:0);
  UseCaseInmueble useCaseInmueble=UseCaseInmueble();
  UseCaseInmuebleBase useCaseInmuebleBase=UseCaseInmuebleBase();
  bool isVertical=true;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    final UsuariosInfo usuariosInfo=Provider.of<UsuariosInfo>(context);
    final _mapaFiltroOtros=Provider.of<MapaFiltroOtrosInfo>(context);
    if(MediaQuery.of(context).size.height>MediaQuery.of(context).size.width){
      width=47*6;
      if(isContacto){
        width+=47*3;
      }
      if(isLinks){
        width+=47*3;
      }
      if(width>MediaQuery.of(context).size.width){
        width=MediaQuery.of(context).size.width;
      }
      isVertical=true;
    }else{
      width=47*6;
      if(isContacto){
        width+=47*3;
      }
      if(isLinks){
        width+=47*3;
      }
      if(width>MediaQuery.of(context).size.width*1.9){
        width=MediaQuery.of(context).size.width*1.9;
      }
      isVertical=false;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      margin: isVertical?EdgeInsets.all(0):EdgeInsets.only(top: 0,bottom: 25,left: 0,right: 0),
      width: width,
      height: 50,
        child: ListView(
          scrollDirection: Axis.horizontal,
          controller: scrollController,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconoAccesoItem(
              icon: Icon(Icons.group_work,color: isLinks?Colors.blueAccent:Colors.blueGrey),
              texto: "",
              onTap:(){
                isLinks=!isLinks;
                setState(() {
                  
                });
                /*setState(() {
                  if(isContacto)
                    scrollController!.animateTo(width, duration: Duration(milliseconds: 100), curve: Curves.linear);
                  else
                    scrollController!.animateTo(0, duration: Duration(milliseconds: 100), curve: Curves.linear);
                });*/
              }
            ),
            if(isLinks)
            Row(
              children: [
                IconoAccesoItem(
                  icon: Icon(Icons.web_sharp,color: Colors.blueGrey),
                  texto: "",
                  onTap:()async{
                    //await dialogZoomImagen(context);
                  }
                ),
                IconoAccesoItem(
                  icon: Icon(Icons.video_collection,color: Colors.blueGrey),
                  texto: "",
                  onTap:(){}
                ),
                IconoAccesoItem(
                  icon: Icon(Icons.video_label,color: Colors.blueGrey),
                  texto: "",
                  onTap:(){}
                ),
              ],
            ),
            
            
            IconoAccesoItem(icon: Icon(Icons.public,color: Colors.blueGrey),
              texto: "",
              onTap:(){
                showModalBottomSheet(
                  shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20),),
                  ),
                  elevation: 50,
                  context: context,
                  isDismissible: true,
                  builder: (context) {
                    return MapaRegistroInmueble(
                      inmueble:widget.inmuebleTotal.getInmueble
                    );
                  },
                );
              }
            ),
            IconoAccesoItem(
              icon: widget.inmuebleTotal.getUsuarioFavorito.favorito?
              Icon(Icons.favorite,color: Colors.red,)
              :Icon(Icons.favorite_border,color: Colors.blueGrey,),
              texto: "",
              onTap:(){
                widget.inmuebleTotal.getUsuarioFavorito.favorito=!widget.inmuebleTotal.getUsuarioFavorito.favorito;
                if(widget.inmuebleTotal.getUsuarioFavorito.favorito)
                  widget.inmuebleTotal.inmueble.cantidadFavoritos=widget.inmuebleTotal.inmueble.cantidadFavoritos+1;
                else
                  widget.inmuebleTotal.inmueble.cantidadFavoritos=widget.inmuebleTotal.inmueble.cantidadFavoritos-1;
                _inmueblesFiltrado.setFiltrar(false);
                _inmueblesFiltrado.setInmueblesItem(widget.inmuebleTotal,_mapaFiltroOtros.getMapaFiltroOrden,"modificar");
                usuariosInfo.setUsuarioInmuebleBases(filtrado_inmuebles.generarInmuebleBase(usuariosInfo.getUsuario.getId, inmueblesTotalGeneral));
                useCaseInmueble.registrarFavoritos(usuariosInfo.usuario, widget.inmuebleTotal).then((value){
                  if(value){
                    //_inmueblesFiltrado.setFiltrar(false);
                    //_inmueblesFiltrado.setInmueblesItem(inmuebleInfo.getInmuebleTotal,_mapaFiltroOtros.getMapaFiltroOrden,"modificar");
                    //usuariosInfo.setUsuarioInmuebleBases(filtrado_inmuebles.generarInmuebleBase(usuariosInfo.getUsuario.getId, inmueblesTotalGeneral));
                  }else{
                    widget.inmuebleTotal.getUsuarioFavorito.favorito=!widget.inmuebleTotal.getUsuarioFavorito.favorito;
                    ScaffoldMessenger.of(context).showSnackBar(showSnackBar("¡Error! Por favor intente más tarde"));
                  }
                }).whenComplete((){
                  useCaseInmuebleBase.registrarInmuebleBase(usuariosInfo.usuarioInmuebleBases, _prefs).whenComplete(() {
                    //ScaffoldMessenger.of(context).showSnackBar(showSnackBar("guardado en caché"));
                    //print("guardado");
                  });
                });
              }
            ),
            IconoAccesoItem(
              icon: Icon(Icons.share,color: Colors.blueGrey),
              texto:"",
              onTap:(){
                Share.share("hola");
                  //Share.share('Sitio web https://example.com', subject: 'Titulo!');
                setState(() {
                  
                });
              }
            ),
            IconoAccesoItem(
              icon: Icon(Icons.download,color: Colors.blueGrey),
              texto: "",
              onTap:()async{
                var status=await Permission.storage.request();
                if(status.isGranted){
                  for(int i=0;i<widget.inmuebleTotal.getInmueble.getImagenesCategorias.length;i++){
                    for(int j=0;j<widget.inmuebleTotal.inmueble.getImagenesCategorias[i].length;j++){
                      var response=await Dio().get(widget.inmuebleTotal.inmueble.getImagenesCategorias[i][j],options: Options(
                        responseType: ResponseType.bytes
                      ));
                      
                      var datetime=DateTime.now();
                      String nameFile="${datetime.year}${datetime.month}${datetime.day}${datetime.hour}${datetime.minute}${datetime.second}${datetime.millisecond}";
                      //print(nameFile);
                      final result= await ImageGallerySaver.saveImage(
                        Uint8List.fromList(response.data),
                        quality: 60,
                        name:nameFile
                      );
                      print(result);
                    }
                  }
                }
              }
            ),
            IconoAccesoItem(
              icon: Icon(Icons.person,color: isContacto?Colors.blueAccent:Colors.blueGrey),
              texto: "",
              onTap:(){
                isContacto=!isContacto;
                setState(() {
                  if(isContacto)
                    scrollController!.animateTo(width, duration: Duration(milliseconds: 100), curve: Curves.linear);
                  else
                    scrollController!.animateTo(0, duration: Duration(milliseconds: 100), curve: Curves.linear);
                });
              }
            ),
            if(isContacto)
            Row(
              children:[
                IconoAccesoItem(
                  icon: Icon(Icons.view_agenda,color: Colors.blueAccent),
                  texto: "",
                  onTap:(){
                  }
                ),
                IconoAccesoItem(
                  icon: iconc.FaIcon(iconc.FontAwesomeIcons.whatsapp,color: Colors.blueAccent),
                  texto: "",
                  onTap:(){
                  }
                ),
                IconoAccesoItem(
                  icon: Icon(Icons.phone,color: Colors.blueAccent),
                  texto: "",
                  onTap:(){
                  }
                ),
              ]
            ),
          ],
        ),
    );
  }
}
class IconoAccesoItem extends StatefulWidget {
  IconoAccesoItem({Key? key,required this.icon,required this.texto,required this.onTap}) : super(key: key);
  final Widget icon;
  final String texto;
  final VoidCallback onTap;
  @override
  _IconoAccesoItemState createState() => _IconoAccesoItemState();
}

class _IconoAccesoItemState extends State<IconoAccesoItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight:Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)
      ),

      splashColor: Colors.lightBlue,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2),
        width: widget.texto.length>0?50:40,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight:Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.icon,
            Text(widget.texto,
              style: TextStyle(
                color: Colors.blueGrey,
                fontWeight:FontWeight.bold
              ),
            )
          ]
        )
      ),
      onTap: 
        widget.onTap
    );
  }
}
