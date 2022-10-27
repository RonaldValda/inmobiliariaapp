import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' as iconc;
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/pages/home/widgets/home/drop_down_contract_type.dart';
import 'package:inmobiliariaapp/ui/pages/home/widgets/home/drop_down_price.dart';
import 'package:inmobiliariaapp/ui/pages/home/widgets/home/drop_down_property_type.dart';
import 'package:inmobiliariaapp/ui/provider/home/widget_status_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_others_provider.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_properties_searcheds.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_provider.dart';
import 'package:provider/provider.dart';

import '../dialog_registro_inmueble_buscado.dart';
import '../filters/filters_secondary_main.dart';
import '../filters/filters_sort.dart';
class AppBarPzd extends StatefulWidget with PreferredSizeWidget{
  AppBarPzd({Key? key}) : super(key: key);

  @override
  _AppBarPzdState createState() => _AppBarPzdState();

  @override
  Size get preferredSize =>  Size.fromHeight(SizeDefault.preferredSizeAppBar);
}

class _AppBarPzdState extends State<AppBarPzd> {
  bool ordenarActivado=false;
  @override
  Widget build(BuildContext context) {
    final widgetStatusProvider=Provider.of<WidgetStatusProvider>(context);
    final filterOthersProvider=context.watch<FilterOthersProvider>();
    final propertiesSearcheds=context.watch<UserPropertiesSearchedsProvider>().propertiesSearcheds;
    final userProvider=context.watch<UserProvider>();
    return DefaultTabController(
      length: 1,
      
      child: AppBar(
        backgroundColor: ColorsDefault.colorBackgroud,
        elevation: 0,
        leadingWidth:  SizeDefault.sizeIconAppBar*2,
        titleSpacing: 0,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              //width:SizeDefault.sizeIconAppBar*1.5,
              //height: SizeDefault.sizeIconAppBar*1.5,
              child: InkWell(
                radius: 100,
                borderRadius: BorderRadius.circular(50),
                child: Icon(
                  Icons.menu_rounded,
                  color: ColorsDefault.colorIcon,
                  size: SizeDefault.sizeIconAppBar*1.5,
                ),
                onTap: (){
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          ],
        ),
        title: Container(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                DropDownContractType(),
                //FilterContractType(),
                SizedBox(
                  width:5*SizeDefault.scaleWidth
                ),
                DropDownPropertyType(),
                SizedBox(
                  width:5*SizeDefault.scaleWidth
                ),
                DropDownPrice()
              ],
            ),
          ),
        ),
        
        actions: [
          _wFilter(),
          if(!widgetStatusProvider.seeMap)
          Row(
            children: [
              if(ordenarActivado)
              Row(
                children: [
                  Container(
                    width: 30,
                    child: PopupMenuButton(
                      tooltip: "Ordernar",
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)
                      ),
                      offset: const Offset(0, 40),
                      color: ColorsDefault.colorBackgroud,
                      enableFeedback: false,
                      icon:Container(
                        child:filterOthersProvider.mapFilterOrder["order"]==GetOrder.asc.index
                      ?Image(
                        image: AssetImage("assets/icons/icon-sort-ascending.png"),
                        width: SizeDefault.sizeIconAppBarOther,
                        height: SizeDefault.sizeIconAppBarOther
                      ):
                      Image(
                        image: AssetImage(
                          "assets/icons/icon-sort-descending.png"),
                          width: SizeDefault.sizeIconAppBarOther,
                          height: SizeDefault.sizeIconAppBarOther
                        ),
                      ),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context){
                        return [
                          PopupMenuItem<int>(
                            padding: EdgeInsets.all(10*SizeDefault.scaleWidth),
                            value: 0, 
                            child: FiltersSort(),
                            //child: FiltrosOrdenacion()
                          ),
                        ];
                      }
                    ),
                  ),
                  if(userProvider.getSubscribed()=="Suscrito")
                  Container(
                    width: 30,
                    child: PopupMenuButton(
                      tooltip: "Inmuebles buscados",
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)
                      ),
                      offset: Offset(0, SizeDefault.preferredSizeAppBar),
                      color: ColorsDefault.colorBackgroud,
                      enableFeedback: false,
                      icon:IconoNotificacion(numeroNotificacion: propertiesSearcheds.length),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context){
                        return [
                          PopupMenuItem<int>(
                            padding: EdgeInsets.zero,
                            value: 0, 
                            child: PropertiesSearcheds(),
                            //child: FiltrosOrdenacion()
                          ),
                        ];
                      }
                    ),
                  ),
                ],
              ),
              IconButton(
                padding: EdgeInsets.zero,
                splashRadius: 20,
                onPressed: (){
                  setState(() {
                    ordenarActivado=!ordenarActivado;
                  });
                }, 
                icon: Icon(
                  Icons.more_vert,
                  size: SizeDefault.sizeIconAppBar,
                  color: ordenarActivado?ColorsDefault.colorPrimary:ColorsDefault.colorIcon,
                )
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _wFilter() {
    return Container(
      width: SizeDefault.sizeIconAppBarOther,
      child: PopupMenuButton(
        tooltip: "Filtrar",
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7)
        ),
        offset: Offset(0, SizeDefault.preferredSizeAppBar),
        color: Colors.white,
        enableFeedback: false,
        iconSize: SizeDefault.sizeIconAppBarOther,
        splashRadius: 20,
        icon: iconc.FaIcon(
          iconc.FontAwesomeIcons.filter,
          color: ColorsDefault.colorIcon,
          size: SizeDefault.sizeIconAppBarOther
        ),
        padding: EdgeInsets.zero,
        itemBuilder: (context){
          return [
            PopupMenuItem<int>(
              padding: EdgeInsets.all(10*SizeDefault.scaleHeight),
              value: 0, 
              child: FiltersSecondaryMain()
            ),
          ];
        }
      ),
    );
  }
}

class IconoNotificacion extends StatefulWidget {
  IconoNotificacion({Key? key,required this.numeroNotificacion}) : super(key: key);
  final int numeroNotificacion;
  @override
  _IconoNotificacionState createState() => _IconoNotificacionState();
}

class _IconoNotificacionState extends State<IconoNotificacion> {
  String notificacionTexto="";
  @override
  void initState() {
    super.initState();
    //numeroNotificacion=widget.inmuebles.length.toString();
  }
  @override
  Widget build(BuildContext context) {
    if(widget.numeroNotificacion==0){
      notificacionTexto="";
    }else if(widget.numeroNotificacion>9){
      notificacionTexto="9+";
    }else{
      notificacionTexto=widget.numeroNotificacion.toString();
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        Center(child: iconc.FaIcon(iconc.FontAwesomeIcons.solidFolderOpen,color: ColorsDefault.colorIcon,size: SizeDefault.sizeIconAppBarOther,)),
        notificacionTexto!=""? Positioned(
          right: 0,
          top: 5*SizeDefault.scaleHeight,
          child: Container(
            width: 25*SizeDefault.scaleHeight,
            height: 25*SizeDefault.scaleHeight,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffc32c37),
                border: Border.all(color: Colors.white, width: 1)),
            child: Center(
              child: TextStandard(
                text: notificacionTexto,
                fontSize: 12*SizeDefault.scaleHeight,
                color: ColorsDefault.colorBackgroud,
              )
            ),
          ),
        ):Container(
          width: 30,
          height: 30,
        ),
      ],
    );
  }
}