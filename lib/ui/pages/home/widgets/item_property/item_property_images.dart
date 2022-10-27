
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/domain/usecases/property/usecase_property_base.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/pages/home/widgets/item_property/label_property.dart';
import 'package:inmobiliariaapp/ui/pages/secondary/screen_view_property.dart';
import 'package:inmobiliariaapp/ui/provider/home/widget_status_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_widget_provider.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../../../domain/usecases/property/usecase_property.dart';
import '../../../../common/size_default.dart';
import 'icon_favorite.dart';
class ItemPropertyImages extends StatefulWidget {
  final PropertyTotal propertyTotal;
  final int index;
  ItemPropertyImages({Key? key,required this.propertyTotal,required this.index}) : super(key: key);
  @override
  _ItemPropertyImagesState createState() => _ItemPropertyImagesState();
}

class _ItemPropertyImagesState extends State<ItemPropertyImages> {
  double heightImagen=0;
  double width=0;
  //double movido=0;
  bool movido=false;
  double posicionInicial=0;
  Future<SharedPreferences> _prefs=SharedPreferences.getInstance();
  UseCaseProperty useCaseInmueble=UseCaseProperty();
  UseCasePropertyBase useCaseInmuebleBase=UseCasePropertyBase();

  pw.Document? pdf;
  Uint8List? archivoPdf;
  @override
  Widget build(BuildContext context) {
    final widgetStatusProvider=Provider.of<WidgetStatusProvider>(context);
    if(widgetStatusProvider.seeMap){
      heightImagen=150;
      width=250;
    }else{
        if(MediaQuery.of(context).size.height>MediaQuery.of(context).size.width){
          heightImagen=MediaQuery.of(context).size.height/4;
          width=MediaQuery.of(context).size.width;
        }else{
          width=MediaQuery.of(context).size.width*0.6;
          heightImagen=MediaQuery.of(context).size.height/2.2;
        }
    }
    
    return Stack(
      children: [
        Container(),
        _wImage(context),
        _wTop(context),
        _wBottom(context),
      if(widget.propertyTotal.property.negotiationStatus!="Sin negociar"&&widget.propertyTotal.property.negotiationStatus!="")
      Positioned(
        top: heightImagen/2-25,
        left: widget.propertyTotal.property.negotiationStatus=="Vendido"?
        MediaQuery.of(context).size.width/2-25:-10,
        child: Container(
          width: 50,
          height: 150,
          child: LabelProperty(propertyTotal: widget.propertyTotal,),
        ),
      )
      ],
    );
  }

  Positioned _wBottom(BuildContext context) {
    final userProvider=context.read<UserProvider>();
    return Positioned(
      bottom: 0,
      width: width,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20*SizeDefault.scaleWidth),
        color:Color.fromRGBO(50, 50, 50, 0.2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if(userProvider.sessionType=="Comprar")
            IconFavorite(
              propertyTotal: widget.propertyTotal,
            ),
            if(userProvider.sessionType=="Supervisar"||userProvider.sessionType=="Observar")
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15*SizeDefault.scaleWidth),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      TextStandard(
                        text: widget.propertyTotal.property.favoritesQuantity.toString(), 
                        fontSize: SizeDefault.fSizeStandard,
                        color: ColorsDefault.colorBackgroud,
                      ),
                      SizedBox(width:5*SizeDefault.scaleWidth),
                      Icon(Icons.favorite,size: 35*SizeDefault.scaleHeight,color: ColorsDefault.colorBackgroud,),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Positioned _wTop(BuildContext context) {
    final userProvider=context.read<UserProvider>();
    return Positioned(
      child: Container(
        width: width,
        color:Color.fromRGBO(50, 50, 50, 0.2),
        padding: EdgeInsets.symmetric(horizontal: 20*SizeDefault.scaleWidth),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _widgetIconosNavegacion(),
            if(userProvider.user.userType!="Gerente"
            &&userProvider.sessionType=="Comprar"
            )
            Row(
              children: [
                widget.propertyTotal.userPropertyFavorite.viewedDouble?Icon(Icons.done_all,color:ColorsDefault.colorBackgroud,size: 25*SizeDefault.scaleHeight)
                :
                (widget.propertyTotal.userPropertyFavorite.viewed?Icon(Icons.done,color: ColorsDefault.colorBackgroud,size: 25*SizeDefault.scaleHeight):Container()),
              ],
            ),
            if(userProvider.user.userType=="Gerente")
            Row(
              children: [
                TextStandard(
                  text: widget.propertyTotal.property.viewedQuantity.toString(),
                  fontSize: SizeDefault.fSizeStandard,
                  color: ColorsDefault.colorBackgroud,
                ),
                Icon(Icons.done,color: ColorsDefault.colorBackgroud,),
                TextStandard(
                  text: widget.propertyTotal.property.viewedDoubleQuantity.toString(),
                  fontSize: SizeDefault.fSizeStandard,
                  color: ColorsDefault.colorBackgroud,
                ),
                Icon(Icons.done_all,color: ColorsDefault.colorBackgroud,size: 25*SizeDefault.scaleHeight),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _wImage(BuildContext context) {
    final userProvider=context.read<UserProvider>();
    final propertiesProvider=context.read<PropertiesProvider>();
    final propertiesWidgetProvider=context.read<PropertiesWidgetProvider>();
    return Container(
      width: SizeDefault.swidth,
      height:SizeDefault.swidth*0.7,
      padding:EdgeInsets.zero,
      child: PageView.builder(
        pageSnapping: true,
        allowImplicitScrolling: false,
        scrollDirection: Axis.horizontal,
        onPageChanged: (currentPage){
          if(userProvider.sessionType=="Comprar"){
            if(currentPage>1&&!widget.propertyTotal.userPropertyFavorite.viewed){
              if(userProvider.user.id!=""){
                propertiesProvider.registerPropertyFavorite(context: context,prefs: _prefs, propertyTotal: widget.propertyTotal,viewed: true);
              }
            }
          }
        },
        itemCount: 3,
        itemBuilder: (context, index) {
          return InkWell(
            child: CachedNetworkImage(
              imageUrl: widget.propertyTotal.property.mapImages["principales"][index],
              width: width,
              height:heightImagen+80,
              fit: BoxFit.cover,
              fadeInCurve: Curves.bounceOut,
              fadeInDuration: Duration(milliseconds: 200),
                progressIndicatorBuilder: (context, url, downloadProgress) {
                  return Center(child: CircularProgressIndicator(value: downloadProgress.progress));
                },
              errorWidget: (context, url, error) {
                return Center(
                  child:Icon(
                    Icons.error,
                    color:ColorsDefault.colorTextError,
                    size: 40*SizeDefault.scaleHeight,
                  )
                );
              },
            ),
            onTap: ()async{
              if(userProvider.sessionType=="Comprar"){
                if(!widget.propertyTotal.userPropertyFavorite.viewedDouble){
                  propertiesProvider.registerPropertyFavorite(context: context,prefs: _prefs, propertyTotal: widget.propertyTotal,viewedDouble: true);
                }
              }
              propertiesProvider.addPropertiesStack(widget.propertyTotal,context:context);
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context)=>ScreenViewProperty()
                  //builder: (context)=>ScreenSpeedDial()
                )
              );
              propertiesProvider.removePropertiesStack(context:context);
              propertiesWidgetProvider.setFeaturesSelected(-1);
            }
          );
        },
      ),
    );
  }
  Widget _widgetIconosNavegacion(){
    return Container(
      height: 40*SizeDefault.scaleHeight,
      child: Row(
        children: [
            widget.propertyTotal.propertyOthers.video2DLink!=""? IconButton(
              onPressed: (){},
              padding: EdgeInsets.zero,
              splashRadius:10,
              tooltip: "Vídeo 2D",
              icon: Icon(Icons.video_collection,color:ColorsDefault.colorBackgroud,size: 25*SizeDefault.scaleHeight,)
            ):Container(),
            widget.propertyTotal.propertyOthers.tourVirtual360Link!=""? IconButton(
              onPressed: (){},
              padding: EdgeInsets.zero,
              splashRadius:10,
              tooltip: "Tour virtual 360",
              icon: Icon(Icons.web_sharp,color:ColorsDefault.colorBackgroud,size: 25*SizeDefault.scaleHeight,)
            ):Container(),
            widget.propertyTotal.propertyOthers.videoTour360Link!=""? IconButton(
              onPressed: (){},
              padding: EdgeInsets.zero,
              splashRadius:10,
              tooltip: "Vídeo tour 360",
              icon: Icon(Icons.video_label,color:ColorsDefault.colorBackgroud,size: 25*SizeDefault.scaleHeight,)
            ):Container(),
        ],
      ),
    );
  }
}
  