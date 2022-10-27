import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/pages/home/widgets/item_property/drop_down_filters_direct.dart';
import 'package:inmobiliariaapp/ui/provider/home/widget_status_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_general_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_internal_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_main_provider.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' as iconc;
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

import '../dialog_property_note.dart';
import '../../../utils/share_property_pdf.dart';
class ItemPropertyFoot extends StatefulWidget {
  final PropertyTotal propertyTotal;
  final int index;
  ItemPropertyFoot({Key? key,required this.propertyTotal,required this.index}) : super(key: key);

  @override
  _ItemPropertyFootState createState() => _ItemPropertyFootState();
}

class _ItemPropertyFootState extends State<ItemPropertyFoot> {
  double _fontSizePrice=24*SizeDefault.scaleHeight;
  double _fontSizePriceLowered=17*SizeDefault.scaleHeight;
  double _fontSizeSecond=11*SizeDefault.scaleHeight;
  double _fontSizeThird=10*SizeDefault.scaleHeight;
  pw.Document? pdf;
  Uint8List? archivoPdf;
  @override
  Widget build(BuildContext context) {
    final widgetStatusProvider=Provider.of<WidgetStatusProvider>(context);
    final filterGeneralProvider=context.watch<FilterGeneralProvider>();
    final filterInternalProvider=context.watch<FilterInternalProvider>();
    final filterMainProvider=context.watch<FilterMainProvider>();
    return Container(
      //color: Colors.red,
      padding: EdgeInsets.symmetric(horizontal: 15*SizeDefault.scaleWidth,vertical: 7*SizeDefault.scaleWidth,),
       child: Row(
         //crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment:MainAxisAlignment.spaceBetween,
         children: [
          Expanded(
            //width: SizeDefault.swidth*0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: 
                  _wPrice()
                ),
              widgetStatusProvider.seeMap
              ? _wSecondIcon(filterInternalProvider, filterGeneralProvider)
              : _wSecondText(context, filterInternalProvider),
              _wUbication(context, filterMainProvider),
              ],
            ),
          ),
          Column(
            children: [
              _wButtonNote(context),
              SizedBox(height: 10*SizeDefault.scaleHeight,),
              _wButtonShare(),
            ],
          ),
         ],
       )
    );
  }

  Container _wUbication(BuildContext context,FilterMainProvider filterMainProvider) {
    final property=widget.propertyTotal.property;
    return Container(
      width: MediaQuery.of(context).size.width/1.1,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(top: 3*SizeDefault.scaleHeight,bottom: 3*SizeDefault.scaleHeight),
            alignment:Alignment.center,
            child: TextStandard(
              text:"${property.address} |",
              fontSize: _fontSizeThird,
            ),
          ),
          DropDownFiltersDirect(
            text: "${property.zoneName}", 
            textQuery: "Filtrar por zonas", 
            onTap: (){
              filterMainProvider.setMapFilterItem("zone", property.zoneName,context:context);
            }, 
            fontSize: _fontSizeThird,
            fontWeight: FontWeight.w400,
          ),
          Container(
            padding: EdgeInsets.only(top: 3*SizeDefault.scaleHeight,bottom: 3*SizeDefault.scaleHeight),
            alignment:Alignment.center,
            child: TextStandard(
              text:"| ${property.city}",
              fontSize: _fontSizeThird,
            ),
          ),
        ],
      ),
    );
  }

  Widget _wSecondText(BuildContext context, FilterInternalProvider filterInternalProvider) {
    final property=widget.propertyTotal.property;
    final propertyInternal=widget.propertyTotal.propertyInternal;
    return Align(
      alignment: Alignment.topLeft,
      child: Row(
        children: [
          DropDownFiltersDirect(
            text: "${propertyInternal.bedroomsNumber} Dormitorios",
            textQuery: "Filtrar por dormitorios", 
            onTap: (){
              filterInternalProvider.setMapFilterItem("bedrooms_number", propertyInternal.bedroomsNumber,context: context);
            }, 
            fontSize: _fontSizeSecond,
            fontWeight: FontWeight.w600,
          ),
          TextStandard(
            text:" | ${(property.price/property.landSurface).floor()} DPM",
            fontSize: _fontSizeSecond,
            fontWeight: FontWeight.w600,
          ),
          DropDownFiltersDirect(
            text: " | ${property.landSurface.toString()}m2 terreno",
            textQuery: "Filtrar por superficie de terreno", 
            onTap: (){
              context.read<FilterGeneralProvider>().setMapFilterItemRange("land_surface", property.landSurface,context: context);
            }, 
            fontSize: _fontSizeSecond,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

  Widget _wSecondIcon( FilterInternalProvider filterInternalProvider, FilterGeneralProvider filterGeneralProvider) {
    final property=widget.propertyTotal.property;
    final propertyInternal=widget.propertyTotal.propertyInternal;
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          DropDownFiltersDirect(
            text: "",
            textQuery: "Filtrar por dormitorios", 
            onTap: (){
              filterInternalProvider.setMapFilterItem("bedrooms_number", widget.propertyTotal.propertyInternal.bedroomsNumber,context: context);
            }, 
            fontSize: _fontSizeSecond,
            fontWeight: FontWeight.w600,
            widget: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextStandard(
                  text:"${propertyInternal.bedroomsNumber.toString()} ",
                  fontSize: _fontSizeSecond,
                  fontWeight: FontWeight.w600,
                ),
                iconc.FaIcon(iconc.FontAwesomeIcons.bed,size: 20*SizeDefault.scaleHeight),
              ],
            ),
          ),
          Tooltip(
            showDuration: Duration(seconds: 1),
            waitDuration: Duration(milliseconds: 10),
            message: "Dólares por metro cuadrado",
            child: TextStandard(
              text:" | ${(widget.propertyTotal.property.price/widget.propertyTotal.property.landSurface).floor()} DPM",
              fontSize: _fontSizeSecond,
              fontWeight: FontWeight.w600,
            ),
          ),
          DropDownFiltersDirect(
            text: " | ${property.landSurface.toString()}m2 terreno",
            textQuery: "Filtrar por superficie de terreno", 
            onTap: (){
              context.read<FilterGeneralProvider>().setMapFilterItemRange("land_surface", property.landSurface,context: context);
            }, 
            fontSize: _fontSizeSecond,
            fontWeight: FontWeight.w600,
            widget: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextStandard(
                  text:" | ${property.landSurface.toString()}m2 ",
                  fontSize: _fontSizeSecond,
                  fontWeight: FontWeight.w600,
                ),
                iconc.FaIcon(iconc.FontAwesomeIcons.vectorSquare,size: 20*SizeDefault.scaleHeight),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _wButtonNote(BuildContext context)  {
    final user=context.read<UserProvider>().user;
    return Container(
      width: 30*SizeDefault.scaleHeight,
      height: 30*SizeDefault.scaleHeight,
      alignment: Alignment.center,
      child: IconButton(
        splashRadius: 20*SizeDefault.scaleHeight,
        padding: EdgeInsets.zero,
        tooltip: "Nota",
        onPressed: ()async{
          await dialogPropertyNote(context, widget.propertyTotal,user);
        }, 
        icon: Icon(
          Icons.note_alt_outlined,
          size: SizeDefault.sizeIconButton,
          color:ColorsDefault.colorIcon
        )
      ),
    );
  }

  Widget _wButtonShare() {
    return Container(
      width: 30*SizeDefault.scaleHeight,
      height: 30*SizeDefault.scaleHeight,
      child: IconButton(
        splashRadius: 20*SizeDefault.scaleHeight,
        padding: EdgeInsets.zero,
        tooltip: "Compartir",
        onPressed: ()async{
          var status=await Permission.storage.request();
          if(status.isGranted){
            Map<String,dynamic> mapImagenesFile={};
            List imagenesCategoria=[];
            for(int i=0;i<widget.propertyTotal.property.mapImages["principales"].length;i++){
              var datetime=DateTime.now();
              String nameFile="${datetime.year}${datetime.month}${datetime.day}${datetime.hour}${datetime.minute}${datetime.second}${datetime.millisecond}";
              final tempDir=await getTemporaryDirectory();
              final path='${tempDir.path}/$nameFile.jpg';
              await Dio().download(widget.propertyTotal.property.mapImages["principales"][i], path);
              final imagen = pw.MemoryImage(
                (await readFileByte(path))
              );
              imagenesCategoria.add(imagen);
            }
            mapImagenesFile["principales"]=imagenesCategoria;
            generarPdfImagesMain(widget.propertyTotal,mapImagenesFile)
            .then((value) {
              archivoPdf=value;
              Printing.sharePdf(
              bytes: archivoPdf!, filename: 'Documento.pdf')
              .then((completado){
                if(completado){
                  print("exportado");
                }
              });
            });
          }
              
        }, 
        icon: Icon(
          Icons.share,
          size: SizeDefault.sizeIconButton,
          color:ColorsDefault.colorIcon
        )
      ),
    );
  }
  
  Widget _wPrice() {
    final property=widget.propertyTotal.property;
    return Row(
      children: [
        TextStandard(
          text:"${property.price.toString()}"+r"$",
          fontSize: _fontSizePrice,
          fontWeight: FontWeight.w600
        ),
        property.pricesHistory.length>1?(property.pricesHistory[property.pricesHistory.length-1]<
        property.pricesHistory[property.pricesHistory.length-2]?
        Row(
          children: [
            SizedBox(width: 10*SizeDefault.scaleWidth,),
            TextStandard(
              text:"${property.pricesHistory[property.pricesHistory.length-2].toString()}"+r"$",
              fontSize: _fontSizePriceLowered,
              fontWeight: FontWeight.w500,
              textDecoration: TextDecoration.lineThrough,
              color: ColorsDefault.colorTextError
            ),
          ],
        ):SizedBox()):SizedBox()
      ],
    );
  }
}