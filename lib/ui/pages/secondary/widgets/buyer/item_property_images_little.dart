import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/domain/usecases/property/usecase_property_base.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/pages/home/widgets/item_property/icon_favorite.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_widget_provider.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemPropertyImagesLittle extends StatefulWidget {
  ItemPropertyImagesLittle({Key? key,required this.propertyTotal}) : super(key: key);
  final PropertyTotal propertyTotal;
  @override
  _ItemPropertyImagesLittleState createState() => _ItemPropertyImagesLittleState();
}

class _ItemPropertyImagesLittleState extends State<ItemPropertyImagesLittle> {
  Future<SharedPreferences> _prefs=SharedPreferences.getInstance();
  UseCasePropertyBase useCaseInmuebleBase=UseCasePropertyBase();
  double _width=SizeDefault.swidth/2.1;
  @override
  Widget build(BuildContext context) {
    final userProvider=context.watch<UserProvider>();
    final propertiesWidgetProvider=Provider.of<PropertiesWidgetProvider>(context);
    final propertiesProvider=context.read<PropertiesProvider>();
    return Stack(
      children:[
        InkWell(
          child: CachedNetworkImage(
            imageUrl: widget.propertyTotal.property.mapImages["principales"][0],
            width: _width,
            height: _width*0.7,
            //filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
            fadeInCurve: Curves.bounceOut,
            fadeInDuration: Duration(milliseconds: 200),
            placeholder: (context, url) {
              return Center(child: CircularProgressIndicator());
            },
            errorWidget: (context, url, error) {
              return Center(
                child:Icon(Icons.error,color:Colors.red)
              );
            },
          ),
          onTap: ()async{
            if(!widget.propertyTotal.userPropertyFavorite.viewed){
              if(userProvider.user.id!=""){
              propertiesProvider.registerPropertyFavorite(context: context,prefs: _prefs, propertyTotal: widget.propertyTotal,viewedDouble: true);
                
              }
            }
            propertiesProvider.addPropertiesStack(widget.propertyTotal,context:context);
            propertiesWidgetProvider.moveToStartController();
            propertiesWidgetProvider.setFeaturesSelected(-1);
          },
        ),
        _wTop(userProvider),
            Positioned(
              bottom: 0,
              width: _width,
              child: Container(
                padding: EdgeInsets.only(right: 10),
                color:Color.fromRGBO(50, 50, 50, 0.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                userProvider.sessionType=="Comprar"?
                IconFavorite(
                  propertyTotal: widget.propertyTotal,)
                :
                userProvider.sessionType=="Supervisar"?
                Container(
                    color:Color.fromRGBO(50, 50, 50, 0.2),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width:20),
                        SizedBox(width:MediaQuery.of(context).size.width/12),
                        Row(
                          children: [
                            Text(widget.propertyTotal.property.favoritesQuantity.toString(),
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                            Icon(Icons.favorite,size: 30,color: Colors.white,),
                          ],
                        ),
                      ],
                    ),
                  )
                :Container(height: 50,),
                  ],
                ),
              ),
            ),
      ]
    );
  }

  Positioned _wTop(UserProvider userProvider) {
    return Positioned(
      child: Container(
        color: Color.fromRGBO(0, 0, 0, .2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              //width: 200,
              height: 25*SizeDefault.scaleHeight,
              child: Row(
                children: [
                    widget.propertyTotal.propertyOthers.video2DLink!=""? 
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5*SizeDefault.scaleWidth),
                      child: IconButton(
                        onPressed: (){},
                        padding: EdgeInsets.zero,
                        splashRadius:10,
                        tooltip: "Vídeo 2D",
                        constraints: BoxConstraints(
                          maxWidth: 20*SizeDefault.scaleHeight,
                          maxHeight: 20*SizeDefault.scaleHeight,
                        ),
                        icon: Icon(Icons.video_collection,color:ColorsDefault.colorBackgroud,size: 20*SizeDefault.scaleHeight,)
                      ),
                    ):Container(),
                    widget.propertyTotal.propertyOthers.tourVirtual360Link!=""
                    ?Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5*SizeDefault.scaleWidth),
                      child: IconButton(
                        onPressed: (){},
                        padding: EdgeInsets.zero,
                        splashRadius:10,
                        tooltip: "Tour virtual 360",
                        constraints: BoxConstraints(
                          maxWidth: 20*SizeDefault.scaleHeight,
                          maxHeight: 20*SizeDefault.scaleHeight,
                        ),
                        icon: Icon(Icons.web_sharp,color:ColorsDefault.colorBackgroud,size: 20*SizeDefault.scaleHeight,)
                      ),
                    ):Container(),
                    widget.propertyTotal.propertyOthers.videoTour360Link!=""
                    ?Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5*SizeDefault.scaleWidth),
                      child: IconButton(
                        onPressed: (){},
                        padding: EdgeInsets.zero,
                        splashRadius:10,
                        tooltip: "Vídeo tour 360",
                        constraints: BoxConstraints(
                          maxWidth: 20*SizeDefault.scaleHeight,
                          maxHeight: 20*SizeDefault.scaleHeight,
                        ),
                        icon: Icon(Icons.video_label,color:ColorsDefault.colorBackgroud,size: 20*SizeDefault.scaleHeight,)
                      ),
                    ):Container(),
                ],
              ),
            ),
            userProvider.sessionType=="Comprar"?Row(
            children: [
              widget.propertyTotal.userPropertyFavorite.viewedDouble
              ?Icon(Icons.done_all,color:ColorsDefault.colorBackgroud,size: 20*SizeDefault.scaleHeight,)
              :(widget.propertyTotal.userPropertyFavorite.viewed
              ?Icon(Icons.done,color:ColorsDefault.colorBackgroud,size: 20*SizeDefault.scaleHeight,)
              :Container()),
              SizedBox(width:5*SizeDefault.scaleWidth)
            ],
          ):userProvider.sessionType=="Supervisar"?Row(
            children: [
              Text(widget.propertyTotal.property.viewedQuantity.toString(),
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              Icon(Icons.done,color: Colors.white,),
              Text(widget.propertyTotal.property.viewedDoubleQuantity.toString(),
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              Icon(Icons.done_all,color: ColorsDefault.colorBackgroud,)
            ],
          ):
          Container(),
          ],
        ),
      ),
    );
  }
}