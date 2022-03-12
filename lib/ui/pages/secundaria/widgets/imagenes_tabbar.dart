
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_reportado.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/domain/entities/solicitud_administrador.dart';
import 'package:inmobiliariaapp/domain/usecases/inmueble/usecase_inmueble_reportado.dart';
import 'package:inmobiliariaapp/domain/usecases/inmueble/usecase_inmueble_venta.dart';
import 'package:inmobiliariaapp/ui/provider/inmueble_info.dart';
import 'package:inmobiliariaapp/ui/provider/usuarios_info.dart';
import 'package:inmobiliariaapp/widgets/textField_modelos.dart';
import 'package:inmobiliariaapp/widgets/utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';
class ImagenesTabBar extends StatefulWidget {
  ImagenesTabBar({Key? key,required this.inmuebleTotal}) : super(key: key);
  final InmuebleTotal inmuebleTotal;
  @override
  _ImagenesTabBarState createState() => _ImagenesTabBarState();
}

class _ImagenesTabBarState extends State<ImagenesTabBar> with TickerProviderStateMixin{
  //ImagenesInmuebleInfo? imagenesInmueble=ImagenesInmuebleInfo();
  double imagenHeight=0;
  double imagenWidth=0;
  bool isVertical=true;
  @override
  Widget build(BuildContext context) {
    final imagenesInmueble=Provider.of<InmuebleInfo>(context);
    final _usuario=Provider.of<UsuariosInfo>(context);
    if(MediaQuery.of(context).size.height>MediaQuery.of(context).size.width){
      isVertical=true;
      imagenWidth=MediaQuery.of(context).size.width;
      imagenHeight=imagenWidth*0.7;
    }else{
      isVertical=false;
      imagenHeight=MediaQuery.of(context).size.height*.75;
      imagenWidth=MediaQuery.of(context).size.width/1.9;
    }
    if(imagenesInmueble.imagenesCategorias.length==0){
      imagenesInmueble.init(this,widget.inmuebleTotal.getInmueble.getImagenesCategorias,widget.inmuebleTotal.getInmueble.categoriasImagen,widget.inmuebleTotal.getInmueble.categoriasKeys,imagenWidth,imagenHeight);
    }
    return AnimatedBuilder(
      animation: imagenesInmueble, 
      builder: (_,__){
        return Row(
          children: [
            Container(
              width: imagenWidth,
              height: imagenHeight,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child:PageView.builder(
                          pageSnapping: true,
                          allowImplicitScrolling: false,
                          controller: imagenesInmueble.pageController,
                          onPageChanged: (currentPage){
                            imagenesInmueble.buscarCategoria(currentPage);
                            //imagenesInmueble.currentPage=currentPage;
                          },
                          itemCount: imagenesInmueble.items.length,
                          itemBuilder: (context, index) {
                            final imagen=imagenesInmueble.items[index].imagen;
                            return InkWell(
                              onTap: ()async{
                                await dialogZoomImagen(context, imagen);
                              },
                              child: Card(
                                elevation: 10,
                                margin: const EdgeInsets.only(top: 0,bottom: 0,left: 5,right: 5),
                                child: Container(
                                  height: imagenHeight-10,
                                  width: imagenWidth-10,
                                  //margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(0),
                                  //color:Colors.lightBlue,
                                  child: CachedNetworkImage(
                                    imageUrl: imagen,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    width: 40,
                    height: imagenHeight,
                    color: Colors.black.withOpacity(0.2),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            controller: imagenesInmueble.scrollControllerCategoria,
                            itemCount: imagenesInmueble.tabs.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                child: TabBarCategorias(
                                  categoria: imagenesInmueble.tabs[index]
                                ),
                                onTap: (){
                                  imagenesInmueble.onCategoriaSelected(index);
                                },
                              );
                            },
                          )
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    width: 50,
                    height: 50,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      width:30,
                      height: 30,
                      
                      child: IconButton(
                        iconSize: 25,
                        padding: EdgeInsets.zero,
                        alignment: Alignment.center,
                        icon: Icon(Icons.more_vert,color: Colors.white),
                        onPressed: ()async{
                          await dialogFiltrar(context,_usuario.tipoSesion);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }
    );
  }
}
class TabBarCategorias extends StatefulWidget {
  TabBarCategorias({Key? key,required this.categoria}) : super(key: key);
  final  ImagenesTabCategoria categoria;
  @override
  _TabBarCategoriasState createState() => _TabBarCategoriasState();
}

class _TabBarCategoriasState extends State<TabBarCategorias> {
  
  @override
  void initState() {
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      
      margin: EdgeInsets.symmetric(vertical:10),
      padding: EdgeInsets.symmetric(vertical:10),
      decoration: BoxDecoration(
        //backgroundBlendMode: BlendMode.c,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight:Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10)),
          color: widget.categoria.selected?Colors.blue[300]:Colors.black.withOpacity(0.3)
          //gradient:gradientComun(inmuebleTotal.getInmueble.getEstadoNegociacion),
      ),
      width: 30,
      height: 100,
      child: RotatedBox(
        quarterTurns: 1,
        child: Align(
          alignment: Alignment.center,
          child: Wrap(
            children: [Text(widget.categoria.nombre,
            textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                //fontWeight: widget.categoria.selected?FontWeight.bold:FontWeight.normal,
                color: widget.categoria.selected?Colors.black:Colors.white
              ),
            ),
            ]
          ),
        ),
      ),
    );
  }
}
Future dialogFiltrar(
  BuildContext context,
  String tipoSesion
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
            title: Center(child: Text("Reportar",style: TextStyle(fontSize: 20)),),
            children: [
              Container(
                width: 300,
                //height: 200,
                child: Column(
                  children:[
                    SizedBox(height:10),
                    tipoSesion=="Vender"?QuejaInmueble():ReportarInmueble()
                  ]
                ),
              )
            ],
          );
        }
      );
    }
  ); 
}
enum getTipoReporte{
  imagenes,
  datos,
  otro
}
class ReportarInmueble extends StatefulWidget {
  ReportarInmueble({Key? key}) : super(key: key);

  @override
  _ReportarInmuebleState createState() => _ReportarInmuebleState();
}

class _ReportarInmuebleState extends State<ReportarInmueble> {
  int tipo=0;
  String textoBoton="Enviar reporte (imágenes)";
  TextEditingController? controller;
  List<SolicitudAdministrador> solicitudes=[SolicitudAdministrador.vacio(),SolicitudAdministrador.vacio(),SolicitudAdministrador.vacio()];
  bool listar=true;
  InmuebleReportado inmuebleReportado=InmuebleReportado.vacio();
  UseCaseInmuebleReportado useCaseInmuebleReportado=UseCaseInmuebleReportado();
  @override
  void initState() {
    super.initState();
    controller=TextEditingController(text: "");
  }
  @override
  Widget build(BuildContext context) {
    final inmuebleInfo=Provider.of<InmuebleInfo>(context);
    final usuario=Provider.of<UsuariosInfo>(context);
    controller!.text=solicitudes[tipo].observaciones;
    if(listar){
      useCaseInmuebleReportado.obtenerReportesInmueble(usuario.getUsuario, inmuebleInfo.inmuebleTotal, false, false).then((value){
        for(int i=0;i<value.length;i++){
          if(value[i].tipoSolicitud=="Reporté imágenes"){
            solicitudes[0]=value[i];
          }else if(value[i].tipoSolicitud=="Reporté datos"){
            solicitudes[1]=value[i];
          }else{
            solicitudes[2]=value[i];
          }
        }
      }).whenComplete((){
        listar=false;
        setState(() {
          
        });
      });
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0,vertical: 5),
      child: Column(
        children: [
          CheckboxListTile(
            title: Text("Vendido en más de un lugar"),
            selectedTileColor: Colors.red,
            value: inmuebleReportado.vendidoMultiplesLugares, 
            onChanged: (value){
              inmuebleReportado.vendidoMultiplesLugares=value!;
              setState(() {
                
              });
            }
          ),
          Divider(),
          CheckboxListTile(
            title: Text("Contenido falso imágen"),
            value: inmuebleReportado.contenidoFalsoImagen, 
            onChanged: (value){
              inmuebleReportado.contenidoFalsoImagen=value!;
              setState(() {
                
              });
            }
          ),
          Divider(),
          CheckboxListTile(
            title: Text("Contenido falso texto"),
            value: inmuebleReportado.contenidoFalsoTexto, 
            onChanged: (value){
              inmuebleReportado.contenidoFalsoTexto=value!;
              setState(() {
                
              });
            }
          ),
          Divider(),
          CheckboxListTile(
            title: Text("Contenido inapropiado"),
            value: inmuebleReportado.contenidoInapropiado, 
            onChanged: (value){
              inmuebleReportado.contenidoInapropiado=value!;
              setState(() {
                
              });
            }
          ),
          Divider(),
          CheckboxListTile(
            title: Text("Otro"),
            value: inmuebleReportado.otro, 
            onChanged: (value){
              inmuebleReportado.otro=value!;
              setState(() {
                
              });
            }
          ),
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                TextFFBasico(
                  controller: controller!, 
                  labelText: "Detalles del reporte", 
                  onChanged: (x){
                    solicitudes[tipo].observaciones=x;
                  }
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: ()async{
                        inmuebleReportado.inmueble.inmueble.id=inmuebleInfo.inmuebleTotalCopia.inmueble.id;
                        inmuebleReportado.usuarioSolicitante.usuarioCopy(usuario.usuario);
                        inmuebleReportado.observacionesSolicitud=controller!.text;
                        bool respuesta=await useCaseInmuebleReportado.reportarInmueble(inmuebleReportado);
                        if(respuesta){
                           ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Se registró el reporte"));
                        }
                      }, 
                      child: Text(
                        "Enviar reporte"
                      )
                    ),
                    SizedBox(width:5),
                    OutlinedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      }, 
                      child: Text("Salir",
                        style: TextStyle(
                          color: Colors.red
                        ),
                      )
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
class QuejaInmueble extends StatefulWidget {
  QuejaInmueble({Key? key}) : super(key: key);

  @override
  _QuejaInmuebleState createState() => _QuejaInmuebleState();
}

class _QuejaInmuebleState extends State<QuejaInmueble> {
  int tipo=0;
  String textoBoton="Enviar reporte (imágenes)";
  TextEditingController? controller;
  List<SolicitudAdministrador> solicitudes=[SolicitudAdministrador.vacio(),SolicitudAdministrador.vacio(),SolicitudAdministrador.vacio()];
  bool listar=true;
  InmuebleQueja inmuebleQueja=InmuebleQueja.vacio();
  UseCaseInmuebleVenta useCaseInmuebleVenta=UseCaseInmuebleVenta();
  UseCaseInmuebleReportado useCaseInmuebleReportado=UseCaseInmuebleReportado();
  @override
  void initState() {
    super.initState();
    controller=TextEditingController(text: "");
  }
  @override
  Widget build(BuildContext context) {
    final inmuebleInfo=Provider.of<InmuebleInfo>(context);
    final usuario=Provider.of<UsuariosInfo>(context);
    controller!.text=solicitudes[tipo].observaciones;
    if(listar){
      useCaseInmuebleReportado.obtenerReportesInmueble(usuario.getUsuario, inmuebleInfo.inmuebleTotal, false, false).then((value){
        for(int i=0;i<value.length;i++){
          if(value[i].tipoSolicitud=="Reporté imágenes"){
            solicitudes[0]=value[i];
          }else if(value[i].tipoSolicitud=="Reporté datos"){
            solicitudes[1]=value[i];
          }else{
            solicitudes[2]=value[i];
          }
        }
      }).whenComplete((){
        listar=false;
        setState(() {
          
        });
      });
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0,vertical: 5),
      child: Column(
        children: [
          CheckboxListTile(
            title: Text("Sin respuesta mucho tiempo"),
            selectedTileColor: Colors.red,
            value: inmuebleQueja.sinRespuesta, 
            onChanged: (value){
              inmuebleQueja.sinRespuesta=value!;
              setState(() {
                
              });
            }
          ),
          Divider(),
          CheckboxListTile(
            title: Text("Rechazado sin justificación valida"),
            value: inmuebleQueja.rechazadoSinJustificacion,
            onChanged: (value){
              inmuebleQueja.rechazadoSinJustificacion=value!;
              setState(() {
                
              });
            }
          ),
          Divider(),
          CheckboxListTile(
            title: Text("Otro"),
            value: inmuebleQueja.otro, 
            onChanged: (value){
              inmuebleQueja.otro=value!;
              setState(() {
                
              });
            }
          ),
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                TextFFBasico(
                  controller: controller!, 
                  labelText: "Detalles del reporte", 
                  onChanged: (x){
                    solicitudes[tipo].observaciones=x;
                  }
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: ()async{
                        
                        inmuebleQueja.inmueble.inmueble.id=inmuebleInfo.inmuebleTotalCopia.inmueble.id;
                        inmuebleQueja.observacionesSolicitud=controller!.text;
                        Map<String,dynamic> respuesta=await  useCaseInmuebleVenta.registrarInmuebleQueja(inmuebleQueja);
                        if(respuesta["completed"]){
                           ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Se registró el reporte"));
                          
                        }
                      }, 
                      child: Text(
                        "Enviar reporte"
                      )
                    ),
                    SizedBox(width:5),
                    OutlinedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      }, 
                      child: Text("Salir",
                        style: TextStyle(
                          color: Colors.red
                        ),
                      )
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
class ZoomImagen extends StatefulWidget {
  ZoomImagen({Key? key}) : super(key: key);

  @override
  _ZoomImagenState createState() => _ZoomImagenState();
}

class _ZoomImagenState extends State<ZoomImagen> 
with SingleTickerProviderStateMixin{
  late TransformationController controller;
  late AnimationController animationController;
  Animation<Matrix4>? animation;
  OverlayEntry? entry;
  double scale=1;
  final double minScale=1;
  final double maxScale=4;
  @override
  void initState() {
    super.initState();
    controller=TransformationController();
    animationController=AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200)
    )..addListener(() {
      controller.value=animation!.value;
    })..addStatusListener((status) {
      if(status==AnimationStatus.completed){
        removeOverlay();
      }
    });
  }
  @override
  void dispose() {
    controller.dispose();
    animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: buildImage(),
    );
  }

  Widget buildImage() {
    return InteractiveViewer(
      transformationController: controller,
      clipBehavior: Clip.hardEdge,
      panEnabled: true,
      scaleEnabled: true,
      maxScale: maxScale,
      minScale: minScale,
      /*onInteractionEnd: (details){
        if(details.pointerCount!=1) return;
        resetAnimation();
      },
      onInteractionStart: (details){
        if(details.pointerCount<2) return;
        if(entry==null){
          showOverlay(context);
        }
        
      },
      onInteractionUpdate: (details){
        if(entry==null) return;
        this.scale=details.scale;
        entry!.markNeedsBuild();
      },*/
      onInteractionUpdate: (details){
        //print(details);
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            "https://firebasestorage.googleapis.com/v0/b/bd-inmobiliaria-v01.appspot.com/o/images%2Fdata%2Fuser%2F0%2Fcom.appinmobiliaria.inmobiliariaapp%2Fcache%2Fimage_picker779980728.jpg?alt=media&token=f77682da-8c28-4a5f-bac1-2884846801ac",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
  void showOverlay(BuildContext context){
    final renderBox=context.findRenderObject()! as RenderBox;
    final offset=renderBox.localToGlobal(Offset.zero);

    final size=MediaQuery.of(context).size;
    final double opacity=((scale-1)/(maxScale-1)).clamp(minScale,maxScale).toDouble();
    removeOverlay();
    entry=OverlayEntry(builder: (context){
      return Stack(
        children: <Widget>[
          Positioned.fill(
            child: Opacity(
              opacity: opacity,
              child: Container(color: Colors.black,)
            )
          ),
          Positioned(
            left: offset.dx,
            top: offset.dy,
            width: size.width/1.1,
            child: buildImage()
          ),
        ],
      );
    });
    final overlay=Overlay.of(context)!;
    overlay.insert(entry!);
  }
  void removeOverlay(){
    entry?.remove();
    entry=null;
  }
  void resetAnimation(){
    animation=Matrix4Tween(
      begin: controller.value,
      end: Matrix4.identity()
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.linear)
    );
    animationController.forward(from: 0);
  }
}
Future dialogZoomImagen(
  BuildContext context,
  String imagen
)async{
  double width;
  double height;
  if(MediaQuery.of(context).size.width<MediaQuery.of(context).size.height){
    width=MediaQuery.of(context).size.width-20;
    height=MediaQuery.of(context).size.width-20;
  }else{
    width=MediaQuery.of(context).size.height-20;
    height=MediaQuery.of(context).size.height-20;
  }
 return await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext ctx){
      return StatefulBuilder(
        builder: (BuildContext ctx,StateSetter setState){
          return SimpleDialog(
            insetPadding: EdgeInsets.all(10),
            contentPadding: EdgeInsets.all(0),
           //titlePadding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
            //title: Center(child: Text("Reportar inmueble",style: TextStyle(fontSize: 20)),),
            children: [
              Container(
                width: width,
                height: height,
                //height: MediaQuery.of(context).size.width/1.1,
                //height: 200,
                child: 
                Column(
                  children:[
                    Expanded(child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IntectativeViewerImage(imagen: imagen),
                      ],
                    )),
                  ]
                ),
              )
            ],
          );
        }
      );
    }
  ); 
}
class IntectativeViewerImage extends StatefulWidget {
  IntectativeViewerImage({Key? key,
    required this.imagen
  }) : super(key: key);
  final String imagen;
  @override
  _IntectativeViewerImageState createState() => _IntectativeViewerImageState();
}

class _IntectativeViewerImageState extends State<IntectativeViewerImage>
  with SingleTickerProviderStateMixin{

  late TransformationController controller;
  TapDownDetails? tapDownDetails;
  late AnimationController animationController;
  Animation<Matrix4>? animation;
  double width=0.0;
    double height=0.0;
  @override
  void initState() {
    super.initState();
    controller=TransformationController();
    animationController=AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300)
    )..addListener(() {
      controller.value=animation!.value;
    });
  }
  @override
  void dispose() {
    controller.dispose();
    animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    
    if(MediaQuery.of(context).size.width<MediaQuery.of(context).size.height){
      width=MediaQuery.of(context).size.width-20;
      height=MediaQuery.of(context).size.width;
    }else{
      width=MediaQuery.of(context).size.height;
      height=MediaQuery.of(context).size.height-20;
    }
    return GestureDetector(
      
      onDoubleTapDown: (TapDownDetails details){
        tapDownDetails=details;
      },
      onDoubleTap: (){
        final position=tapDownDetails!.localPosition;
        final double scale=5;
        final x= -position.dx*(scale-1);
        final y= -position.dy*(scale-1);
        final zoomed=Matrix4.identity()
          ..translate(x,y)
          ..scale(scale);
        final end=controller.value.isIdentity()?zoomed:Matrix4.identity();
        animation=Matrix4Tween(
          begin: controller.value,
          end: end
        ).animate(
          CurveTween(curve: Curves.easeOut).animate(animationController)
        );
        animationController.forward(from: 0);
      },
      child: Stack(
        children: [
          InteractiveViewer(
            //clipBehavior: Clip.none,
            
            transformationController: controller,
            panEnabled: true,
            scaleEnabled: true,
            child: Container(
              //aspectRatio:width/height,
              width: width,
              height: height,
              child:ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  width: width,
                  height: height,
                  imageUrl: widget.imagen,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            top:10,
            child: Container(
              margin: EdgeInsets.all(10),
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black45,
                
              ),
              child: IconButton(
                tooltip:"Guardar en teléfono",
                padding: EdgeInsets.zero,
                onPressed: ()async{
                  var status=await Permission.storage.request();
                  if(status.isGranted){
                    var response=await Dio().get(widget.imagen,options: Options(
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
                    print(result["filePath"]);
                  }
                },
                icon: Icon(Icons.download,color: Colors.white,)
              ),
            ),
          ),
        ],
      )
    );
  }
}