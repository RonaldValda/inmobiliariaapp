
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/widget_status_provider.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_user_provider.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_provider.dart';
import 'package:provider/provider.dart';

import 'container_properties.dart';

class BodyMain extends StatefulWidget {
  const BodyMain({Key? key}):super(key: key);

  @override
  _BodyMainState createState() => _BodyMainState();
}

class _BodyMainState extends State<BodyMain> with SingleTickerProviderStateMixin{
  
  bool cargar=true;
  bool favoritos=false;
  AnimationController? _controller;
  Animation? _animation;
  bool toggle=false;
  double pi=3.141516;
  Color? colorBotonActivado=Colors.orange[900];
  Color? colorBotonDesactivado=Colors.deepOrangeAccent;
  @override
  void initState(){
    super.initState();
    _controller=AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
      reverseDuration: Duration(milliseconds: 275)
    );
    _animation=CurvedAnimation(
      parent: _controller!, 
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn
    );
    _controller!.addListener(() { 
      setState(() {
        
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<PropertiesProvider>().init(context: context).then((value) {
        setState(() {
          
        });
      });
    });
  }
  Alignment alignmentMapaVisible=Alignment(Alignment.bottomLeft.x+0.1, Alignment.bottomLeft.y-0.07);
  Alignment alignmentMapaNoVisible=Alignment(Alignment.bottomLeft.x+0.1, Alignment.bottomLeft.y+0.3);
  Alignment alignmentFavoritoVisible=Alignment(Alignment.bottomRight.x-0.1, Alignment.bottomRight.y-0.07);
  Alignment alignmentFavoritoNoVisible=Alignment(Alignment.bottomRight.x-0.1, Alignment.bottomRight.y+0.3);
  double size1=50.0;
  double size2=50.0;
  double size3=60.0;

  @override
  Widget build(BuildContext context) {
    final filterUserProvider=context.watch<FilterUserProvider>();
    final userProvider=context.watch<UserProvider>();
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    final widgetStatusProvider=Provider.of<WidgetStatusProvider>(context);
    int iVistos=-1;
    int iDobleVistos=-1;
    if(MediaQuery.of(context).size.height<MediaQuery.of(context).size.width){
      alignmentMapaVisible=Alignment(Alignment.bottomLeft.x+0.1, Alignment.bottomLeft.y-0.07);
      alignmentMapaNoVisible=Alignment(Alignment.bottomLeft.x+0.1, Alignment.bottomLeft.y+0.55);
      alignmentFavoritoVisible=Alignment(Alignment.bottomRight.x-0.1, Alignment.bottomRight.y-0.07);
      alignmentFavoritoNoVisible=Alignment(Alignment.bottomRight.x-0.1, Alignment.bottomRight.y+0.55);
    }else{
      alignmentMapaVisible=Alignment(Alignment.bottomLeft.x+0.1, Alignment.bottomLeft.y-0.07);
      alignmentMapaNoVisible=Alignment(Alignment.bottomLeft.x+0.1, Alignment.bottomLeft.y+0.3);
      alignmentFavoritoVisible=Alignment(Alignment.bottomRight.x-0.1, Alignment.bottomRight.y-0.07);
      alignmentFavoritoNoVisible=Alignment(Alignment.bottomRight.x-0.1, Alignment.bottomRight.y+0.3);
    }
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: ColorsDefault.colorBackgroud,
      //color: Colors.blue,
       child: Column(
         children:<Widget>[
            Expanded(
              child: Stack(
              children: [
                ContainerProperties(),
                _wButtonIconMap(widgetStatusProvider, _inmueblesFiltrado),
                userProvider.user.id!=""? userProvider.sessionType=="Comprar"?
                _wButtonFavorite(widgetStatusProvider, filterUserProvider, _inmueblesFiltrado):Container():Container(),
                if(widgetStatusProvider.seeMap&&userProvider.user.userType=="Gerente")
                _wIndicators(_inmueblesFiltrado, iVistos, iDobleVistos),
              ],
            ),
            ),
         ]
       )
    );
  }

  Widget _wIndicators(ListadoInmueblesFiltrado _inmueblesFiltrado, int iVistos, int iDobleVistos) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Card(
        elevation: 10,
        child: Container(
          width: 170,
          height: 130,
          color: Colors.white,
          child:Column(
            children: [
              Text("Indicadores"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Text("Vistos"),
                          Column(
                            children: _inmueblesFiltrado.limitesVistos.map((e){
                              iVistos++;
                              if(iVistos==0){
                                return Row(
                                  children: [
                                    Icon(Icons.circle,size:10,color:_inmueblesFiltrado.colores[iVistos]),
                                    SizedBox(width: 2,),
                                    Text("De 0 a ${_inmueblesFiltrado.limitesVistos[iVistos]}")    
                                  ],
                                );
                              }
                              return Row(
                                children: [
                                  Icon(Icons.circle,size:10,color:_inmueblesFiltrado.colores[iVistos]),
                                  SizedBox(width: 2,),
                                  Text("De ${_inmueblesFiltrado.limitesVistos[iVistos-1]+1} a ${_inmueblesFiltrado.limitesVistos[iVistos]}")    
                                ],
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Text("Revisados"),
                          Column(
                            children: _inmueblesFiltrado.limitesDobleVistos.map((e){
                              iDobleVistos++;
                              if(iDobleVistos==0){
                                return Row(
                                  children: [
                                    Icon(Icons.circle,size:10,color:_inmueblesFiltrado.colores[iDobleVistos]),
                                    SizedBox(width: 2,),
                                    Text("De 0 a ${_inmueblesFiltrado.limitesDobleVistos[iDobleVistos]}")    
                                  ],
                                );
                              }
                              return Row(
                                children: [
                                  Icon(Icons.circle,size:10,color:_inmueblesFiltrado.colores[iDobleVistos]),
                                  SizedBox(width: 2,),
                                  Text("De ${_inmueblesFiltrado.limitesDobleVistos[iDobleVistos-1]+1} a ${_inmueblesFiltrado.limitesDobleVistos[iDobleVistos]}")    
                                ],
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ),
      ),
    );
  }

  AnimatedAlign _wButtonFavorite(WidgetStatusProvider widgetStatusProvider, FilterUserProvider filterUserProvider, ListadoInmueblesFiltrado _inmueblesFiltrado) {
    return AnimatedAlign(
      duration: widgetStatusProvider.buttonsBeforeVisible?Duration(milliseconds: 700):Duration(milliseconds:700),
      alignment: widgetStatusProvider.buttonsBeforeVisible?alignmentFavoritoVisible:alignmentFavoritoNoVisible,
      curve: widgetStatusProvider.buttonsBeforeVisible?Curves.easeIn:Curves.easeOut,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        curve: widgetStatusProvider.buttonsBeforeVisible?Curves.easeIn:Curves.elasticOut,
        height: size3,
        width: size3,
        decoration: BoxDecoration(
          color: ColorsDefault.colorFavorite,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            width: 1*SizeDefault.scaleHeight,
            color: ColorsDefault.colorText.withOpacity(0.1),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              offset: Offset(0, 4),
              color: ColorsDefault.colorShadowCardImage
            )
          ]
        ),
        child: IconButton(
          icon: filterUserProvider.mapFilter["favorites"]?
          Icon(
            Icons.favorite,
            size: 40*SizeDefault.scaleHeight,
            color: ColorsDefault.colorBackgroud,
          ):
          Icon(
            Icons.favorite_border,
            size: 40*SizeDefault.scaleHeight,
            color: ColorsDefault.colorBackgroud,
          ),
          color: Colors.white,
          onPressed: (){
            _inmueblesFiltrado.setFiltrar(true);
            _inmueblesFiltrado.setConsultarBD(false);
            filterUserProvider.setMapFilterItem("favorites", !filterUserProvider.mapFilter["favorites"],context: context);
          },
        ),
      ),
    );
  }

  Widget _wButtonIconMap(WidgetStatusProvider widgetStatusProvider, ListadoInmueblesFiltrado _inmueblesFiltrado) {
    return AnimatedAlign(
      duration: widgetStatusProvider.buttonsBeforeVisible?Duration(milliseconds: 700):Duration(milliseconds:700),
      alignment: widgetStatusProvider.buttonsBeforeVisible?alignmentMapaVisible:alignmentMapaNoVisible,
      curve: widgetStatusProvider.buttonsBeforeVisible?Curves.easeIn:Curves.easeOut,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        curve: widgetStatusProvider.buttonsBeforeVisible?Curves.easeIn:Curves.elasticOut,
        height: size3,
        width: size3,
        decoration: BoxDecoration(
          color: ColorsDefault.colorPrimary,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            width: 1*SizeDefault.scaleHeight,
            color: ColorsDefault.colorText.withOpacity(0.1),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              offset: Offset(0, 4),
              color: ColorsDefault.colorShadowCardImage
            )
          ]
        ),
        child: IconButton(
          icon: widgetStatusProvider.seeMap
          ?Icon(
            Icons.list,
            size: 40*SizeDefault.scaleHeight,
            color: ColorsDefault.colorBackgroud,
          )
          :Icon(
            Icons.public,
            size: 40*SizeDefault.scaleHeight,
            color: ColorsDefault.colorBackgroud,
          ),

          onPressed: (){
            _inmueblesFiltrado.setFiltrar(false);
              _inmueblesFiltrado.setConsultarBD(false);
            widgetStatusProvider.setSeeMap(!widgetStatusProvider.seeMap);
          },
        ),
      ),
    );
  }
}
