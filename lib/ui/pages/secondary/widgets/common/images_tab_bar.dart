
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/pages/secondary/widgets/report_complaint_property/dialog_report_complaint_property.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_widget_provider.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';
class ImagesTabBar extends StatefulWidget {
  ImagesTabBar({Key? key,required this.propertyTotal}) : super(key: key);
  final PropertyTotal propertyTotal;
  @override
  _ImagesTabBarState createState() => _ImagesTabBarState();
}

class _ImagesTabBarState extends State<ImagesTabBar> with TickerProviderStateMixin{
  double imagenHeight=0;
  double imagenWidth=0;
  bool isVertical=true;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final propertiesWidgetProvider=Provider.of<PropertiesWidgetProvider>(context);
    final _usuario=Provider.of<UserProvider>(context);
    if(MediaQuery.of(context).size.height>MediaQuery.of(context).size.width){
      isVertical=true;
      imagenWidth=MediaQuery.of(context).size.width;
      imagenHeight=(imagenWidth-10*SizeDefault.scaleWidth)*0.7;
    }else{
      isVertical=false;
      imagenHeight=MediaQuery.of(context).size.height*.75;
      imagenWidth=MediaQuery.of(context).size.width/1.9;
    }
    return AnimatedBuilder(
      animation: propertiesWidgetProvider, 
      builder: (_,__){
        return Row(
          children: [
            Container(
              width: imagenWidth,
              height: imagenHeight,
              child: Stack(
                children: [
                  _wImage(propertiesWidgetProvider),
                  _wTabSelectors(propertiesWidgetProvider),
                  _wComplaintReportedProperty(context, _usuario)
                ],
              ),
            ),
          ],
        );
      }
    );
  }

  PageView _wImage(PropertiesWidgetProvider propertiesWidgetProvider) {
    return PageView.builder(
      pageSnapping: true,
      allowImplicitScrolling: false,
      controller: propertiesWidgetProvider.pageController,
      onPageChanged: (currentPage){
        propertiesWidgetProvider.searchCategory(currentPage);
        //imagenesInmueble.currentPage=currentPage;
      },
      itemCount: propertiesWidgetProvider.items.length,
      itemBuilder: (context, index) {
        final imagen=propertiesWidgetProvider.items[index].image;
        return InkWell(
          onTap: ()async{
            await dialogZoomImagen(context, imagen);
          },
          child: Card(
            elevation: 10,
            margin: EdgeInsets.only(top: 0,bottom: 0,left: 5*SizeDefault.scaleWidth,right: 5*SizeDefault.scaleWidth),
            child: Container(
              /*height: (imagenWidth-10)*0.7,
              width: imagenWidth-10,*/
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
    );
  }

  Positioned _wComplaintReportedProperty(BuildContext context, UserProvider _usuario) {
    return Positioned(
      right: 0,
      child: InkWell(
        onTap: ()async{
          await dialogReportComplaintProperty(context,_usuario.sessionType);
        },
        child: Container(
          margin: EdgeInsets.all(10*SizeDefault.scaleWidth),
          decoration: BoxDecoration(
            color: ColorsDefault.colorTabItemTransparent,
            borderRadius: BorderRadius.circular(10)
          ),
          width: 40*SizeDefault.scaleWidth,
          height: 40*SizeDefault.scaleWidth,
          child: Icon(Icons.more_vert,size: 30*SizeDefault.scaleWidth,color: ColorsDefault.colorBackgroud),
        ),
      ),
    );
  }

  Container _wTabSelectors(PropertiesWidgetProvider propertiesWidgetProvider) {
    return Container(
      padding: EdgeInsets.only(left: 10*SizeDefault.scaleWidth,),
      width: 40*SizeDefault.scaleWidth,
      height: imagenHeight,
      color: Colors.black.withOpacity(0.2),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: propertiesWidgetProvider.scrollControllerCategories,
              itemCount: propertiesWidgetProvider.tabs.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: TabBarCategories(
                    category: propertiesWidgetProvider.tabs[index]
                  ),
                  onTap: (){
                    propertiesWidgetProvider.onCategorySelected(index);
                  },
                );
              },
            )
          )
        ],
      ),
    );
  }
}
class TabBarCategories extends StatefulWidget {
  TabBarCategories({Key? key,required this.category}) : super(key: key);
  final  ImagesTabCategory category;
  @override
  _TabBarCategoriesState createState() => _TabBarCategoriesState();
}

class _TabBarCategoriesState extends State<TabBarCategories> {
  
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
        color: widget.category.selected?ColorsDefault.colorPrimary:ColorsDefault.colorTabItemTransparent
          //gradient:gradientComun(inmuebleTotal.getInmueble.getEstadoNegociacion),
      ),
      width: 30*SizeDefault.scaleWidth,
      height: 120*SizeDefault.scaleWidth,
      child: RotatedBox(
        quarterTurns: 1,
        child: Align(
          alignment: Alignment.center,
          child: Wrap(
            children: [
              TextStandard(
                text: widget.category.name, fontSize: 11*SizeDefault.scaleHeight,
                color: widget.category.selected?ColorsDefault.colorText:ColorsDefault.colorBackgroud,
                textAlign: TextAlign.center,
              )
            ]
          ),
        ),
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