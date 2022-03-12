
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/data/configuration/graphql_configuration.dart';
import 'package:inmobiliariaapp/data/repositories/venta/inmueble_venta_repository_gql.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:inmobiliariaapp/domain/entities/planes_pago_publicacion.dart';
import 'package:inmobiliariaapp/domain/usecases/generales/usecase_planes_pago_publicacion.dart';
import 'package:inmobiliariaapp/ui/pages/registro_inmuebles/widgets/container_inmueble_comunidad.dart';
import 'package:inmobiliariaapp/ui/pages/registro_inmuebles/widgets/container_inmueble_generales.dart';
import 'package:inmobiliariaapp/ui/pages/registro_inmuebles/widgets/container_inmueble_internas.dart';
import 'package:inmobiliariaapp/ui/pages/registro_inmuebles/widgets/container_inmueble_otros.dart';
import 'package:inmobiliariaapp/ui/pages/registro_inmuebles/widgets/container_inmueble_planes_pago.dart';
import 'package:inmobiliariaapp/ui/provider/inmueble_info.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_otros_info.dart';
import 'package:inmobiliariaapp/ui/provider/usuarios_info.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class PageRegistroInmueble extends StatefulWidget {
  PageRegistroInmueble({Key? key}) : super(key: key);

  @override
  _PageRegistroInmuebleState createState() => _PageRegistroInmuebleState();
}

class _PageRegistroInmuebleState extends State<PageRegistroInmueble> {
  bool uploading=false;
  double valorCarga=0.0;
  double porcentajeCarga=0.0;
  List<PlanesPagoPublicacion> planes=[];
  UseCasePlanesPagoPublicacion useCasePlanesPagoPublicacion=UseCasePlanesPagoPublicacion();
  @override
  void initState() {
    super.initState();
    useCasePlanesPagoPublicacion.obtenerPlanesPagoPublicacion()
    .then((resultado){
      if(resultado["completado"]){
        planes=resultado["planes_pago_publicacion"];
        setState(() {
          
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final inmuebleInfo=Provider.of<InmuebleInfo>(context);
    final usuario=Provider.of<UsuariosInfo>(context);
    final _mapaFiltroOtros=Provider.of<MapaFiltroOtrosInfo>(context);
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    _inmueblesFiltrado.setFiltrar(false);
    _inmueblesFiltrado.setConsultarBD(false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de inmuebles"),
      ),
      body: Container(
        //color:Colors.blueGrey,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.white,
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: inmuebleInfo.pasoCategorias.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      TabBarItemStep(paso: inmuebleInfo.pasoCategorias[index],),
                      index<inmuebleInfo.pasoCategorias.length-1?Container(
                        margin: EdgeInsets.only(left: 10),
                        width: 30,
                        height: 30,
                        //color: Colors.black,
                        child: Icon(Icons.arrow_forward_ios,color: Colors.black54,),
                      ):Container(),
                    ],
                  );
                },
              ),
            ),
            Expanded(
              child: Container(
                //color: Colors.amber,
                child: Column(
                  children: [
                    inmuebleInfo.seleccionadoCategoria("Generales")?
                    Expanded(child: ContainerInmuebleGenerales()):Container(),
                    inmuebleInfo.seleccionadoCategoria("Internas")?
                    Expanded(child: ContainerInmuebleInternas()):Container(),
                    inmuebleInfo.seleccionadoCategoria("Comunidad")?
                    Expanded(child: ContainerInmuebleComunidad()):Container(),
                    inmuebleInfo.seleccionadoCategoria("Planes")?
                    Expanded(child: ContainerInmueblePlanesPago(planes: planes,)):Container(),
                    inmuebleInfo.seleccionadoCategoria("Otros")?
                    Expanded(child: ContainerInmuebleOtros()):Container(),
                  ],
                ),
              )
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              color: Colors.white,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  !inmuebleInfo.pasoCategorias[0].seleccionado?
                  OutlinedButton(
                    onPressed: (){
                      inmuebleInfo.avanzarPasoCategoria(false);
                    }, 
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios,color:Colors.red),
                        Text("Anterior",
                          style: TextStyle(
                            color: Colors.red
                          ),
                        ),
                      ],
                    )
                  ):Container(),
                  SizedBox(width: 5,),
                  !inmuebleInfo.pasoCategorias[inmuebleInfo.pasoCategorias.length-1].seleccionado?
                  OutlinedButton(
                    onPressed: (){
                      inmuebleInfo.avanzarPasoCategoria(true);
                    }, 
                    child: Row(
                      children: [
                        Text("Siguiente"),
                        Icon(Icons.arrow_forward_ios,color:Colors.blue)
                      ],
                    )
                  ):Container(),
                ],
              )
            ),
            InkWell(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight:Radius.circular(20),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0)
              ),

      //splashColor: Colors.lightBlue,
              splashColor: Colors.blue[900],
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  gradient: !uploading?LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.green.withOpacity(0.5),
                      Colors.blue,
                    ],
                  ):
                  LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.grey.withOpacity(0.5),
                      Colors.grey,
                    ],
                  ),
                  /*boxShadow: [
                    BoxShadow(
                      color: Colors.green,
                      blurRadius: 50
                    ),
                    BoxShadow(
                      color: Colors.grey
                    )
                  ],*/
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight:Radius.circular(20),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0)
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(uploading?porcentajeCarga.toString()+"% "
                    :
                    inmuebleInfo.getInmuebleTotalCopia.inmueble.id!=""?"Modificar":
                    "Registrar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                      ),
                    ),
                    uploading?SizedBox(width: 10,):Container(),
                    uploading?CircularProgressIndicator.adaptive(
                      value: valorCarga,
                      semanticsValue: "adsads",
                      semanticsLabel: "Va",
                      backgroundColor: Colors.white,
                    ):Container()
                  ],
                ),
              ),
              onTap: ()async{
                if(!uploading){
                  //print("${inmuebleInfo.inmuebleTotalCopia.inmueble.mapImagenes}");
                  int cantidadImagenes=inmuebleInfo.inmuebleTotalCopia.inmueble.getCantidadImagenes;
                  int acumulado=0;
                  uploading=true;
                  setState(() {
                    valorCarga=0.0;
                    porcentajeCarga=0.0;
                  });
                  for(int i=0;i<inmuebleInfo.inmuebleTotalCopia.inmueble.mapImagenes.keys.length;i++){
                    if(inmuebleInfo.inmuebleTotalCopia.inmueble.mapImagenes.keys.elementAt(i)!="principales"){
                      List aux=[];
                      aux.addAll(inmuebleInfo.inmuebleTotalCopia.inmueble.mapImagenes[inmuebleInfo.inmuebleTotalCopia.inmueble.mapImagenes.keys.elementAt(i)]);
                      List principales=[];
                        for(int k=0;k<aux.length;k++){
                         //print(aux[k]);
                          if(aux[k] is File){
                           print("- ${aux[k]}");
                         }
                      }
                      principales.addAll(inmuebleInfo.inmuebleTotalCopia.inmueble.mapImagenes["principales"]);
                      print( inmuebleInfo.inmuebleTotalCopia.inmueble.mapImagenes[inmuebleInfo.inmuebleTotalCopia.inmueble.mapImagenes.keys.elementAt(i)]);
                      
                      inmuebleInfo.inmuebleTotalCopia.inmueble.mapImagenes[inmuebleInfo.inmuebleTotalCopia.inmueble.mapImagenes.keys.elementAt(i)]=await uploadImage(inmuebleInfo.inmuebleTotalCopia.inmueble.mapImagenes[inmuebleInfo.inmuebleTotalCopia.inmueble.mapImagenes.keys.elementAt(i)]).whenComplete(()async {
                        setState(() {
                          List imagenes=inmuebleInfo.inmuebleTotalCopia.inmueble.mapImagenes[inmuebleInfo.inmuebleTotalCopia.inmueble.mapImagenes.keys.elementAt(i)];
                          for(int j=0;j<principales.length;j++){
                            for(int k=0;k<aux.length;k++){
                              if(aux[k] is File){
                                print("${principales[j]} - - ${aux[k]}");
                              }
                              if(principales[j]==aux[k]){
                                principales[j]=imagenes[k];
                              }
                            }
                          }
                          inmuebleInfo.inmuebleTotalCopia.inmueble.mapImagenes["principales"]=principales;
                          //print(principales);
                          acumulado+=imagenes.length;
                          valorCarga=acumulado/cantidadImagenes;
                          porcentajeCarga=(valorCarga*100).roundToDouble();
                          //print(valorCarga);
                        });
                      });
                    }
                  }
                  //pwrint("object");
                  //print(inmuebleInfo.inmuebleTotal.inmueble.mapImagenes["principales"]);
                  inmuebleInfo.inmuebleTotalCopia.inmueble.mapImagenes["principales"].removeWhere((element) => element is File);
                  //inmuebleInfo.inmuebleTotal.inmueble.mapImagenes.removeWhere((key, value) => key=="__typename"||key=="inmueble");
                  //inmuebleInfo.inmuebleTotal.inmueble.mapImagenes["principales"].removeWhere();
                  Map<String,dynamic> resultado=await registrarModificarInmueble(usuario, inmuebleInfo.inmuebleTotalCopia);
                  if(resultado["respuesta"]){
                    if(resultado["inmueble"].inmueble.id!=""){
                      inmuebleInfo.setInmueblesTotal(resultado["inmueble"]);
                      _inmueblesFiltrado.setFiltrar(true);
                      _inmueblesFiltrado.setInmueblesItem(inmuebleInfo.getInmuebleTotalCopia,_mapaFiltroOtros.getMapaFiltroOrden,"insertar");
                    }else{
                      inmuebleInfo.setInmueblesTotal(inmuebleInfo.inmuebleTotalCopia);
                      _inmueblesFiltrado.setFiltrar(true);
                      _inmueblesFiltrado.setInmueblesItem(inmuebleInfo.inmuebleTotalCopia,_mapaFiltroOtros.getMapaFiltroOrden,"modificar");
                      setState(() {
                        
                      });
                    }
                  }
                  uploading=false;
                  setState(() {
                    
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
class TabBarItemStep extends StatefulWidget {
  TabBarItemStep({Key? key,required this.paso}) : super(key: key);
  final PasoCategoria paso;
  @override
  _TabBarItemStepState createState() => _TabBarItemStepState();
}

class _TabBarItemStepState extends State<TabBarItemStep> {
  
  @override
  Widget build(BuildContext context) {
    final inmuebleInfo=Provider.of<InmuebleInfo>(context);
    return InkWell(
      splashColor: Colors.green,
      highlightColor: Colors.black,
      customBorder: StadiumBorder(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
        child: Row(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.blue,
              child: Text(widget.paso.numero.toString(),
                style: TextStyle(
                  color:Colors.white
                ),
              ),
            ),
            SizedBox(width: 5,),
            Text(widget.paso.categoria,
              style: TextStyle(
                color:Colors.black,
                fontWeight: widget.paso.seleccionado?FontWeight.bold:FontWeight.normal
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
          color: widget.paso.seleccionado?Colors.blue.withOpacity(0.2):Colors.white,
          //border: Border.all(color: Colors.blueGrey),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight:Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
        ),
      ),
      onTap: (){
        inmuebleInfo.onPasoCategoriaSelected(widget.paso.numero);
      },
    );
  }
}
Future<Map<String,dynamic>> registrarModificarInmueble(UsuariosInfo usuario,InmuebleTotal inmuebleTotal)async{
  Map<String,dynamic> resultado={
    "respuesta":false,
    "inmueble":InmuebleTotal.vacio()
  };
  GraphQLConfiguration configuration=GraphQLConfiguration();
  graphql.GraphQLClient client=configuration.myGQLClient();
  
  await client
  .mutate(
    graphql.MutationOptions(
      document: graphql.gql(getQueryMutationRegistrarInmueble(inmuebleTotal.getInmueble.id),
    ),
    variables: (
      getMapMutationRegistroInmueble(inmuebleTotal)
    ),
    onCompleted: (dynamic data){
      if(data!=null){
        if(inmuebleTotal.inmueble.id!=""){
          if(data!["registrarInmueble"]!=null){
            resultado["inmueble"]=InmuebleTotal.fromMap(usuario.tipoSesion, data!["registrarInmueble"]);
          }
        }else{
          if(data!["actualizarInmueble"]!=null){
            resultado["inmueble"]=InmuebleTotal.vacio();
          }
        }
        resultado["respuesta"]=true;
      }
    },
    onError: (error){
      resultado["respuesta"]=false;
    }
  ));
  return resultado;
}
Future<List<dynamic>> uploadImage(List<dynamic> imagenes) async{
  print("imagenes ${imagenes}");
  List<dynamic> linksImagenes=[];
  firebase_storage.Reference? ref;
  for(var img in imagenes){
    if(img is File){
      // ignore: unnecessary_cast
      ref=firebase_storage.FirebaseStorage.instance.ref().child('images/${(img as File).path}');
      await ref.putFile(img).whenComplete(() async{
        await ref!.getDownloadURL().then((value) {
          //img=value;
          linksImagenes.add(value);
          //imagenesRegistrar.add(value);
        });
      });
    }else{
      linksImagenes.add(img);
    }
  }
  //print(await ref!.listAll());
  //print("lista de imagenes $linksImagenes");
  return linksImagenes;
}

bool buscarPrincipal(List<dynamic> imagenes,dynamic link){
  for(int i=0;i<imagenes.length;i++){
    if(imagenes[i]==link){
      return true;
    }
  }
  return false;
}